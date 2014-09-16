//
//  Card.m
//  Matchismo
//
//  Created by Ryan Billard on 12/29/2013.
//  Copyright (c) 2013 Ryan Billard. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for( Card *card in otherCards)
    {
        if([card.contents isEqualToString:self.contents])
        {
            score = 1;
        }
    }
    
    return score;
}

@end
