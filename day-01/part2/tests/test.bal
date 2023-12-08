import ballerina/io;
import ballerina/test;

@test:Config
function testSumOfCalibrationValuesWithSampleInput() returns error? {
    string[] fileReadLines = check io:fileReadLines("tests/input.txt");
    int actualSum = sumOfCalibrationValues(fileReadLines);
    test:assertEquals(actualSum, 281);
}

@test:Config
function testSumOfCalibrationValuesWithRealInput() returns error? {
    string[] fileReadLines = check io:fileReadLines("../input.txt");
    int actualSum = sumOfCalibrationValues(fileReadLines);
    test:assertEquals(actualSum, 54885);
}

@test:Config {
    dataProvider: data
}
function testTokenize(string input, string[] expectedTokens) {
    Tokenizer tokenizer = {input};
    string[] actualTokens = tokenize(tokenizer);
    test:assertEquals(actualTokens, expectedTokens);
}

function data() returns [string, string[]][]|error {
    return [
        ["one", ["1"]],
        ["two", ["2"]],
        ["three", ["3"]],
        ["four", ["4"]],
        ["five", ["5"]],
        ["six", ["6"]],
        ["seven", ["7"]],
        ["eight", ["8"]],
        ["nine", ["9"]],
        ["ffonef", ["1"]],
        ["fftwof", ["2"]],
        ["ffthreef", ["3"]],
        ["fffourf", ["4"]],
        ["fffivef", ["5"]],
        ["ffsixf", ["6"]],
        ["ffsevenf", ["7"]],
        ["ffeightf", ["8"]],
        ["ffninef", ["9"]],
        ["ffonefftwoeethree", ["1", "2", "3"]],
        ["ffonefftwoeethreefffourf", ["1", "2", "3", "4"]],
        ["ffonefftwoeethreefffourfffivef", ["1", "2", "3", "4", "5"]],
        ["ffonefftwoeethreefffourfffiveffsixf", ["1", "2", "3", "4", "5", "6"]],
        ["ffonefftwoeethreefffourfffiveffsixffsevenf", ["1", "2", "3", "4", "5", "6", "7"]],
        ["ffonefftwoeethreefffourfffiveffsixffsevenffeightf", ["1", "2", "3", "4", "5", "6", "7", "8"]],
        ["ffonefftwoeethreefffourfffiveffsixffsevenffeightffninef", ["1", "2", "3", "4", "5", "6", "7", "8", "9"]],
        ["ffonefftwoeethreefffourfffiveffsixffsevenffeightffninefftenf", ["1", "2", "3", "4", "5", "6", "7", "8", "9"]],
        ["ffonefftwoeethreefffo8urfffiveffsixffsevenffeightffninefftenffelevenf", ["1", "2", "3", "8", "5", "6", "7", "8", "9"]],
        ["ffonefftwoeethreefffourfffiveffsixffsevenffeightffninefftenffelevenfftwelvef", ["1", "2", "3", "4", "5", "6", "7", "8", "9"]],
        ["ffonefftwoeethreefffourfffiveffsixffsevenffeightffninefftenffelevenfftwelveffthirteenf", ["1", "2", "3", "4", "5", "6", "7", "8", "9"]],
        ["one two", ["1", "2"]],
        ["one two three", ["1", "2", "3"]],
        ["one two 3three four", ["1", "2", "3", "3", "4"]],
        ["one two three four five", ["1", "2", "3", "4", "5"]],
        ["one two three four five six", ["1", "2", "3", "4", "5", "6"]],
        ["one two three four five six seven", ["1", "2", "3", "4", "5", "6", "7"]],
        ["one two three four five six seven eight", ["1", "2", "3", "4", "5", "6", "7", "8"]],
        ["one two three four five six seven eight nine", ["1", "2", "3", "4", "5", "6", "7", "8", "9"]],
        ["one two three four five six seven eight nine ten", ["1", "2", "3", "4", "5", "6", "7", "8", "9"]],
        ["one two three four five six seven eight nine ten eleven", ["1", "2", "3", "4", "5", "6", "7", "8", "9"]],
        ["one two three four five six seven eight nine ten eleven twelve", ["1", "2", "3", "4", "5", "6", "7", "8", "9"]],
        ["one two three four five six seven eight nine ten eleven twelve thirteen", ["1", "2", "3", "4", "5", "6", "7", "8", "9"]],
        ["one two three four five six seven eight nine ten eleven twelve thirteen fourteen", ["1", "2", "3", "4", "5", "6", "7", "8", "9", "4"]],
        ["one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen", ["1", "2", "3", "4", "5", "6", "7", "8", "9", "4"]],
        ["oneight", ["1", "8"]],
        ["twone", ["2", "1"]],
        ["threeight", ["3", "8"]],
        ["fiveight", ["5", "8"]],
        ["sevenine", ["7", "9"]],
        ["eightwo", ["8", "2"]],
        ["eighthree", ["8", "3"]],
        ["nineight", ["9", "8"]]
    ];
}
