//
//  PuzzleBoardView.m
//  Mystic Square
//
//  Created by Anton Serov on 3/23/15.
//  Copyright (c) 2015 hexforge. All rights reserved.
//

#import "PuzzleBoardView.h"
#import "TileViewGenerator.h"
#import "RoundedTileViewGenerator.h"
#import "Puzzle.h"
#import "TileView.h"
#import "Move.h"
#import "Tile.h"

@interface PuzzleBoardView() <PuzzleDelegate>
@end

@implementation PuzzleBoardView

- (void)setPuzzle:(Puzzle *)puzzle {
    if (_puzzle != nil) {
        NSAssert(_puzzle.isPlaying, @"Try to set puzzle while already playing on board.");
    }
    _puzzle.delegate = nil;
    _puzzle = puzzle;
    _puzzle.delegate = self;
    [self generateViews];
}

- (void)createPuzzle {
    self.puzzle = [Puzzle createSimplePuzzle];
}

- (void)generateViews {
    for (int i = 1; i <= _puzzle.sideSize * _puzzle.sideSize; ++i) {
        TileView *view = (TileView *) [self viewWithTag:i];
        [view removeFromSuperview];
    }

    int padding = 5;
    CGFloat sideSize = (CGRectGetWidth(self.frame) - padding * (_puzzle.sideSize + 1)) / _puzzle.sideSize;
//    TileViewGenerator *generator =
//        [[TileViewGenerator alloc] initWithItemSize:CGSizeMake(sideSize, sideSize)];
    
    RoundedTileViewGenerator *generator =
      [[RoundedTileViewGenerator alloc] initWithItemSize:CGSizeMake(sideSize, sideSize) padding:padding];

    for (Tile *tile in self.puzzle.tiles) {
        TileView *tileView = [generator viewForTile:tile];
        if (tileView != nil) {
            tileView.tag = tile.number;
            UISwipeGestureRecognizer *rightSwipe =
                [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
            rightSwipe.numberOfTouchesRequired = 1;
            rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;

            UISwipeGestureRecognizer *leftSwipe =
                [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
            leftSwipe.numberOfTouchesRequired = 1;
            leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;

            UISwipeGestureRecognizer *upSwipe =
                [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
            upSwipe.numberOfTouchesRequired = 1;
            upSwipe.direction = UISwipeGestureRecognizerDirectionUp;

            UISwipeGestureRecognizer *downSwipe =
                [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
            downSwipe.numberOfTouchesRequired = 1;
            downSwipe.direction = UISwipeGestureRecognizerDirectionDown;

            [tileView addGestureRecognizer:rightSwipe];
            [tileView addGestureRecognizer:leftSwipe];
            [tileView addGestureRecognizer:upSwipe];
            [tileView addGestureRecognizer:downSwipe];
            [self addSubview:tileView];
        }
    }
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipeGesture {
    if (![swipeGesture.view isKindOfClass:[TileView class]]) {
        return;
    }

    TileView *view = (TileView *)swipeGesture.view;

    Tile *from = [self.puzzle tileAtViewPoint:view.center];
    Tile *to = nil;

    switch (swipeGesture.direction) {
        case UISwipeGestureRecognizerDirectionRight:
            to = [self.puzzle rightTileFrom:from];
            break;

        case UISwipeGestureRecognizerDirectionLeft:
            to = [self.puzzle leftTileFrom:from];
            break;

        case UISwipeGestureRecognizerDirectionUp:
            to = [self.puzzle topTileFrom:from];
            break;

        case UISwipeGestureRecognizerDirectionDown:
            to = [self.puzzle bottomTileFrom:from];
            break;

        default:
            break;
    }

    if (to != nil) {
        [self.puzzle makeMove:[Move moveFrom:from to:to]];
    }
}

#pragma mark - Puzzle delegate impl

- (void)tile:(Tile *)tile
    wasMovedFrom:(Position)from
              to:(Position)to
        inPuzzle:(Puzzle *)puzzle
       withError:(NSError *)error {
    if (error != nil) {
        NSLog(@"%@", error.localizedDescription);
    } else {
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionCurveEaseInOut
            animations:^{
              TileView *view = (TileView *) [weakSelf viewWithTag:tile.number];
              view.center = to.displayPoint;
            }
            completion:nil];
    }
}

- (void)puzzleWasSolved:(Puzzle *)puzzle {
    NSLog(@"Puzzle solved");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"You solve puzzle!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
};

@end
