//
//  Move.m
//  Mystic Square
//
//  Created by Anton Serov on 3/22/15.
//  Copyright (c) 2015 hexforge. All rights reserved.
//

#import "Move.h"
#import "Tile.h"

@implementation Move {
    Tile *_from;
    Tile *_to;
}

+ (instancetype)moveFrom:(Tile *)from to:(Tile *)to {
    return [[Move alloc] initFrom:from to:to];
}

- (instancetype)initFrom:(Tile *)from to:(Tile *)to {
    if (self = [super init]) {
        _from = from;
        _to = to;
    }
    
    return self;
}

- (Move *)reverseMove {
    return [[Move alloc] initFrom:self.to to:self.from];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"(%@ -> %@)", self.from, self.to];
}

- (NSString *)debugDescription {
    return [self description];
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    Move *move = (Move *)object;
    return [self.from isEqual:move.from] && [self.to isEqual:move.to];
}

@end
