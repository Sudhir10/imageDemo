//
//  NklBrightnessToolViewListener.h
//  imagetransformation
//
//  Created by Sudhir on 16/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//
#import <UIKit/UIKit.h>

@class NklBrightnessToolView;

@protocol NklBrightnessToolViewListener

@required
- (void) nklBrightnessToolView:(NklBrightnessToolView*) nklBrightnessToolView valueChange:(CGFloat)newValue;

@end
