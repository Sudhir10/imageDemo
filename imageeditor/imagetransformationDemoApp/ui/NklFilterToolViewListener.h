//
//  NklFilterToolListener.h
//  imagetransformation
//
//  Created by Sudhir on 16/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <imagetransformation/imagetransformation-Swift.h>

// filter tool view listener
@protocol NklFilterToolViewListener <NSObject>

@required
- (void)onFilterSelected:(NklFilterType)filterType;

@end
