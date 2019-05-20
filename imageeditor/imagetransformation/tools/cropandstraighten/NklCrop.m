//
//  NklCrop.m
//  imagetransformation
//
//  Created by Sudhir on 17/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NklCrop.h"

//Crop tool
@implementation NklCrop

// crop image with parameters
+ (UIImage*)cropImage:(UIImage*)image
          translation:(CGPoint)translation
            transform:(CGAffineTransform)t
                angle:(CGFloat)angle
             cropSize:(CGSize)cropSize
        imageViewSize:(CGSize)imageViewSize {
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    // translate
    transform = CGAffineTransformTranslate(transform, translation.x, translation.y);
    // rotate
    transform = CGAffineTransformRotate(transform, angle);
    // scale
    CGFloat xScale =  sqrt(t.a * t.a + t.c * t.c);
    CGFloat yScale = sqrt(t.b * t.b + t.d * t.d);
    transform = CGAffineTransformScale(transform, xScale, yScale);
    
    CGImageRef imageRef = [NklCrop newTransformedImage:transform
                                        sourceImage:image.CGImage
                                         sourceSize:image.size
                                  sourceOrientation:image.imageOrientation
                                        outputWidth:image.size.width
                                           cropSize:cropSize
                                      imageViewSize:imageViewSize];
    //convert imageref to uiimage
    UIImage *outputImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return outputImage;
}

//return a new image after transforming with orientation,width crop size and  image view size
+ (CGImageRef)newTransformedImage:(CGAffineTransform)transform
                      sourceImage:(CGImageRef)sourceImage
                       sourceSize:(CGSize)sourceSize
                sourceOrientation:(UIImageOrientation)sourceOrientation
                      outputWidth:(CGFloat)outputWidth
                         cropSize:(CGSize)cropSize
                    imageViewSize:(CGSize)imageViewSize
{
    // scale image
    CGImageRef source = [NklCrop newScaledImage:sourceImage
                             withOrientation:sourceOrientation
                                      toSize:sourceSize
                                 withQuality:kCGInterpolationNone];
    
    CGFloat aspect = cropSize.height/cropSize.width;
    CGSize outputSize = CGSizeMake(outputWidth, outputWidth*aspect);
    
    //create bitmap
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 outputSize.width,
                                                 outputSize.height,
                                                 CGImageGetBitsPerComponent(source),
                                                 0,
                                                 CGImageGetColorSpace(source),
                                                 CGImageGetBitmapInfo(source));
    
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, outputSize.width, outputSize.height));
    
    // transform
    CGAffineTransform uiCoords = CGAffineTransformMakeScale(outputSize.width / cropSize.width,
                                                            outputSize.height / cropSize.height);
    uiCoords = CGAffineTransformTranslate(uiCoords, cropSize.width/2.0, cropSize.height / 2.0);
    // scale
    uiCoords = CGAffineTransformScale(uiCoords, 1.0, -1.0);
    CGContextConcatCTM(context, uiCoords);
    
    CGContextConcatCTM(context, transform);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // draw image
    CGContextDrawImage(context, CGRectMake(-imageViewSize.width/2.0,
                                           -imageViewSize.height/2.0,
                                           imageViewSize.width,
                                           imageViewSize.height)
                       , source);
    
    // convert bitmap context to imageref
    CGImageRef resultRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGImageRelease(source);
    return resultRef;
}

//Return new scaled image for given orientation , size and quality
+ (CGImageRef)newScaledImage:(CGImageRef)source
             withOrientation:(UIImageOrientation)orientation
                      toSize:(CGSize)size
                 withQuality:(CGInterpolationQuality)quality {
    CGSize srcSize = size;
    CGFloat rotation = 0.0;
    
    switch(orientation)
    {
        case UIImageOrientationUp: {
            rotation = 0;
        } break;
        case UIImageOrientationDown: {
            rotation = M_PI;
        } break;
        case UIImageOrientationLeft:{
            rotation = M_PI_2;
            srcSize = CGSizeMake(size.height, size.width);
        } break;
        case UIImageOrientationRight: {
            rotation = -M_PI_2;
            srcSize = CGSizeMake(size.height, size.width);
        } break;
        default:
            break;
    }
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create bitmap
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 size.width,
                                                 size.height,
                                                 8,  //CGImageGetBitsPerComponent(source),
                                                 0,
                                                 rgbColorSpace,//CGImageGetColorSpace(source),
                                                 kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big//(CGBitmapInfo)kCGImageAlphaNoneSkipFirst  //CGImageGetBitmapInfo(source)
                                                 );
    CGColorSpaceRelease(rgbColorSpace);
    
    // set quality
    CGContextSetInterpolationQuality(context, quality);
    // translate
    CGContextTranslateCTM(context,  size.width/2,  size.height/2);
    // rotate
    CGContextRotateCTM(context,rotation);
    
    //draw image
    CGContextDrawImage(context, CGRectMake(-srcSize.width/2 ,
                                           -srcSize.height/2,
                                           srcSize.width,
                                           srcSize.height),
                       source);
    
    // convert bitmap context to imageref
    CGImageRef resultRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    return resultRef;
}
@end
