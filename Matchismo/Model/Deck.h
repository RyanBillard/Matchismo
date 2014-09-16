//
//  Deck.h
//  Matchismo
//
//  Created by Ryan Billard on 12/30/2013.
//  Copyright (c) 2013 Ryan Billard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
