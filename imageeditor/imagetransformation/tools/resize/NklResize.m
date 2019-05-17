//
//  NklResize.m
//  imagetransformation
//
//  Created by Sudhir on 17/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//


#import "NklResize.h"

@implementation NklResize

+ (UIImage*)resizeImage:(UIImage*)image byPercentage:(CGFloat)percentage {
    
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    
    float adjustmentHeight = (actualHeight * percentage);
    float adjustmentWidth = (actualWidth * percentage);
    
    CGRect rect = CGRectMake(0.0, 0.0, adjustmentWidth, adjustmentHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
