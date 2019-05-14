//
//  NklImageEditorViewController.m
//  imageeditorDemoApp
//
//  Created by Roshan Mishra on 10/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import "NklImageEditorViewController.h"
#import "U.h"

@interface NklImageEditorViewController ()

@end

@implementation NklImageEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self.vBottomMenu setHidden:TRUE];
}

-(IBAction)scaleButtonClick:(UIButton*)sender {
    UIView* v = [U loadView:@"NklBottomMenuView"];
    v.frame = CGRectMake(0, SCREEN.height - 44, self.view.frame.size.width, 44);
    [self.view addSubview:v];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
