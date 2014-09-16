//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Ryan Billard on 12/30/2013.
//  Copyright (c) 2013 Ryan Billard. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"


@implementation PlayingCardDeck

- (instancetype) init
{
    self = [super init];
    
    if(self){
        for (NSString *suit in [PlayingCard validSuits]){
            for(NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
        
    }
    
    return self;
}

@end
