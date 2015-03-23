//
//  TileViewGenerator.h
//  Mystic Square
//
//  Created by Anton Serov on 3/22/15.
//  Copyright (c) 2015 hexforge. All rights reserved.
//

@import Foundation;
@import UIKit;

@class Tile;
@class TileView;

@interface TileViewGenerator : NSObject

- (instancetype)initWithItemSize:(CGSize)size;
- (TileView *)viewForTile:(Tile *)tile;

@property (nonatomic) CGSize size;

@end
