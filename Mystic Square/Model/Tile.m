//
//  Item.m
//  Mystic Square
//
//  Created by Anton Serov on 3/22/15.
//  Copyright (c) 2015 hexforge. All rights reserved.
//

#import "Tile.h"

@implementation Tile

- (instancetype)initWithPosition:(Position)position number:(int)number {
    if (self = [super init]) {
        _position = position;
        _number = number;
    }
    
    return self;
}

- (instancetype)initWithPosition:(Position)position {
    return [self initWithPosition:position number:0];
}

- (BOOL)isEmpty {
    return self.number == 0;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"(%d, %d)<%.2f, %.2f> = %d",
            self.position.tilePoint.row,
            self.position.tilePoint.column,
            self.position.displayPoint.x,
            self.position.displayPoint.y,
            self.number];
}

- (NSString *)debugDescription {
    return [self description];
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return [[Tile alloc] initWithPosition:self.position number:self.number];
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    Tile *item = (Tile *)object;
    return PositionsAreEqual(self.position, item.position) &&
        self.number == item.number;
}

@end

int Row(Tile *tile) {
    return tile.position.tilePoint.row;
}

int Column(Tile *tile) {
    return tile.position.tilePoint.column;
}

TilePoint MakeTilePoint(int row, int column) {
    TilePoint point;
    point.row = row;
    point.column = column;
    return point;
}

Position PositionFromTilePosition(TilePoint point) {
    Position position;
    position.tilePoint = point;
    return position;
}

Position CreatePosition(TilePoint point, CGPoint xy) {
    Position position;
    position.tilePoint = point;
    position.displayPoint = xy;
    return position;
}

BOOL TilePointsAreEqual(TilePoint point1, TilePoint point2) {
    return point1.column == point2.column && point1.row == point2.row;
}

BOOL PositionsAreEqual(Position position1, Position position2) {
    return TilePointsAreEqual(position1.tilePoint, position2.tilePoint) &&
        CGPointEqualToPoint(position1.displayPoint, position2.displayPoint);
}
