//
//  NklBrightnessFilter.m
//  imageeditor
//
//  Created by Sudhir on 13/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import "NklBrightnessFilter.h"


@implementation NklBrightnessFilter

+ (UIImage*)adjustBrightnessOfImage:(UIImage*)image withValue: (float) value {
    return [GPUImageAdapter adjustBrightnessOfImage:image withValue:value];
}
@end
