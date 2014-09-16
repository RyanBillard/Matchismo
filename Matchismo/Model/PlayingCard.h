//
//  PlayingCard.h
//  Matchismo
//
//  Created by Ryan Billard on 12/29/2013.
//  Copyright (c) 2013 Ryan Billard. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
