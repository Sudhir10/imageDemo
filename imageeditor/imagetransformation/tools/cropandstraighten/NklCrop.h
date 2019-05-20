//
//  NklCrop.h
//  imagetransformation
//
//  Created by Sudhir on 17/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

//Crop tool
@interface NklCrop : NSObject

//cropimage with given parameters
+ (UIImage*)cropImage:(UIImage*)image
          translation:(CGPoint)translation
            transform:(CGAffineTransform)t
                angle:(CGFloat)angle
             cropSize:(CGSize)cropSize
        imageViewSize:(CGSize)imageViewSize;

@end

