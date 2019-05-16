//
//  NlkUtility.m
//  imagetransformationDemoApp
//
//  Created by Sudhir on 15/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import "NlkUtility.h"

@implementation NlkUtility

+ (CGFloat) bottomSafeInsetSize {
    if (@available(iOS 11.0, *)) {
        UIWindow *window = UIApplication.sharedApplication.keyWindow;
        return  window.safeAreaInsets.bottom;
    }
    return 0.0;
}
@end
