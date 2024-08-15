// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentData {
    uint256 private id;
    string private firstName;
    string private lastName;
    uint8 private age;
    string private gender;
    string private program;
    uint256 private grade;

    uint256 private constant DECIMALS = 100; 

    function setID(uint256 _id) public {
        id = _id;
    }

    function getID() public view returns (uint256) {
        return id;
    }

    function setFirstName(string memory _firstName) public {
        firstName = _firstName;
    }

    function getFirstName() public view returns (string memory) {
        return firstName;
    }

    function setLastName(string memory _lastName) public {
        lastName = _lastName;
    }

    function getLastName() public view returns (string memory) {
        return lastName;
    }

    function setAge(uint8 _age) public {
        age = _age;
    }

    function getAge() public view returns (uint8) {
        return age;
    }

    function setGender(string memory _gender) public {
        gender = _gender;
    }

    function getGender() public view returns (string memory) {
        return gender;
    }

    function setProgram(string memory _program) public {
        program = _program;
    }

    function getProgram() public view returns (string memory) {
        return program;
    }

    function setGrade(string memory _grade) public {
        (uint256 integerPart, uint256 fractionalPart) = parseDecimal(_grade);
        grade = integerPart * DECIMALS + fractionalPart;
    }

    function getGrade() public view returns (string memory) {
        uint256 integerPart = grade / DECIMALS;
        uint256 fractionalPart = grade % DECIMALS;
        return string(abi.encodePacked(
            uintToString(integerPart), ".",
            fractionalPart < 10 ? "0" : "", 
            uintToString(fractionalPart)
        ));
    }

    function getFullName() public view returns (string memory, string memory) {
        return (firstName, lastName);
    }

    function getStudentDetails() public view returns (
        uint256, string memory, string memory, uint8, string memory, string memory, string memory
    ) {
        return (id, firstName, lastName, age, gender, program, getGrade());
    }

    function uintToString(uint256 _value) internal pure returns (string memory) {
        if (_value == 0) return "0";
        uint256 temp = _value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (_value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + _value % 10));
            _value /= 10;
        }
        return string(buffer);
    }

    function parseDecimal(string memory _value) internal pure returns (uint256, uint256) {
        bytes memory valueBytes = bytes(_value);
        uint256 dotIndex = valueBytes.length; // Default to end if no dot
        uint256 integerPart;
        uint256 fractionalPart;

        for (uint256 i = 0; i < valueBytes.length; i++) {
            if (valueBytes[i] == '.') {
                dotIndex = i;
                break;
            }
        }

        for (uint256 i = 0; i < dotIndex; i++) {
            integerPart = integerPart * 10 + uint256(uint8(valueBytes[i])) - 48;
        }

        if (dotIndex < valueBytes.length - 1) {
            for (uint256 i = dotIndex + 1; i < valueBytes.length; i++) {
                fractionalPart = fractionalPart * 10 + uint256(uint8(valueBytes[i])) - 48;
            }
            uint256 fractionalDigits = valueBytes.length - dotIndex - 1;
            if (fractionalDigits < 2) {
                fractionalPart *= 10 ** (2 - fractionalDigits);
            }
        }

        return (integerPart, fractionalPart);
    }
}
