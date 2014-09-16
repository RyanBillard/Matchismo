//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Ryan Billard on 12/29/2013.
//  Copyright (c) 2013 Ryan Billard. All rights reserved.
//

#import "CardGameViewController.h"
#import "Grid.h"


@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UIView *gridView;
@property (strong, nonatomic) NSMutableArray *cardViews;
@property (nonatomic, strong) Deck *deck;
@property (weak, nonatomic) IBOutlet UIButton *reDealButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSwitch;
@property (nonatomic) NSInteger previousScore;
@property (strong, nonatomic) Grid *grid;
@property (strong, nonatomic) UIDynamicAnimator *pileAnimator;
@property (strong, nonatomic) UIAttachmentBehavior *attachment;

@end

@implementation CardGameViewController

- (Grid *)grid{
    if(!_grid){
        _grid = [[Grid alloc] init];
        _grid.cellAspectRatio = self.maxCardSize.width / self.maxCardSize.height;
        _grid.minimumNumberOfCells = self.numberOfStartingCards;
        _grid.maxCellWidth = self.maxCardSize.width;
        _grid.maxCellHeight = self.maxCardSize.height;
        _grid.size = self.gridView.frame.size;
    }
    return _grid;
}


- (IBAction)gatherCardsIntoPile:(UIPinchGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateChanged || sender.state == UIGestureRecognizerStateEnded) {
        if (!self.pileAnimator) {
            CGPoint center = [sender locationInView:self.gridView];
            self.pileAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gridView];
            for (UIView *cardView in self.cardViews) {
                UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:cardView snapToPoint:center];
                [self.pileAnimator addBehavior:snap];
            }
        }
    }
}

- (IBAction)panCardPile:(UIPanGestureRecognizer *)sender
{
    if (self.pileAnimator) {
        CGPoint gesturePoint = [sender locationInView:self.gridView];
        if (sender.state == UIGestureRecognizerStateBegan) {
            [self attachViewsToPoint:gesturePoint];
        }else if (sender.state == UIGestureRecognizerStateChanged){
            self.attachment.anchorPoint = gesturePoint;
        } else if (sender.state == UIGestureRecognizerStateEnded) {
            [self endPan];
        }
    }
    
}

- (void)endPan
{
    [self.pileAnimator removeBehavior:self.attachment];
    for (UIView *cardView in self.cardViews){
        [cardView setHidden:NO];
    }
}

- (void)attachViewsToPoint:(CGPoint) anchorPoint
{
    UIView *attachedView = [self.cardViews firstObject];
    self.attachment = [[UIAttachmentBehavior alloc] initWithItem:attachedView attachedToAnchor:anchorPoint];
    [self.pileAnimator addBehavior:self.attachment];
    for (UIView *cardView in self.cardViews){
        if (cardView != attachedView){
            [cardView setHidden:YES];
        }
    }
}

- (NSMutableArray *)cardViews{
    if(!_cardViews) _cardViews = [NSMutableArray arrayWithCapacity:self.numberOfStartingCards];
    return _cardViews;
}

- (CardMatchingGame *)game{
    if(!_game){
        _game = [[CardMatchingGame alloc] initWithCardCount:self.numberOfStartingCards  usingDeck:[self createDeck]];
        self.previousScore = 0;
        self.gameModeSwitch.enabled = YES;
        self.gameModeSwitch.selectedSegmentIndex = 1;
        [self updateUI];
    }
    return _game;
}

-(Deck *)createDeck //abstract
{
    return nil;
}

- (IBAction)valueChangeGameModeSwitch:(id)sender
{
    [self.game switchMode];
}

- (IBAction)touchReDealButton:(UIButton *)sender {
    int delayMultiplier = 0;
    for (UIView *subView in self.cardViews){
        
        [UIView animateWithDuration:1.0 delay:0.125 * delayMultiplier++ options:UIViewAnimationOptionCurveEaseInOut animations:^{
            subView.frame = CGRectMake(0 - self.grid.cellSize.width, self.gridView.bounds.size.height + self.grid.cellSize.height, self.grid.cellSize.width, self.grid.cellSize.height);
        }completion:^(BOOL finished){
            [subView removeFromSuperview];
            [self.cardViews removeObject:subView];
            if([self.cardViews count] == 0){
                self.cardViews = nil;
                self.game = nil;
                [self game];
                self.pileAnimator = nil;
                [self updateUI];
            }
        }];
    }
}

- (void)touchCard:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded){
        self.gameModeSwitch.enabled = NO;
        if (!self.pileAnimator) {
            [self.game chooseCardAtIndex:gesture.view.tag];
        }
        self.pileAnimator = nil;
        [self updateUI];
    }
}


#define CARDSPACINGINPERCENT 0.08

- (void)updateUI{
    int deletedViews = 0;
    for (NSUInteger cardIndex = 0; cardIndex < self.game.numberofDealtCards; cardIndex++) {
        Card *card = [self.game cardAtIndex:cardIndex];
        NSUInteger viewIndex = [self.cardViews indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if([obj isKindOfClass:[UIView class]]){
                if(((UIView *)obj).tag == cardIndex) return YES;
            }
            return NO;
        }];
        UIView *cardView;
        if(viewIndex == NSNotFound){
            if(!card.matched){
                cardView = [self createViewForCard:card];
                cardView.tag = cardIndex;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCard:)];
                [cardView addGestureRecognizer:tap];
                [self.cardViews addObject:cardView];
                viewIndex = [self.cardViews indexOfObject:cardView];
                [self.gridView addSubview:cardView];
            }
        } else {
            //Update view for card, even if it's matched (for animation)
            cardView = self.cardViews[viewIndex];
            [self updateView:cardView forCard:card];
        }
        
        if (card.matched && cardView != nil){
            deletedViews++;
            [self removeCardView:cardView withDelay:deletedViews];
        }
    }
    
    self.grid.minimumNumberOfCells = [self.cardViews count];
    int changedViews = 0, addedViews = 0;  //For delay
    for (NSUInteger viewIndex = 0; viewIndex < [self.cardViews count]; viewIndex++) {
        CGRect frame = [self.grid frameOfCellAtRow:viewIndex / self.grid.columnCount inColumn:viewIndex % self.grid.columnCount];
        frame = CGRectInset(frame, frame
                            .size.width * CARDSPACINGINPERCENT, frame.size.height * CARDSPACINGINPERCENT);
        CGPoint center = [self.grid centerOfCellAtRow:viewIndex / self.grid.columnCount inColumn:viewIndex % self.grid.columnCount];
        UIView *cardView = self.cardViews[viewIndex];
        if (!cardView.center.x && !cardView.center.y) {
            //Card has not been initialized, animate entrance from bottom right
            cardView.frame = CGRectMake(self.gridView.bounds.size.width, self.gridView.bounds.size.height, self.grid.minCellWidth, self.grid.minCellHeight);
            [UIView animateWithDuration:1.0 delay:0.125 * addedViews++ options:UIViewAnimationOptionCurveEaseInOut animations:^{
                cardView.frame = frame;
            }completion:nil];
        } else if (cardView.center.x != center.x || cardView.center.y != center.y){
                //Frame has changed
            [UIView animateWithDuration:0.5 delay:0.125 * changedViews++ options:UIViewAnimationOptionCurveEaseInOut animations:^{
                cardView.frame = frame;
            } completion:nil];
        }
    }
    
    self.scoreLabel.text = [NSString stringWithFormat: @"Score: %ld", (long)self.game.score];
    self.previousScore = self.game.score;
    
}

- (void)removeCardView:(UIView *)cardView withDelay:(int)delayMultiplier
{
    [self.cardViews removeObject:cardView];
    [UIView animateWithDuration:1.0 delay:0.125 * delayMultiplier options:UIViewAnimationOptionCurveEaseInOut animations:^{
        cardView.frame = CGRectMake(0 - self.grid.cellSize.width, self.gridView.bounds.size.height + self.grid.cellSize.height, self.grid.cellSize.width, self.grid.cellSize.height);
    }completion:^(BOOL finished){
        [cardView removeFromSuperview];
    }];
}


- (void)viewDidLayoutSubviews
{
    self.grid.size = self.gridView.bounds.size;
    self.pileAnimator = nil;
    [self updateUI];

}

//Overriden methods


- (UIView *)createViewForCard:(Card *)card{
    UIView *view = [[UIView alloc] init];
    [self updateView: view forCard:card];
    return view;
}

- (void)updateView:(UIView *)view forCard:(Card *)card
{
    view.backgroundColor = [UIColor blueColor];
}






@end
