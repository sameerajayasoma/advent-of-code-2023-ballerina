import ballerina/test;
import ballerina/io;

@test:Config
function testPart1TotalPointsWithSampleInput() returns error? {
    string[] fileReadLines = check io:fileReadLines("tests/input.txt");
    int actualSum = part1TotalPoints(fileReadLines);
    test:assertEquals(actualSum, 13);
}

@test:Config
function testPart1TotalPointsWithRealInput() returns error? {
    string[] fileReadLines = check io:fileReadLines("input.txt");
    int actualSum = part1TotalPoints(fileReadLines);
    test:assertEquals(actualSum, 33950);
}


@test:Config
function testPart2TotalCardsWithSampleInput() returns error? {
    string[] fileReadLines = check io:fileReadLines("tests/input.txt");
    int actualSum = part2TotalCards(fileReadLines);
    test:assertEquals(actualSum, 30);
}

@test:Config
function testPart2TotalCardsWithRealInput() returns error? {
    string[] fileReadLines = check io:fileReadLines("input.txt");
    int actualSum = part2TotalCards(fileReadLines);
    test:assertEquals(actualSum, 14814534);
}

