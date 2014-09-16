//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Ryan Billard on 1/1/2014.
//  Copyright (c) 2014 Ryan Billard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)drawNewCard;
- (void)switchMode;
 
@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, strong, readonly) NSMutableArray *selectedCards;
@property (nonatomic, readonly) NSUInteger numberofDealtCards;
@property (nonatomic, readonly) NSInteger gameMode;
@property (nonatomic, readonly) BOOL isDeckEmpty;

@end
