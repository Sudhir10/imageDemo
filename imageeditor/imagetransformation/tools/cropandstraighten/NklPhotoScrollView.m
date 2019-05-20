//
//  Created by Roshan Mishra on 18/05/19.
//  Copyright © 2019 Tu You. All rights reserved.
//

#import "NklPhotoScrollView.h"

//Photo Scroll View
@implementation NklPhotoScrollView

//====================
//ScrollView Content Offset
//====================
//Set X-content Offset
- (void)setContentOffsetX:(CGFloat)offsetX
{
    CGPoint contentOffset = self.contentOffset;
    contentOffset.x = offsetX;
    self.contentOffset = contentOffset;
}

//Set Y-content Offset
- (void)setContentOffsetY:(CGFloat)offsetY
{
    CGPoint contentOffset = self.contentOffset;
    contentOffset.y = offsetY;
    self.contentOffset = contentOffset;
}



- (CGFloat)zoomScaleToBound
{
    CGFloat scaleW = self.bounds.size.width / self.photoContentView.bounds.size.width;
    CGFloat scaleH = self.bounds.size.height / self.photoContentView.bounds.size.height;
    CGFloat max = MAX(scaleW, scaleH);
    
    return max;
}


@end
