import ballerina/io;
import ballerina/test;

@test:Config
function testPart1SumOfAllPartNumbersWithSampleInput() returns error? {
    string[] fileReadLines = check io:fileReadLines("tests/input.txt");
    int actualSum = part1SumOfAllPartNumbers(fileReadLines);
    test:assertEquals(actualSum, 4361);
}

@test:Config
function testPart1SumOfAllPartNumbersWithRealInput() returns error? {
    string[] fileReadLines = check io:fileReadLines("input.txt");
    int actualSum = part1SumOfAllPartNumbers(fileReadLines);
    test:assertEquals(actualSum, 536202);
}

@test:Config {
    dataProvider: dataForNumberFromDigits
}
function testNumberFromDigits(int[] digits, int expectedNumber) {
    int actualNumber = numberFromDigits(digits);
    test:assertEquals(actualNumber, expectedNumber);
}

function dataForNumberFromDigits() returns [int[], int][] {
    return [
        [[1], 1],
        [[1, 2], 12],
        [[1, 0, 2], 102],
        [[1, 2, 3], 123],
        [[1, 2, 3, 4], 1234],
        [[1, 2, 3, 4, 5], 12345],
        [[1, 2, 3, 4, 5, 6], 123456],
        [[1, 2, 3, 4, 5, 6, 7], 1234567],
        [[1, 2, 3, 4, 5, 6, 7, 8], 12345678],
        [[1, 2, 3, 4, 5, 6, 7, 8, 9], 123456789]
    ];
}
