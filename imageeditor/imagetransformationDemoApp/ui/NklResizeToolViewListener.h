//
//  NklResizeToolViewListener.h
//  imagetransformation
//
//  Created by Sudhir on 17/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NklResizeToolView;

@protocol NklResizeToolViewListener

@required
- (void) nklResizeToolView:(NklResizeToolView*) nklresizeToolView valueChange:(CGFloat)newValue;
- (void) nklResizeToolViewCancelClick:(NklResizeToolView*) nklresizeToolView;
@end
