//
//  Move.h
//  Mystic Square
//
//  Created by Anton Serov on 3/22/15.
//  Copyright (c) 2015 hexforge. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Tile;

@interface Move : NSObject

+ (instancetype)moveFrom:(Tile *)from to:(Tile *)to;
- (instancetype)initFrom:(Tile *)from to:(Tile *)to;

@property (nonatomic, readonly) Tile *from;
@property (nonatomic, readonly) Tile *to;
@property (nonatomic, readonly) Move *reverseMove;

@end
