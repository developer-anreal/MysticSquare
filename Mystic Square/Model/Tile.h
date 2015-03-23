//
//  Item.h
//  Mystic Square
//
//  Created by Anton Serov on 3/22/15.
//  Copyright (c) 2015 hexforge. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

typedef struct {
    int row; // value in range [1..n]
    int column; // value in range [1..n]
} TilePoint;

typedef struct {
    CGPoint displayPoint;
    TilePoint tilePoint;
} Position;

@interface Tile : NSObject <NSCopying>

- (instancetype)initWithPosition:(Position)position number:(int)number;
- (instancetype)initWithPosition:(Position)position;

@property (nonatomic) Position position;
@property (nonatomic) int number; // value in range [0..n^2 - 1], 0 means empty item

@property (nonatomic, readonly) BOOL isEmpty;

@end

int Row(Tile *tile);
int Column(Tile *tile);

Position PositionFromTilePosition(TilePoint point);
Position CreatePosition(TilePoint point, CGPoint xy);

TilePoint MakeTilePoint(int row, int column);

BOOL TilePointsAreEqual(TilePoint point1, TilePoint point2);
BOOL PositionsAreEqual(Position position1, Position position2);