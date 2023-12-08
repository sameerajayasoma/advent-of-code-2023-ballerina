import ballerina/test;
import ballerina/io;

@test:Config
function testPart1SumOfPosibleGameIdsWithSampleInput() returns error? {
    string[] fileReadLines = check io:fileReadLines("tests/input.txt");
    int actualSum = part1SumOfPosibleGameIds(fileReadLines);
    test:assertEquals(actualSum, 8);
}

@test:Config
function testPar2SumOfPosibleGameIdsWithRealInput() returns error? {
    string[] fileReadLines = check io:fileReadLines("input.txt");
    int actualSum = part1SumOfPosibleGameIds(fileReadLines);
    test:assertEquals(actualSum, 2632);
}

@test:Config
function testPart2SumOfPowerOfMinSetWithSampleInput() returns error? {
    string[] fileReadLines = check io:fileReadLines("tests/input.txt");
    int actualSum = part2SumOfPowerOfMinSet(fileReadLines);
    test:assertEquals(actualSum, 2286);
}

@test:Config
function testPar2SumOfPowerOfMinSetWithRealInput() returns error? {
    string[] fileReadLines = check io:fileReadLines("input.txt");
    int actualSum = part2SumOfPowerOfMinSet(fileReadLines);
    test:assertEquals(actualSum, 69629);
}