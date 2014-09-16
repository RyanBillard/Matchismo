//
//  SetCard.m
//  Matchismo
//
//  Created by Ryan Billard on 1/16/2014.
//  Copyright (c) 2014 Ryan Billard. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize symbol = _symbol;
@synthesize numberOfSymbols = _numberOfSymbols;
@synthesize shading = _shading;
@synthesize color = _color;

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    //int selfIndex = [otherCards indexOfObject:self];
    SetCard *cardTwo = (SetCard *)otherCards[1];
    SetCard *cardThree = (SetCard *)otherCards[2];
    if((self.symbol == cardTwo.symbol && self.symbol == cardThree.symbol)||(self.symbol != cardTwo.symbol && self.symbol != cardThree.symbol && cardTwo.symbol != cardThree.symbol)){
        //symbols valid
        if((self.numberOfSymbols == cardTwo.numberOfSymbols && self.numberOfSymbols == cardThree.numberOfSymbols)||(self.numberOfSymbols != cardTwo.numberOfSymbols && self.numberOfSymbols != cardThree.numberOfSymbols && cardTwo.numberOfSymbols != cardThree.numberOfSymbols)){
            //number of symbols valid
            if((self.shading == cardTwo.shading && self.shading == cardThree.shading)||(self.shading != cardTwo.shading && self.shading != cardThree.shading && cardTwo.shading != cardThree.shading)){
                //shading valid
                if((self.color == cardTwo.color && self.color == cardThree.color)||(self.color != cardTwo.color && self.color != cardThree.color && cardTwo.color != cardThree.color)){
                    //A valid set is found
                    score = 4;
                }
            }
        }
    }
    return score;
}

+ (NSArray *)validSymbols
{
    return @[@1, @2, @3];
}

+ (NSArray *)validShadings
{
    return @[@1, @2, @3];
}

+ (NSArray *)validColors
{
    return @[@1, @2, @3];
}

- (NSString *)contents
{
    return nil;
}

@end
