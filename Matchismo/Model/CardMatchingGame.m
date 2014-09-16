//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Ryan Billard on 1/1/2014.
//  Copyright (c) 2014 Ryan Billard. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, readwrite) NSInteger gameMode;
@property (nonatomic, strong, readwrite) NSMutableArray *selectedCards;
@property (nonatomic, strong) Deck *deck;
@property (nonatomic, readwrite) BOOL isDeckEmpty;
@end

@implementation CardMatchingGame

- (NSUInteger)numberofDealtCards{
    return [self.cards count];
}

- (NSMutableArray *)selectedCards
{
    if(!_selectedCards) _selectedCards = [[NSMutableArray alloc] init];
    return _selectedCards;
}

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck
{
    self = [super init];
    
    if(self){
        for(int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
        }
    }
    
    _deck = deck;
    self.gameMode = 3;
    
    return self;
}

- (void)drawNewCard{
    Card *card = [self.deck drawRandomCard];
    if(card)
        [self.cards addObject:card];
}

- (BOOL)isDeckEmpty{
    Card *card = [self.deck drawRandomCard];
    if(card){
        [self.deck addCard:card];
        return NO;
    }
    return YES;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 3;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card =  [self cardAtIndex:index];
    
    if([self.selectedCards count] == self.gameMode)
        [self.selectedCards removeAllObjects];
    
    if(!card.isMatched){
        if(card.isChosen){
            card.chosen = NO;
            [self.selectedCards removeObject:card];
        } else {
            card.chosen = YES;
            for(Card *otherCard in self.cards) {
                if(otherCard.isChosen && !otherCard.isMatched) {
                        if (![self.selectedCards containsObject:otherCard])
                            [self.selectedCards insertObject:otherCard atIndex:0];
                }
            }
            if([self.selectedCards count] == self.gameMode) {
                Card *matchCard = [self.selectedCards firstObject];
                int matchScore = [matchCard match:self.selectedCards];//breaking point for setcards
                if(matchScore){
                    self.score += matchScore * MATCH_BONUS;
                    for (Card *otherCard in self.selectedCards){
                        otherCard.matched = YES;
                    }
                }else{
                    self.score -= MISMATCH_PENALTY;
                    for (Card *otherCard in self.selectedCards){
                        otherCard.matched = NO;
                        if(otherCard != card)
                            otherCard.chosen = NO;
                    }
                }
            }
            self.score -= COST_TO_CHOOSE;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)switchMode
{
    self.gameMode = (self.gameMode == 2) ? 3 : 2;
}


- (instancetype) init
{
    return nil;
}
@end
