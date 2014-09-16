//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Ryan Billard on 12/29/2013.
//  Copyright (c) 2013 Ryan Billard. All rights reserved.
//
//Abstract class, must implement methods below

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController


//protected
//for subclasses
@property (nonatomic, strong) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *gameStateLabel;
@property (nonatomic) NSUInteger numberOfStartingCards;
@property (nonatomic) CGSize maxCardSize;

- (Deck *)createDeck; //abstract
- (void)updateView:(UIView *)view forCard:(Card *)card;
- (void)updateUI;
- (UIView *)createViewForCard:(Card *)card;

@end
