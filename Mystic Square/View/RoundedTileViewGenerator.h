//
//  RoundedTileViewGenerator.h
//  Mystic Square
//
//  Created by Anton Serov on 3/23/15.
//  Copyright (c) 2015 hexforge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TileViewGenerator.h"

@interface RoundedTileViewGenerator : TileViewGenerator

- (instancetype)initWithItemSize:(CGSize)size padding:(int)padding;

@property (nonatomic, readonly) int padding;

@end
