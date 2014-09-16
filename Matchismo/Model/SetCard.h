//
//  SetCard.h
//  Matchismo
//
//  Created by Ryan Billard on 1/16/2014.
//  Copyright (c) 2014 Ryan Billard. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property (nonatomic)NSInteger numberOfSymbols;
@property (nonatomic)NSInteger symbol;
@property (nonatomic)CGFloat shading;
@property (nonatomic)NSInteger color;

+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;
@end
