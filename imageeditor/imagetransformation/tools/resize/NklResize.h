//
//  NklResize.h
//  imagetransformation
//
//  Created by Sudhir on 17/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NklResize : NSObject

+ (UIImage*)resizeImage:(UIImage*)image byPercentage:(CGFloat)percentage;

@end

NS_ASSUME_NONNULL_END
