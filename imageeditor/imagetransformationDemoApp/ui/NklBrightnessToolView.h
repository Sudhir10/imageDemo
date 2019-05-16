//
//  NklBrightnessToolView.h
//  imageeditorDemoApp
//
//  Created by Roshan Mishra on 12/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NklBrightnessToolViewListener.h"

NS_ASSUME_NONNULL_BEGIN


@interface NklBrightnessToolView : UIView
@property (weak, nonatomic) id<NklBrightnessToolViewListener> listener;
@end

NS_ASSUME_NONNULL_END
