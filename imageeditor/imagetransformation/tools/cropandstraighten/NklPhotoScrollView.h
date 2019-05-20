//
//  Created by Roshan Mishra on 18/05/19.
//  Copyright © 2019 Tu You. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NklPhotoView.h"

//Photo Scroll View
@interface NklPhotoScrollView : UIScrollView

//UI
@property (nonatomic, strong) NklPhotoView *photoContentView;

//Method
- (void)setContentOffsetY:(CGFloat)offsetY;
- (void)setContentOffsetX:(CGFloat)offsetX;
- (CGFloat)zoomScaleToBound;

@end

