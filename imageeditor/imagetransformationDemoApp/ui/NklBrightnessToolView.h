//
//  NklBrightnessToolView.h
//  imageeditorDemoApp
//
//  Created by Roshan Mishra on 12/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class NklBrightnessToolView;

@protocol NklBrightnessToolViewDelegate

@required
- (void) nklBrightnessToolView:(NklBrightnessToolView*) nklBrightnessToolView valueChange:(CGFloat)newValue;

@end

@interface NklBrightnessToolView : UIView
@property (weak, nonatomic) id<NklBrightnessToolViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
