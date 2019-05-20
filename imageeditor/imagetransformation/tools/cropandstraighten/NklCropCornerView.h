//
//  Created by Roshan Mishra on 17/05/19.
//  Copyright © 2019 Tu You. All rights reserved.
//

#import <UIKit/UIKit.h>

//Declare constant as a global
static const CGFloat kCropViewCornerLength = 22;
static const CGFloat kCropViewHotArea = 16;
static const CGFloat kMinimumCropArea = 60;

//Edit Constant
#define cropCGLineColor [UIColor colorWithWhite:1.0 alpha:1.0].CGColor;
#define cropLineColor [UIColor colorWithWhite:1.0 alpha:1.0];
#define maskColor [UIColor colorWithWhite:0.0 alpha:0.6];

//Declare crop corner
typedef NS_ENUM(NSInteger, CropCornerType) {
    CropCornerTypeUpperLeft,
    CropCornerTypeUpperRight,
    CropCornerTypeLowerRight,
    CropCornerTypeLowerLeft
};

//Image Crop Corner 
@interface NklCropCornerView : UIView

//Method
- (instancetype)initWithCornerType:(CropCornerType)type;

@end

