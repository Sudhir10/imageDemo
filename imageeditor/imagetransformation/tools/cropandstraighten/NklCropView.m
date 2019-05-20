//
//  Created by Roshan Mishra on 17/05/19.
//  Copyright © 2019 Tu You. All rights reserved.
//

#import "NklCropView.h"
#import <math.h>

//Constant
static const NSUInteger kCropLines = 2;

//====================
//Math Function
//====================
//Fetching distance between two points and declare as a constant
static CGFloat distanceBetweenPoints(CGPoint point0, CGPoint point1)
{
    return sqrt(pow(point1.x - point0.x, 2) + pow(point1.y - point0.y, 2));
}

//Image crop view
@implementation NklCropView

//====================
//Corner layout
//====================
//Set Crop Lines(Horizontal and Vertical) and 4-Corners(Upper Left,Upper Right,lower Left,lower Right)
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.borderColor = cropCGLineColor;//[UIColor cropLineColor].CGColor;
        self.layer.borderWidth = 1;
        //Horizontal Crop Lines
        _horizontalCropLines = [NSMutableArray array];
        for (int i = 0; i < kCropLines; i++) {
            UIView *line = [UIView new];
            line.backgroundColor = cropLineColor;//[UIColor cropLineColor];
            [_horizontalCropLines addObject:line];
            [self addSubview:line];
        }
        //Vertical Crop Lines
        _verticalCropLines = [NSMutableArray array];
        for (int i = 0; i < kCropLines; i++) {
            UIView *line = [UIView new];
            line.backgroundColor = cropLineColor;//[UIColor cropLineColor];
            [_verticalCropLines addObject:line];
            [self addSubview:line];
        }
        //Default Cron line status
        _cropLinesDismissed = YES;
        //Set Upper Left Crop Corner
        _upperLeft = [[NklCropCornerView alloc] initWithCornerType:CropCornerTypeUpperLeft];
        _upperLeft.center = CGPointMake(kCropViewCornerLength / 2, kCropViewCornerLength / 2);
        _upperLeft.autoresizingMask = UIViewAutoresizingNone;
        [self addSubview:_upperLeft];
        //Set Upper Right Crop Corner
        _upperRight = [[NklCropCornerView alloc] initWithCornerType:CropCornerTypeUpperRight];
        _upperRight.center = CGPointMake(self.frame.size.width - kCropViewCornerLength / 2, kCropViewCornerLength / 2);
        _upperRight.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:_upperRight];
        //Set Upper Left Crop Corner
        _lowerLeft = [[NklCropCornerView alloc] initWithCornerType:CropCornerTypeLowerLeft];
        _lowerLeft.center = CGPointMake(kCropViewCornerLength / 2, self.frame.size.height - kCropViewCornerLength / 2);
        _lowerLeft.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:_lowerLeft];
        //Set Lower Right Crop Corner
        _lowerRight = [[NklCropCornerView alloc] initWithCornerType:CropCornerTypeLowerRight];
        _lowerRight.center = CGPointMake(self.frame.size.width - kCropViewCornerLength / 2, self.frame.size.height - kCropViewCornerLength / 2);
        _lowerRight.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:_lowerRight];
        
        //Desable update crop croner points
        [self updateCropLines:NO];
    }
    return self;
}

//====================
//Crop Area Selection Movement
//====================
//Begin Crop Area movement for selection of crop area
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] == 1) {
        [self updateCropLines:NO];
    }
}

//Crop Area Move
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] == 1) {
        CGPoint location = [[touches anyObject] locationInView:self];
        CGRect frame = self.frame;
        CGPoint p0 = CGPointMake(0, 0);
        CGPoint p1 = CGPointMake(self.frame.size.width, 0);
        CGPoint p2 = CGPointMake(0, self.frame.size.height);
        CGPoint p3 = CGPointMake(self.frame.size.width, self.frame.size.height);
        
        BOOL canChangeWidth = frame.size.width > kMinimumCropArea;
        BOOL canChangeHeight = frame.size.height > kMinimumCropArea;
        
        if (distanceBetweenPoints(location, p0) < kCropViewHotArea) {
            if (canChangeWidth) {
                frame.origin.x += location.x;
                frame.size.width -= location.x;
            }
            if (canChangeHeight) {
                frame.origin.y += location.y;
                frame.size.height -= location.y;
            }
        } else if (distanceBetweenPoints(location, p1) < kCropViewHotArea) {
            if (canChangeWidth) {
                frame.size.width = location.x;
            }
            if (canChangeHeight) {
                frame.origin.y += location.y;
                frame.size.height -= location.y;
            }
        } else if (distanceBetweenPoints(location, p2) < kCropViewHotArea) {
            if (canChangeWidth) {
                frame.origin.x += location.x;
                frame.size.width -= location.x;
            }
            if (canChangeHeight) {
                frame.size.height = location.y;
            }
        } else if (distanceBetweenPoints(location, p3) < kCropViewHotArea) {
            if (canChangeWidth) {
                frame.size.width = location.x;
            }
            if (canChangeHeight) {
                frame.size.height = location.y;
            }
        } else if (fabs(location.x - p0.x) < kCropViewHotArea) {
            if (canChangeWidth) {
                frame.origin.x += location.x;
                frame.size.width -= location.x;
            }
        } else if (fabs(location.x - p1.x) < kCropViewHotArea) {
            if (canChangeWidth) {
                frame.size.width = location.x;
            }
        } else if (fabs(location.y - p0.y) < kCropViewHotArea) {
            if (canChangeHeight) {
                frame.origin.y += location.y;
                frame.size.height -= location.y;
            }
        } else if (fabs(location.y - p2.y) < kCropViewHotArea) {
            if (canChangeHeight) {
                frame.size.height = location.y;
            }
        }
        self.frame = frame;
        //update crop lines
        [self updateCropLines:NO];
        //Delegate Action Fired
        if ([self.delegate respondsToSelector:@selector(cropMoved:)]) {
            [self.delegate cropMoved:self];
        }
    }
}

//Crop Selected Area End
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(cropEnded:)]) {
        [self.delegate cropEnded:self];
    }
}

//Crop Selection Area cancelled
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

//====================
//Update line for selected Crop Area
//====================
//Updatng crop line
- (void)updateCropLines:(BOOL)animate
{
    //show crop lines
    if (self.cropLinesDismissed) {
        [self showCropLines];
    }
    
    void (^animationBlock)(void) = ^(void) {
        [self updateLines:self.horizontalCropLines horizontal:YES];
        [self updateLines:self.verticalCropLines horizontal:NO];
    };
    
    if (animate) {
        [UIView animateWithDuration:0.25 animations:animationBlock];
    } else {
        animationBlock();
    }
}

//Update line for horizontal
- (void)updateLines:(NSArray *)lines horizontal:(BOOL)horizontal
{
    [lines enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *line = (UIView *)obj;
        if (horizontal) {
            line.frame = CGRectMake(0,
                                    (self.frame.size.height / (lines.count + 1)) * (idx + 1),
                                    self.frame.size.width,
                                    1 / [UIScreen mainScreen].scale);
        } else {
            line.frame = CGRectMake((self.frame.size.width / (lines.count + 1)) * (idx + 1),
                                    0,
                                    1 / [UIScreen mainScreen].scale,
                                    self.frame.size.height);
        }
    }];
}

//Dismiss selected horizontal and vertical crop lines
- (void)dismissCropLines
{
    [UIView animateWithDuration:0.2 animations:^{
        [self dismissLines:self.horizontalCropLines];
        [self dismissLines:self.verticalCropLines];
    } completion:^(BOOL finished) {
        self.cropLinesDismissed = YES;
    }];
}

//Dismiss lines method
- (void)dismissLines:(NSArray *)lines
{
    [lines enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ((UIView *)obj).alpha = 0.0f;
    }];
}

//Display selected crop area lines
- (void)showCropLines
{
    self.cropLinesDismissed = NO;
    [UIView animateWithDuration:0.2 animations:^{
        [self showLines:self.horizontalCropLines];
        [self showLines:self.verticalCropLines];
    }];
}

//Display selected horizontal and vertical crop lines
- (void)showLines:(NSArray *)lines
{
    [lines enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ((UIView *)obj).alpha = 1.0f;
    }];
}


@end
