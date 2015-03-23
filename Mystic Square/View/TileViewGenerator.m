//
//  TileViewGenerator.m
//  Mystic Square
//
//  Created by Anton Serov on 3/22/15.
//  Copyright (c) 2015 hexforge. All rights reserved.
//

#import "TileViewGenerator.h"
#import "Tile.h"
#import "TileView.h"

@import QuartzCore;

@implementation TileViewGenerator {
    CGSize _itemSize;
}

- (instancetype)initWithItemSize:(CGSize)size {
    if (self = [super init]) {
        _itemSize = size;
    }
    
    return self;
}

- (TileView *)viewForTile:(Tile *)tile {
    CGFloat x = _itemSize.width * (Column(tile) - 0.5f);
    CGFloat y =_itemSize.height * (Row(tile) - 0.5f);
    tile.position = CreatePosition(tile.position.tilePoint, CGPointMake(x, y));
    
    if (tile.isEmpty) {
        return nil;
    }
    
    CGRect rect = CGRectMake(0, 0, _itemSize.width, _itemSize.height);
    TileView *itemView = [[TileView alloc] initWithFrame:rect];
    itemView.backgroundColor = [UIColor lightGrayColor];
    itemView.layer.borderColor = [UIColor blueColor].CGColor;
    itemView.layer.borderWidth = 1.f;
    itemView.center = tile.position.displayPoint;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _itemSize.width, _itemSize.height)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:34];
    label.text = [NSString stringWithFormat:@"%d", tile.number];
    label.textColor = [UIColor blueColor];
    [itemView addSubview:label];
        
    return itemView;
}

@end
