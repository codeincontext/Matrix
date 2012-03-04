//
//  LawrenceSans.m
//  Matrix
//
//  Created by Adam Howard on 04/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LawrenceSans.h"

@implementation LawrenceSans

+ (NSArray *)getBytesFor:(unichar)character{
    
    NSLog(@"char is %c", character);
    if (character == 'a') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b01111110],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],nil];
    }
    if (character == 'b') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == 'c') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == 'd') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111100],
                [NSNumber numberWithInt:0b10000010],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000010],
                [NSNumber numberWithInt:0b11111100],nil];
    }
    if (character == 'e') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == 'f') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],nil];
    }
    if (character == 'g') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10011111],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == 'h') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],nil];
    }
    if (character == 'i') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == 'j') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b00001000],
                [NSNumber numberWithInt:0b00001000],
                [NSNumber numberWithInt:0b00001000],
                [NSNumber numberWithInt:0b00001000],
                [NSNumber numberWithInt:0b00001000],
                [NSNumber numberWithInt:0b00001000],
                [NSNumber numberWithInt:0b11111000],nil];
    }
    if (character == 'k') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000010],
                [NSNumber numberWithInt:0b10000100],
                [NSNumber numberWithInt:0b10011000],
                [NSNumber numberWithInt:0b11100000],
                [NSNumber numberWithInt:0b10011000],
                [NSNumber numberWithInt:0b10000110],
                [NSNumber numberWithInt:0b10000001],nil];
    }
    if (character == 'l') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == 'm') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b11000011],
                [NSNumber numberWithInt:0b10100101],
                [NSNumber numberWithInt:0b10011001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],nil];
    }
    if (character == 'n') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b11000001],
                [NSNumber numberWithInt:0b10100001],
                [NSNumber numberWithInt:0b10010001],
                [NSNumber numberWithInt:0b10001001],
                [NSNumber numberWithInt:0b10000101],
                [NSNumber numberWithInt:0b10000011],
                [NSNumber numberWithInt:0b10000001],nil];
    }
    if (character == 'o') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == 'p') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],nil];
    }
    if (character == 'q') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10001001],
                [NSNumber numberWithInt:0b10000101],
                [NSNumber numberWithInt:0b10000011],
                [NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == 'r') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111110],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b11000000],
                [NSNumber numberWithInt:0b10110000],
                [NSNumber numberWithInt:0b10001100],
                [NSNumber numberWithInt:0b10000011],nil];
    }
    if (character == 's') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b00000001],
                [NSNumber numberWithInt:0b00000001],
                [NSNumber numberWithInt:0b00000001],
                [NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == 't') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],nil];
    }
    if (character == 'u') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == 'v') {
        return [NSArray arrayWithObjects:[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b01000010],[NSNumber numberWithInt:0b00100100],[NSNumber numberWithInt:0b00011000],nil];
    }
    if (character == 'w') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10011001],
                [NSNumber numberWithInt:0b10100101],
                [NSNumber numberWithInt:0b11000011],
                [NSNumber numberWithInt:0b10000001],nil];
    }
    if (character == 'x') {
        return [NSArray arrayWithObjects:[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b01000010],[NSNumber numberWithInt:0b00100100],[NSNumber numberWithInt:0b00011000],[NSNumber numberWithInt:0b00011000],[NSNumber numberWithInt:0b00100100],[NSNumber numberWithInt:0b01000010],[NSNumber numberWithInt:0b10000001],nil];
    }
    if (character == 'y') {
        return [NSArray arrayWithObjects:[NSNumber numberWithInt:0b10000001],[NSNumber numberWithInt:0b01000010],[NSNumber numberWithInt:0b00100100],[NSNumber numberWithInt:0b00011000],[NSNumber numberWithInt:0b00010000],[NSNumber numberWithInt:0b00100000],[NSNumber numberWithInt:0b01000000],[NSNumber numberWithInt:0b10000000],nil];
    }
    if (character == 'z') {
        return [NSArray arrayWithObjects:[NSNumber numberWithInt:0b11111111],[NSNumber numberWithInt:0b00000010],[NSNumber numberWithInt:0b00000100],[NSNumber numberWithInt:0b00001000],[NSNumber numberWithInt:0b00010000],[NSNumber numberWithInt:0b00100000],[NSNumber numberWithInt:0b01000000],[NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == '.') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b11000000],
                [NSNumber numberWithInt:0b11000000],nil];
    }
    if (character == ',') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b01000000],
                [NSNumber numberWithInt:0b10000000],nil];
    }
    if (character == '!') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b10000000],nil];
    }
    if (character == '#') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b00100100],
                [NSNumber numberWithInt:0b00100100],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b00100100],
                [NSNumber numberWithInt:0b00100100],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b00100100],
                [NSNumber numberWithInt:0b00100100],nil];
    }
    if (character == '@') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b01111110],
                [NSNumber numberWithInt:0b10000001],
                [NSNumber numberWithInt:0b10011001],
                [NSNumber numberWithInt:0b10100101],
                [NSNumber numberWithInt:0b10100101],
                [NSNumber numberWithInt:0b10011110],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b01111111],nil];
    }
    if (character == ':') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],nil];
    }
    if (character == '/') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b00000001],
                [NSNumber numberWithInt:0b00000010],
                [NSNumber numberWithInt:0b00000100],
                [NSNumber numberWithInt:0b00001000],
                [NSNumber numberWithInt:0b00010000],
                [NSNumber numberWithInt:0b00100000],
                [NSNumber numberWithInt:0b01000000],
                [NSNumber numberWithInt:0b10000000],nil];
    }
    if (character == ';') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b01000000],
                [NSNumber numberWithInt:0b01000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b01000000],
                [NSNumber numberWithInt:0b10000000],nil];
    }
    if (character == '>') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11000000],
                [NSNumber numberWithInt:0b00110000],
                [NSNumber numberWithInt:0b00001100],
                [NSNumber numberWithInt:0b00000011],
                [NSNumber numberWithInt:0b00000011],
                [NSNumber numberWithInt:0b00001100],
                [NSNumber numberWithInt:0b00110000],
                [NSNumber numberWithInt:0b11000000],nil];
    }
    if (character == '~') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b01100000],
                [NSNumber numberWithInt:0b10011001],
                [NSNumber numberWithInt:0b00000110],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],nil];
    }
    if (character == '-') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],nil];
    }
    if (character == '_') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b11111111],nil];
    }
    if (character == '+') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],
                [NSNumber numberWithInt:0b00011000],nil];
    }
    if (character == '=') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b11111111],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],nil];
    }
    if (character == '(') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b00100000],
                [NSNumber numberWithInt:0b01000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b01000000],
                [NSNumber numberWithInt:0b00100000],nil];
    }
    if (character == ')') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b00000100],
                [NSNumber numberWithInt:0b00000010],
                [NSNumber numberWithInt:0b00000001],
                [NSNumber numberWithInt:0b00000001],
                [NSNumber numberWithInt:0b00000001],
                [NSNumber numberWithInt:0b00000001],
                [NSNumber numberWithInt:0b00000010],
                [NSNumber numberWithInt:0b00000100],nil];
    }
    if (character == '[') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b11110000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b10000000],
                [NSNumber numberWithInt:0b11110000],nil];
    }
    if (character == ']') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b00001111],
                [NSNumber numberWithInt:0b00000001],
                [NSNumber numberWithInt:0b00000001],
                [NSNumber numberWithInt:0b00000001],
                [NSNumber numberWithInt:0b00000001],
                [NSNumber numberWithInt:0b00000001],
                [NSNumber numberWithInt:0b00000001],
                [NSNumber numberWithInt:0b00001111],nil];
    }
    
    if (character == '"') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b01100110],
                [NSNumber numberWithInt:0b01100110],
                [NSNumber numberWithInt:0b01100110],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],nil];
    }
    if (character == '\'') {
        return [NSArray arrayWithObjects:
                [NSNumber numberWithInt:0b01100000],
                [NSNumber numberWithInt:0b01100000],
                [NSNumber numberWithInt:0b01100000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],
                [NSNumber numberWithInt:0b00000000],nil];
    }
    
    
    NSLog(@"no match");
    return [NSArray arrayWithObjects:
            [NSNumber numberWithInt:0b00000000],
            [NSNumber numberWithInt:0b00000000],
            [NSNumber numberWithInt:0b00000000],
            [NSNumber numberWithInt:0b00000000],
            [NSNumber numberWithInt:0b00000000],
            [NSNumber numberWithInt:0b00000000],
            [NSNumber numberWithInt:0b00000000],
            [NSNumber numberWithInt:0b00000000],nil];
}

@end
