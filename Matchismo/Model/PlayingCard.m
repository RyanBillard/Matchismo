//
//  PlayingCard.m
//  Matchismo
//
//  Created by Ryan Billard on 12/29/2013.
//  Copyright (c) 2013 Ryan Billard. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard


- (int)match:(NSArray *)otherCards
{
    int score = 0;
    int selfIndex = (int)[otherCards indexOfObject:self];
    //Start loop at location of current card + 1
    for(int i = selfIndex + 1; i < [otherCards count]; i++){
        Card *card = [otherCards objectAtIndex:i];
        if([card isKindOfClass:[PlayingCard class]]){
            PlayingCard *otherCard = (PlayingCard *) card;
            if([self.suit isEqualToString:otherCard.suit]) {
                score += 1;
            } else if (self.rank == otherCard.rank){
                score += 4;
            }
        }
    }
    if(selfIndex + 1 != [otherCards count]) score += [[otherCards objectAtIndex:(selfIndex +1) ] match:otherCards];
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;
@synthesize rank = _rank;

+ (NSArray *)validSuits
{
    return @[@"♠︎", @"♣︎", @"♥︎", @"♦︎"];
}
- (void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}
- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

- (void)setRank:(NSUInteger)rank
{
    if(rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

@end
