//
//  Puzzle.m
//  Mystic Square
//
//  Created by Anton Serov on 3/22/15.
//  Copyright (c) 2015 hexforge. All rights reserved.
//

#import "Puzzle.h"
#import "Move.h"
#import "Tile.h"

@implementation Puzzle {
    int _sideSize;
    NSMutableArray *_tiles;
    NSMutableArray *_moves;
    BOOL _isStarted;
}

- (NSMutableArray *)generatePuzzleWithSideSize:(int)sideSize {
    _isStarted = NO;
    int size = sideSize * sideSize;
    NSMutableArray *numbers =
        [NSMutableArray arrayWithCapacity:size];
    NSMutableArray *puzzle = [NSMutableArray arrayWithCapacity:size];
    
    for (int i = 1; i <= size; ++i) {
        int num = 1 + arc4random() % size;
        while ([numbers containsObject:@(num)])
            num = 1 + arc4random() % size;
        [numbers addObject:@(num)];
    }
    
    int N = 0;
    for (int i = 0; i < size; ++i) {
        for (int j = i + 1; j < size; ++j) {
            if ([numbers[i] intValue] > [numbers[j] intValue]) {
                N++;
            }
        }
        if ([numbers[i] intValue] == size) {
            N += (i / sideSize) + 1;
        }
    }
    
    for (int i = 0; i < size; ++i) {
        NSNumber *num = numbers[i];
        int n = num.intValue != size ? num.intValue : 0;
        TilePoint point;
        point.row = i / sideSize + 1;
        point.column = i % sideSize + 1;
        Tile *item = [[Tile alloc] initWithPosition:PositionFromTilePosition(point) number:n];
        [puzzle addObject:item];
    }
    
    if (N % 2 != 0) {
        NSLog(@"Unsolved puzzle: %@", self);
        puzzle = [self generatePuzzleWithSideSize:sideSize];
    }
    
    return puzzle;
}

- (instancetype)initWithSideSize:(int)sideSize {
    if (self = [super init]) {
        _sideSize = sideSize;
        _tiles = [self generatePuzzleWithSideSize:_sideSize];
        _moves = [NSMutableArray array];
    }
    
    return self;
}

- (instancetype)initSimplePuzzle {
    if (self = [super init]) {
        _sideSize = 4;
        _tiles = [NSMutableArray arrayWithCapacity:_sideSize * _sideSize];
        NSArray *numbers = @[@(1), @(2), @(3), @(4), @(5), @(6), @(7), @(8), @(9), @(15), @(12), @(14), @(13), @(10), @(16), @(11)];
        for (int i = 0; i < 16; ++i) {
            NSNumber *num = numbers[i];
            int n = num.intValue != numbers.count ? num.intValue : 0;
            TilePoint point;
            point.row = i / 4 + 1;
            point.column = i % 4 + 1;
            Tile *item = [[Tile alloc] initWithPosition:PositionFromTilePosition(point) number:n];
            [_tiles addObject:item];
        }
    }
    
    return self;
}

+ (instancetype)createSimplePuzzle {
    return [[Puzzle alloc] initSimplePuzzle];    
}

- (instancetype)init {
    return [self initWithSideSize:4];
}

- (Tile *)tileAtTilePoint:(TilePoint)point {
    NSUInteger index = [_tiles indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        Tile *t = (Tile *)obj;
        return (t != nil && TilePointsAreEqual(point, t.position.tilePoint));
    }];
    return index != NSNotFound ? _tiles[index] : nil;
}

- (Tile *)tileAtViewPoint:(CGPoint)point {
    NSUInteger index = [_tiles indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        Tile *t = (Tile *)obj;
        return (t != nil && CGPointEqualToPoint(point, t.position.displayPoint));
    }];
    return index != NSNotFound ? _tiles[index] : nil;
}

- (Tile *)leftTileFrom:(Tile *)tile {
    return [self tileAtTilePoint:MakeTilePoint(Row(tile), Column(tile) - 1)];
}

- (Tile *)rightTileFrom:(Tile *)tile {
    return [self tileAtTilePoint:MakeTilePoint(Row(tile), Column(tile) + 1)];
}

- (Tile *)topTileFrom:(Tile *)tile {
    return [self tileAtTilePoint:MakeTilePoint(Row(tile) - 1, Column(tile))];
}

- (Tile *)bottomTileFrom:(Tile *)tile {
    return [self tileAtTilePoint:MakeTilePoint(Row(tile) + 1, Column(tile))];
}


- (NSArray *)tiles {
    return [NSArray arrayWithArray:_tiles];
}

- (BOOL)isValidMove:(Move *)move {
    return move.to.isEmpty && Row(move.from) > 0 && Row(move.to) > 0 &&
    Column(move.from) > 0 && Column(move.to) > 0 &&
    (
        (Row(move.from) == Row(move.to) && abs(Column(move.from) - Column(move.to)) == 1) ||
        (Column(move.from) == Column(move.to) && abs(Row(move.from) - Row(move.to)) == 1)
    );
}

- (BOOL)isPlaying {
    return _isStarted;
}

- (BOOL)makeMove:(Move *)move {
    NSError *moveError = nil;
    NSString *errorDescription = nil;
    BOOL moved = NO;
    
    Position fromPosition = move.from.position;
    Position toPosition = move.to.position;
    
    Tile *fromTile = [self tileAtTilePoint:move.from.position.tilePoint];
    Tile *toTile = [self tileAtTilePoint:move.to.position.tilePoint];
    
    if (self.isCompleted) {
        errorDescription = @"Puzzle already solved.";
    } else if ([self isValidMove:move]) {
        moved = YES;
        _isStarted = YES;
        [_moves addObject:move];
    } else {
        errorDescription = [NSString stringWithFormat:@"Invalide move: %@", move];
    }
    
    if (!moved) {
        moveError = [[NSError alloc] initWithDomain:@"PuzzleErrorDomain"
                                               code:100001
                                           userInfo:@{ NSLocalizedDescriptionKey: errorDescription }];
    }
    
    [self.delegate tile:move.from
           wasMovedFrom:fromPosition
                     to:toPosition
               inPuzzle:self
              withError:moveError];
    
    if (moved) {
        int num = fromTile.number;
        fromTile.number = toTile.number;
        toTile.number = num;
    }

    if (self.isCompleted) {
        [self.delegate puzzleWasSolved:self];
    }
    
    return moved;
}

- (void)undoLastMove {
    if (_moves.count == 0) {
        return;
    }
    
    Move *reverseMove = [_moves.lastObject reverseMove];
    
    [_moves removeLastObject];
    [self makeMove:reverseMove];
    [_moves removeLastObject];
}

- (void)reset {
    [_moves removeAllObjects];
}

- (BOOL)isCompleted {
    for (int i = 1; i < _sideSize * _sideSize - 1; ++i) {
        if ([_tiles[i] number] - 1 != [_tiles[i - 1] number]) {
            return NO;
        }
    }
    return [_tiles[_sideSize * _sideSize - 1] number] == 0;
}

- (NSString *)description {
    NSMutableString *res = [NSMutableString stringWithString:@"\n"];
    
    for (int i = 0; i < _sideSize; ++i) {
        for (int j = 0; j <_sideSize; ++j) {
            NSString *part = j == _sideSize - 1 ?
                [NSString stringWithFormat:@"%@\n", _tiles[i * _sideSize + j]] :
                [NSString stringWithFormat:@"%@\t", _tiles[i * _sideSize + j]];
            [res appendString:part];
        }
    }
    
    return res;
}

- (NSString *)debugDescription {
    return [self description];
}

@end
