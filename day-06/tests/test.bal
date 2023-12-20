import ballerina/test;
import ballerina/io;

@test:Config
function testPart1SumOfWaysToBeetTheRecordSampleInput() returns error? {
    string[] fileReadLines = check io:fileReadLines("tests/input.txt");
    int actualSum = part1MuliplicationOfWaysToBeetTheRecord(fileReadLines);
    test:assertEquals(actualSum, 288);
}

@test:Config
function testPart1SumOfWaysToBeetTheRecordRealInput() returns error? {
    string[] fileReadLines = check io:fileReadLines("input.txt");
    int actualSum = part1MuliplicationOfWaysToBeetTheRecord(fileReadLines);
    test:assertEquals(actualSum, 449820);
}

@test:Config
function testPart2SumOfWaysToBeetTheRecordSampleInput() returns error? {
    string[] fileReadLines = check io:fileReadLines("tests/input.txt");
    int actualSum = part2MuliplicationOfWaysToBeetTheRecord(fileReadLines);
    test:assertEquals(actualSum, 71503);
}

@test:Config
function testPart2SumOfWaysToBeetTheRecordRealInput() returns error? {
    string[] fileReadLines = check io:fileReadLines("input.txt");
    int actualSum = part2MuliplicationOfWaysToBeetTheRecord(fileReadLines);
    test:assertEquals(actualSum, 42250895);
}