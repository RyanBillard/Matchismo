//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Ryan Billard on 1/15/2014.
//  Copyright (c) 2014 Ryan Billard. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (void) viewDidLoad{
    [super viewDidLoad];
    self.numberOfStartingCards = 35;
    self.maxCardSize = CGSizeMake(80.0, 120.0);
    [self game];
}

- (UIView *)createViewForCard:(Card *)card
{
    PlayingCardView *view = [[PlayingCardView alloc] init];
    [self updateView:view forCard:card];
    return view;
}

- (void)updateView:(UIView *)view forCard:(Card *)card
{
    if (![card isKindOfClass:[PlayingCard class]]) return;
    if (![view isKindOfClass:[PlayingCardView class]]) return;
    PlayingCard *playingCard = (PlayingCard *)card;
    PlayingCardView *playingCardView = (PlayingCardView *)view;
    playingCardView.rank = playingCard.rank;
    playingCardView.suit = playingCard.suit;
    if (playingCardView.faceUp != playingCard.chosen){
        [UIView transitionWithView:playingCardView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
    }
    playingCardView.faceUp = playingCard.chosen;
    
}




@end
