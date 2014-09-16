//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Ryan Billard on 1/16/2014.
//  Copyright (c) 2014 Ryan Billard. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype) init
{
    self = [super init];
    
    if(self){
        for (int symbolIndex = 1; symbolIndex <= [[SetCard validSymbols] count]; symbolIndex++){
            for (int colorIndex = 1; colorIndex <= [[SetCard validColors] count]; colorIndex++){
                for (int shadeIndex = 1; shadeIndex <= [[SetCard validShadings] count]; shadeIndex++) {
                    for (int numberOfSymbolsIndex = 1; numberOfSymbolsIndex <= 3; numberOfSymbolsIndex++){
                        SetCard *card = [[SetCard alloc] init];
                        card.symbol = symbolIndex;
                        card.color = colorIndex;
                        card.shading = shadeIndex;
                        card.numberOfSymbols = numberOfSymbolsIndex;
                        card.matched = NO;
                        card.chosen = NO;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}


@end
