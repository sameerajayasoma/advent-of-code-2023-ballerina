import ballerina/lang.regexp;

type Card record {
    int number;
    map<boolean> winningNumMap;
    string[] numbers;
};

function part1TotalPoints(string[] lines) returns int {
    Card[] cards = parseCardLines(lines);
    int totalPoints = 0;
    foreach var card in cards {
        int points = 0;
        foreach var num in card.numbers {
            if card.winningNumMap.hasKey(num) {
                poingitts = points == 0 ? 1 : points * 2;
            }
        }
        totalPoints += points;
    }
    return totalPoints;
}

function part2TotalCards(string[] lines) returns int {
    Card[] cards = parseCardLines(lines);
    map<int> cardCountMap = {};
    foreach var card in cards {
        increaseCardCountByOne(cardCountMap, card.number, 1);
        int curCardCount = cardCountMap.get(card.number.toString());
        int curCopyCardNo = card.number + 1;
        foreach var num in card.numbers {
            if card.winningNumMap.hasKey(num) {
                increaseCardCountByOne(cardCountMap, curCopyCardNo, curCardCount);    
                curCopyCardNo += 1;
            }
        }
    }
    return getTotalCardCount(cardCountMap);
}

function getTotalCardCount(map<int> cardCountMap) returns int {
    int total = 0;
    foreach var count in cardCountMap {
        total += count;
    }
    return total;
}

function increaseCardCountByOne(map<int> cardCountMap, int cardNumber, int increaseBy = 1) {
    string cardNoStr = cardNumber.toString();
    int count = cardCountMap[cardNoStr] ?: 0;
    count += increaseBy;
    cardCountMap[cardNoStr] = count;
}

function parseCardLines(string[] lines) returns Card[] {
    regexp:RegExp colonRegex = re `:`;
    regexp:RegExp pipeRegex = re `\|`;
    Card[] cards = [];
    int index = 1;
    foreach var line in lines {
        string[] colonParts = colonRegex.split(line);
        string[] pipeParts = pipeRegex.split(colonParts[1].trim());
        string[] winningNum = numbersFromString(pipeParts[0].trim());
        map<boolean> winningNumMap = {};
        foreach var num in winningNum {
            winningNumMap[num] = true;
        }
        string[] numbers = numbersFromString(pipeParts[1].trim());
        cards.push({number: index, winningNumMap, numbers});
        index += 1;
    }
    return cards;
}

function numbersFromString(string numListStr) returns string[] {
    regexp:RegExp spaceRegex = re ` `;
    string[] numStrs = spaceRegex.split(numListStr);
    string[] nums = [];
    foreach var numStr in numStrs {
        if numStr != "" {
            nums.push(numStr);
        }
    }
    return nums;
}
