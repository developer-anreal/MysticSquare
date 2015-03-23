//
//  Puzzle.h
//  Mystic Square
//
//  Created by Anton Serov on 3/22/15.
//  Copyright (c) 2015 hexforge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tile.h"

@class Move;
@class Tile;
@protocol PuzzleDelegate;

@interface Puzzle : NSObject

+ (instancetype)createSimplePuzzle;

- (instancetype)initWithSideSize:(int)sideSize;
- (BOOL)isValidMove:(Move *)move;
- (BOOL)makeMove:(Move *)move;
- (void)undoLastMove;
- (void)reset;

- (Tile *)tileAtTilePoint:(TilePoint)point;
- (Tile *)tileAtViewPoint:(CGPoint)point;

- (Tile *)leftTileFrom:(Tile *)tile;
- (Tile *)rightTileFrom:(Tile *)tile;
- (Tile *)topTileFrom:(Tile *)tile;
- (Tile *)bottomTileFrom:(Tile *)tile;

@property (nonatomic, readonly) NSArray *tiles;
@property (nonatomic, readonly) int sideSize;
@property (nonatomic, readonly) BOOL isCompleted;
@property (nonatomic, readonly) BOOL isPlaying;

@property (nonatomic, weak) id<PuzzleDelegate> delegate;

@end

@protocol PuzzleDelegate <NSObject>

- (void)tile:(Tile *)tile
            wasMovedFrom:(Position)from 
                      to:(Position)to 
                inPuzzle:(Puzzle *)puzzle
               withError:(NSError *)error;

- (void)puzzleWasSolved:(Puzzle *)puzzle;

@end
