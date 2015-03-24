//
//  PuzzleBoardView.h
//  Mystic Square
//
//  Created by Anton Serov on 3/23/15.
//  Copyright (c) 2015 hexforge. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Puzzle;

@interface PuzzleBoardView : UIView

@property (nonatomic, strong) Puzzle *puzzle;

- (void)createPuzzle;
- (void)restart;
- (void)undo;

@end
