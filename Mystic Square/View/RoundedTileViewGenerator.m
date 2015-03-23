//
//  RoundedTileViewGenerator.m
//  Mystic Square
//
//  Created by Anton Serov on 3/23/15.
//  Copyright (c) 2015 hexforge. All rights reserved.
//

#import "RoundedTileViewGenerator.h"
#import "Tile.h"
#import "TileView.h"

@implementation RoundedTileViewGenerator {
    int _padding;
}

- (instancetype)initWithItemSize:(CGSize)size padding:(int)padding {
    if (self = [super initWithItemSize:size]) {
        _padding = padding;
    }
    return self;
}

- (TileView *)viewForTile:(Tile *)tile {
    CGFloat x = self.size.width * (Column(tile) - 0.5f) + Column(tile) * self.padding;
    CGFloat y = self.size.height * (Row(tile) - 0.5f) + Row(tile) * self.padding;
    tile.position = CreatePosition(tile.position.tilePoint, CGPointMake(x, y));
    
    if (tile.isEmpty) {
        return nil;
    }
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    TileView *itemView = [[TileView alloc] initWithFrame:rect];
    itemView.backgroundColor = [UIColor clearColor];
    itemView.layer.borderColor = [UIColor blueColor].CGColor;
    itemView.layer.borderWidth = 0.f;
    itemView.layer.cornerRadius = self.size.width / 6.f;
    itemView.center = tile.position.displayPoint;
    
    itemView.layer.shadowColor = [UIColor blackColor].CGColor;
    itemView.layer.shadowOpacity = 0.6f;
    itemView.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
    itemView.layer.shadowRadius = 4.0f;
    itemView.layer.masksToBounds = NO;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:itemView.bounds];
    itemView.layer.shadowPath = path.CGPath;
    
    UIColor *firstColor = [UIColor colorWithRed:25 / 255.f green:45 / 255.f blue:100 / 255.f alpha:1.f];
    UIColor *secondColor = [UIColor colorWithRed:52 / 255.f green:75 / 255.f blue: 196 / 255.f alpha:1.f];
    

    CAGradientLayer *gradientBG = [CAGradientLayer layer];
    gradientBG.frame = rect;
    gradientBG.colors =
        @[(id)firstColor.CGColor, (id)secondColor.CGColor];
    gradientBG.locations = @[@(0.3), @(1)];
    gradientBG.borderColor = [UIColor clearColor].CGColor;
    gradientBG.borderWidth = 0.f;
    gradientBG.cornerRadius = self.size.width / 6.f;
    
    [itemView.layer addSublayer:gradientBG];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:34];
    label.text = [NSString stringWithFormat:@"%d", tile.number];
    label.textColor = [UIColor whiteColor];
    [itemView addSubview:label];
    
    return itemView;
}

@end
