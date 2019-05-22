//
//  NklImageEditorViewController.h
//  imageeditorDemoApp
//
//  Created by Roshan Mishra on 10/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NklBrightnessToolViewListener.h"
#import "NklFilterToolViewListener.h"
#import "NklResizeToolViewListener.h"

// image editor view controller
@interface NklImageEditorViewController : UIViewController <
    NklBrightnessToolViewListener,
    NklFilterToolViewListener,
    NklResizeToolViewListener> {
        
    CGFloat preferedBottomViewOffset;
    CGSize preferedBottomViewSize;
}

// UI
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnInfo;
@property (weak, nonatomic) IBOutlet UIView *vBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewBottomConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIView *attachedView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

//背景
@property (weak, nonatomic) IBOutlet UIView *vBarBg;
@property (weak, nonatomic) IBOutlet UIView *vFooterBg;
@property (weak, nonatomic) IBOutlet UIView *vBottomMenu;

@property (strong, nonatomic) UIImage *originalImage;
@end

