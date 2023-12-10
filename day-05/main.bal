import ballerina/lang.regexp;

type Range record {|
    int srcStart;
    int srcEnd;
    int destStart;
    int destEnd;
|};

type CategoryMap record {|
    string src;
    string dest;
    Range[] ranges = [];
|};

final regexp:RegExp colonRegex = re `:`;
final regexp:RegExp spaceRegex = re ` `;
final regexp:RegExp dashRegex = re `-`;

function part1LowestLocation(string[] lines) returns int {
    string seedsLine = lines[0].substring(7);
    int[] seeds = strToIntArray(seedsLine);

    CategoryMap[] categoryMaps = getCategoryMaps(lines);
    int[] locationNumbers = [];
    foreach int seed in seeds {
        int destNumber = seed;
        foreach var categoryMap in categoryMaps {
            destNumber = findDestNumber(destNumber, categoryMap);
        }
        locationNumbers.push(destNumber);
    }

    return getMin(locationNumbers);
}

function findDestNumber(int srcNumber, CategoryMap categoryMap) returns int {
    foreach Range range in categoryMap.ranges {
        if inSourceRange(srcNumber, range) {
            int diff = srcNumber - range.srcStart;
            return range.destStart + diff;
        }
    }

    return srcNumber;
}

function inSourceRange(int number, Range range) returns boolean {
    return inRange(number, range.srcStart, range.srcEnd);
}

function inRange(int number, int rStart, int rEnd) returns boolean {
    return number >= rStart && number <= rEnd;
}

function getCategoryMaps(string[] lines) returns CategoryMap[] {
    CategoryMap[] categoryMaps = [];
    int index = 2;
    while (index < lines.length()) {
        string mapStartLine = lines[index].substring(0, lines[index].length() - 5);
        string[] srcToDest = dashRegex.split(mapStartLine);
        CategoryMap categoryMap = {src: srcToDest[0], dest: srcToDest[2]};
        categoryMaps.push(categoryMap);
        Range[] ranges = [];
        categoryMap.ranges = ranges;
        index += 1;
        while (index < lines.length() && lines[index] != "") {
            int[] rangeNumbers = strToIntArray(lines[index]);
            ranges.push(getRange(rangeNumbers));
            index += 1;
        }
        index += 1;
    }
    return categoryMaps;
}

function getRange(int[] numbers) returns Range {
    return {
        srcStart: numbers[1],
        srcEnd: numbers[1] + numbers[2] - 1,
        destStart: numbers[0],
        destEnd: numbers[0] + numbers[2] - 1
    };
}

function strToIntArray(string str) returns int[] {
    int[] result = [];
    string[] numStrList = spaceRegex.split(str);
    foreach string numStr in numStrList {
        int num = checkpanic int:fromString(numStr);
        result.push(num);
    }
    return result;
}

function getMin(int[] numbers) returns int {
    if numbers.length() == 1 {
        return numbers[0];
    } else {
        int min = numbers[0];
        int index = 1;
        while (index < numbers.length()) {
            if numbers[index] < min {
                min = numbers[index];
            }
            index += 1;
        }
        return min;
    }
}

