//
//  Created by Roshan Mishra on 17/05/19.
//  Copyright © 2019 Tu You. All rights reserved.
//

#import "NklPhotoView.h"

// User Selected Gallery Photo View
@implementation NklPhotoView

//Add image on view
- (instancetype)initWithImage:(UIImage *)image
{
    if (self = [super init]) {
        _image = image;
        //Set Image frame on View frame
        self.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        //Add image on view window
        _imageView.image = self.image;
        _imageView.userInteractionEnabled = YES;
        [self addSubview:_imageView];
    }
    return self;
}

//View update
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

@end
