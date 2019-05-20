//
//  Created by Roshan Mishra on 17/05/19.
//  Copyright © 2019 Tu You. All rights reserved.
//

#import <UIKit/UIKit.h>

//User Selected Gallery Photo View
@interface NklPhotoView : UIView

//UI
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;

//Method
- (instancetype)initWithImage:(UIImage *)image;

@end


