//
//  GameHistoryViewController.m
//  Matchismo
//
//  Created by Ryan Billard on 1/18/2014.
//  Copyright (c) 2014 Ryan Billard. All rights reserved.
//

#import "GameHistoryViewController.h"

@interface GameHistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;
@end

@implementation GameHistoryViewController

- (void)setHistoryText:(NSAttributedString *)historyText
{
    _historyText = historyText;
    if(self.view.window) [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI
{
    [self.historyTextView setAttributedText:self.historyText];
}
@end
