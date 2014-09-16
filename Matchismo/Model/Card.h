//
//  Card.h
//  Matchismo
//
//  Created by Ryan Billard on 12/29/2013.
//  Copyright (c) 2013 Ryan Billard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
