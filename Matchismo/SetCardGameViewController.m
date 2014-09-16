//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Ryan Billard on 1/16/2014.
//  Copyright (c) 2014 Ryan Billard. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardView.h"

@interface SetCardGameViewController ()
@property (weak, nonatomic) IBOutlet UIButton *addCardsButton;

@end

@implementation SetCardGameViewController

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.numberOfStartingCards = 12;
    self.maxCardSize = CGSizeMake(120.0, 120.0);
    [self game];
}

- (UIView *)createViewForCard:(Card *)card{
    SetCardView *view = [[SetCardView alloc] init];
    [self updateView:view forCard:card];
    return view;
}

- (void)updateView:(UIView *)view forCard:(Card *)card{
    if(![card isKindOfClass:[SetCard class]]) return;
    if(![view isKindOfClass:[SetCardView class]]) return;
    SetCard *setCard = (SetCard *)card;
    SetCardView *setCardView = (SetCardView *)view;
    setCardView.color = setCard.color;
    setCardView.symbol = setCard.symbol;
    setCardView.numberOfSymbols = setCard.numberOfSymbols;
    setCardView.shading = setCard.shading;
    setCardView.faceUp = setCard.chosen;
}

- (IBAction)touchAddCardsButton:(UIButton *)sender{
    for (int i = 0; i < sender.tag; i++){
        [self.game drawNewCard];
    }
    if(self.game.isDeckEmpty){
        sender.enabled = NO;
        sender.alpha = 0.5;
    }
    [self updateUI];
}
@end
