//
//  NklBrightnessFilter.h
//  imageeditor
//
//  Created by Sudhir on 13/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <imagetransformationDemoApp-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@interface NklBrightnessFilter : NSObject
+ (UIImage*)adjustBrightnessOfImage:(UIImage*)image withValue: (float) value;
@end

NS_ASSUME_NONNULL_END
