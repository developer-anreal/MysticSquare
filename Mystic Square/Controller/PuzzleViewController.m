//
//  ViewController.m
//  Mystic Square
//
//  Created by Anton Serov on 3/22/15.
//  Copyright (c) 2015 hexforge. All rights reserved.
//

#import "PuzzleViewController.h"
#import "PuzzleBoardView.h"

@interface PuzzleViewController ()

@property (nonatomic, weak) IBOutlet PuzzleBoardView *puzzleContainer;

@end

@implementation PuzzleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.puzzleContainer createPuzzle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
