//
//  Created by Roshan Mishra on 19/05/19.
//  Copyright © 2019 Tu You. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NklPhotoView.h"
#import "NklCropView.h"
#import "NklPhotoScrollView.h"
#import <math.h>

//Constant
extern const CGFloat kMaxRotationAngle;

//Image Crop and Straighten View
@interface NklPhotoCropAndStraightenView : UIView <UIGestureRecognizerDelegate, UIScrollViewDelegate, NklCropViewDelegate>

//UI
@property (nonatomic, strong) NklPhotoScrollView *scrollView;
@property (nonatomic, strong) NklCropView *cropView;
@property (nonatomic, strong, readonly) NklPhotoView *photoContentView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UIButton *resetBtn;
@property (nonatomic, assign) CGSize originalSize;
@property (nonatomic, assign) CGFloat angle;
@property (nonatomic,strong) UIRotationGestureRecognizer *rotationGestureRecognizer;
@property (nonatomic, assign) BOOL manualZoomed;

//UI masks
@property (nonatomic, strong) UIView *topMask;
@property (nonatomic, strong) UIView *leftMask;
@property (nonatomic, strong) UIView *bottomMask;
@property (nonatomic, strong) UIView *rightMask;

//constants
@property (nonatomic, assign) CGSize maximumCanvasSize;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGPoint originalPoint;
@property (nonatomic, assign) CGFloat maxRotationAngle;
@property (nonatomic, assign, readonly) CGPoint photoContentOffset;

//Method
- (instancetype)initWithFrame:(CGRect)frame
                        image:(UIImage *)image
             maxRotationAngle:(CGFloat)maxRotationAngle;
- (instancetype)initWithFrame:(CGRect)frame
                        image:(UIImage *)image;
- (CGPoint)photoTranslation;

@end


