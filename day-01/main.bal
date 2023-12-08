// const doesn't work yet with string:Char
final string:Char EOL = ";";

function sumOfCalibrationValues(string[] lines) returns int {
    int sum = 0;
    foreach var line in lines {
        Tokenizer tokenizer = {input: line};
        string[] tokens = tokenize(tokenizer);
        string t1 = tokens[0];
        string t2 = tokens[tokens.length() - 1];
        string str = t1 + t2;
        sum += checkpanic int:fromString(str);
    }
    return sum;
}

type Tokenizer record {|
    string input;
    int position = 0;
|};

function peek(Tokenizer tokenizer, int lookahead = 0) returns string:Char {
    int index = tokenizer.position + lookahead;
    if index >= tokenizer.input.length() {
        return EOL;
    }
    return tokenizer.input[index];
}

function advance(Tokenizer tokenizer, int positions = 1) returns string:Char {
    int index = tokenizer.position + positions;
    if index >= tokenizer.input.length() {
        tokenizer.position = tokenizer.input.length();
        return EOL;
    }

    string:Char c = tokenizer.input[tokenizer.position];
    tokenizer.position = index;
    return c;
}

function tokenize(Tokenizer tokenizer) returns string[] {
    string[] tokens = [];
    string token = nextToken(tokenizer);
    while token != EOL {
        tokens.push(token);
        token = nextToken(tokenizer);
    }
    return tokens;
}

function nextToken(Tokenizer tokenizer) returns string {
    string:Char c = peek(tokenizer);
    while c != EOL {
        match c {
            ";" => {
                return EOL;
            }

            "1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9" => {
                _ = advance(tokenizer);
                return c;
            }

            // one
            "o" => {
                _ = advance(tokenizer);
                c = peek(tokenizer);
                if c == "n" {
                    c = peek(tokenizer, 1);
                    if c == "e" {
                        // Advance by only one position instead of 2 to handle the "oneight" case
                        _ = advance(tokenizer, 1);
                        return "1";
                    }
                }
            }

            // two or three
            "t" => {
                _ = advance(tokenizer);
                c = peek(tokenizer);
                if c == "w" {
                    c = peek(tokenizer, 1);
                    if c == "o" {
                        // Advance by only one position instead of 2 to handle the "twone" case
                        _ = advance(tokenizer, 1);
                        return "2";
                    }
                } else if c == "h" {
                    c = peek(tokenizer, 1);
                    if c == "r" {
                        c = peek(tokenizer, 2);
                        if c == "e" {
                            c = peek(tokenizer, 3);
                            if c == "e" {
                                // Advance by only three positions instead of 4 to handle the "threeight" case
                                _ = advance(tokenizer, 3);
                                return "3";
                            }
                        }
                    }
                }
            }

            // four or five
            "f" => {
                _ = advance(tokenizer);
                c = peek(tokenizer);
                if c == "o" {
                    c = peek(tokenizer, 1);
                    if c == "u" {
                        c = peek(tokenizer, 2);
                        if c == "r" {
                            _ = advance(tokenizer, 3);
                            return "4";
                        }
                    }
                } else if c == "i" {
                    c = peek(tokenizer, 1);
                    if c == "v" {
                        c = peek(tokenizer, 2);
                        if c == "e" {
                            // Advance by only two positions instead of 3 to handle the "fiveight" case
                            _ = advance(tokenizer, 2);
                            return "5";
                        }
                    }
                }
            }

            // six or seven
            "s" => {
                _ = advance(tokenizer);
                c = peek(tokenizer);
                if c == "i" {
                    c = peek(tokenizer, 1);
                    if c == "x" {
                        _ = advance(tokenizer, 2);
                        return "6";
                    }
                } else if c == "e" {
                    c = peek(tokenizer, 1);
                    if c == "v" {
                        c = peek(tokenizer, 2);
                        if c == "e" {
                            c = peek(tokenizer, 3);
                            if c == "n" {
                                // Advance by only three positions instead of 4 to handle the "sevenine" case
                                _ = advance(tokenizer, 3);
                                return "7";
                            }
                        }
                    }
                }
            }

            // eight
            "e" => {
                _ = advance(tokenizer);
                c = peek(tokenizer);
                if c == "i" {
                    c = peek(tokenizer, 1);
                    if c == "g" {
                        c = peek(tokenizer, 2);
                        if c == "h" {
                            c = peek(tokenizer, 3);
                            if c == "t" {
                                // Advance by only three positions instead of 4 to handle the "elighttwo" case
                                _ = advance(tokenizer, 3);
                                return "8";
                            }
                        }
                    }
                }
            }

            // nine
            "n" => {
                _ = advance(tokenizer);
                c = peek(tokenizer);
                if c == "i" {
                    c = peek(tokenizer, 1);
                    if c == "n" {
                        c = peek(tokenizer, 2);
                        if c == "e" {
                            // Advance by only two positions instead of 3 to handle the "nineight" case
                            _ = advance(tokenizer, 2);
                            return "9";
                        }
                    }
                }
            }

            _ => {
                _ = advance(tokenizer);
            }
        }
        c = peek(tokenizer);
    }
    return EOL;
}

