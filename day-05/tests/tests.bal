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