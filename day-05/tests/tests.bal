import ballerina/test;
import ballerina/io;

@test:Config
function testPart1LowestLocationWithSampleInput() returns error? {
    string[] fileReadLines = check io:fileReadLines("tests/input.txt");
    int actualSum = part1LowestLocation(fileReadLines);
    test:assertEquals(actualSum, 35);
}

@test:Config
function testPart1LowestLocationWithRealInput() returns error? {
    string[] fileReadLines = check io:fileReadLines("input.txt");
    int actualSum = part1LowestLocation(fileReadLines);
    test:assertEquals(actualSum, 51580674);
}

@test:Config
function testPart2LowestLocationWithSampleInput() returns error? {
    string[] fileReadLines = check io:fileReadLines("tests/input.txt");
    int actualSum = part2LowestLocation(fileReadLines);
    test:assertEquals(actualSum, 46);
}

@test:Config
function testPart2LowestLocationWithRealInput() returns error? {
    string[] fileReadLines = check io:fileReadLines("input.txt");
    int actualSum = part2LowestLocation(fileReadLines);
    test:assertEquals(actualSum, 99751240);
}