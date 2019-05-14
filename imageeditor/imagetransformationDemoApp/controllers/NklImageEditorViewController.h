//
//  NklImageEditorViewController.h
//  imageeditorDemoApp
//
//  Created by Roshan Mishra on 10/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NklImageEditorViewController : UIViewController {
    
   
}

// UI
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnInfo;
@property (weak, nonatomic) IBOutlet UIView *vBar;

//背景
@property (weak, nonatomic) IBOutlet UIView *vBarBg;
@property (weak, nonatomic) IBOutlet UIView *vFooterBg;
@property (weak, nonatomic) IBOutlet UIView *vBottomMenu;

@property (strong, nonatomic) UIImage *originalImage;
@end

