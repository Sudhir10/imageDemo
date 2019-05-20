//
//  NklResize.h
//  imagetransformation
//
//  Created by Sudhir on 17/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// resize
@interface NklResize : NSObject

//  resize image with given percentage 
+ (UIImage*)resizeImage:(UIImage*)image byPercentage:(CGFloat)percentage;

@end

