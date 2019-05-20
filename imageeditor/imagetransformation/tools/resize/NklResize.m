//
//  NklResize.m
//  imagetransformation
//
//  Created by Sudhir on 17/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//


#import "NklResize.h"

// resize
@implementation NklResize

//  resize image with given percentage
+ (UIImage*)resizeImage:(UIImage*)image byPercentage:(CGFloat)percentage {
    
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    
    // new size
    float adjustmentHeight = (actualHeight * percentage);
    float adjustmentWidth = (actualWidth * percentage);
    
    
    CGRect rect = CGRectMake(0.0, 0.0, adjustmentWidth, adjustmentHeight);
    // bitmap with new size
    UIGraphicsBeginImageContext(rect.size);
    // draw given image
    [image drawInRect:rect];
    // get new image
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
