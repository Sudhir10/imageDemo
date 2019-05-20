//
//  NklCropView.h
//  PhotoTweaks
//
//  Created by Roshan Mishra on 17/05/19.
//  Copyright © 2019 Tu You. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NklCropCornerView.h"

@class NklCropView;

//Crop listener
@protocol NklCropViewDelegate <NSObject>
- (void)cropEnded:(NklCropView *)cropView;
- (void)cropMoved:(NklCropView *)cropView;
@end

//Image crop view
@interface NklCropView : UIView

//Crop Corner UI
@property (nonatomic, strong) NklCropCornerView *upperLeft;
@property (nonatomic, strong) NklCropCornerView *upperRight;
@property (nonatomic, strong) NklCropCornerView *lowerRight;
@property (nonatomic, strong) NklCropCornerView *lowerLeft;
//Declare delegate
@property (nonatomic, weak) id<NklCropViewDelegate> delegate;
//Information
@property (nonatomic, assign) BOOL cropLinesDismissed;
@property (nonatomic, strong) NSMutableArray *horizontalCropLines;
@property (nonatomic, strong) NSMutableArray *verticalCropLines;

//Method
- (instancetype)initWithFrame:(CGRect)frame;
- (void)updateCropLines:(BOOL)animate;
- (void)updateLines:(NSArray *)lines horizontal:(BOOL)horizontal;
- (void)dismissCropLines;
- (void)dismissLines:(NSArray *)lines;
- (void)showCropLines;
- (void)showLines:(NSArray *)lines;

@end


