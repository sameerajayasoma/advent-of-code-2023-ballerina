// import ballerina/io;
import ballerina/lang.regexp;

const MAX_RED = 12;
const MAX_GREEN = 13;
const MAX_BLUE = 14;

type Play record {|
    int red = 0;
    int green = 0;
    int blue = 0;
|};

type Game record {|
    int gameId;
    Play[] plays;
|};

public function part1SumOfPosibleGameIds(string[] games) returns int {
    int sum = 0;
    int index = 0;
    foreach var gameStr in games {
        index += 1;
        regexp:RegExp colonRegex = re `:`;
        string[] parts = colonRegex.split(gameStr);
        string playStr = parts[1].trim();
        Game game = parseGame(index, playStr);
        if gamePossible(game) {
            sum += game.gameId;
        }
    }
    return sum;
}

function part2SumOfPowerOfMinSet(string[] games) returns int {
    int sum = 0;
    int index = 0;
    foreach var gameStr in games {
        index += 1;
        regexp:RegExp colonRegex = re `:`;
        string[] parts = colonRegex.split(gameStr);
        string playStr = parts[1].trim();
        Game game = parseGame(index, playStr);

        int maxRed = 0;
        int maxGreen = 0;
        int maxBlue = 0;
        foreach var play in game.plays {
            maxRed = int:max(play.red, maxRed);
            maxGreen = int:max(play.green, maxGreen);
            maxBlue = int:max(play.blue, maxBlue); 
        }
        sum += maxRed * maxGreen * maxBlue;
    }
    return sum;
}

function gamePossible(Game game) returns boolean {
    foreach var play in game.plays {
        if play.red > MAX_RED || play.green > MAX_GREEN || play.blue > MAX_BLUE {
            return false;
        }   
    }
    return true;
}

function parseGame(int gameId, string playStr) returns Game {
    Play[] plays = [];
    int index = 0;
    Play play = {};
    int num = 0;
    while (index < playStr.length()) {
        string:Char c = playStr[index];
        match c {
            "0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9" => {
                string numStr = "";
                while (c != " "){
                    numStr += c;
                    index += 1;
                    c = playStr[index];
                }
                index += 1;
                num = checkpanic int:fromString(numStr);
            }

            "r" => {
                play.red = num;
                num = 0;
                index += 3;
            }

            "g" => {
                play.green = num;
                num = 0;
                index += 5;
            }

            "b" => {
                play.blue = num;
                num = 0;
                index += 4;
            }

            ";" => {
                plays.push(play);
                play = {};
                index += 1;
            }

            _ => {
                index += 1;
            }
        }
    }
    plays.push(play);
    return {gameId: gameId, plays: plays};
}

