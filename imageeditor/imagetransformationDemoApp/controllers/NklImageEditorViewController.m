//
//  NklImageEditorViewController.m
//  imageeditorDemoApp
//
//  Created by Roshan Mishra on 10/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import "NklImageEditorViewController.h"
#import "U.h"

#import "NklBrightnessToolView.h"

#import "NklBrightnessFilter.h"

@interface NklImageEditorViewController () <NklBrightnessToolViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewBottomConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIView *attachedView;
@end

@implementation NklImageEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.originalImage = [UIImage imageNamed:@"sample"];
    self.imageView.image = self.originalImage;
    self.vBottomMenu.hidden = TRUE;
}

- (void)viewDidLayoutSubviews {
    if (self.attachedView != nil) {
        self.attachedView.frame = CGRectMake(0, SCREEN.height - 88, self.view.frame.size.width, 44);
        self.imageViewBottomConstraint.constant = 44;
    } else {
        self.imageViewBottomConstraint.constant = 0;
    }
    [super viewDidLayoutSubviews];
}

- (IBAction)scaleButtonClick:(UIButton*)sender {
    UIView* v = [U loadView:@"NklBottomMenuView"];
    v.frame = CGRectMake(0, SCREEN.height - 44, self.view.frame.size.width, 44);
    [self.view addSubview:v];
}

- (IBAction)onBrightnessClick:(id)sender {
    self.vBottomMenu.hidden = FALSE;
    self.attachedView = (NklBrightnessToolView*)[U loadView:@"NklBrightnessToolView"];
    ((NklBrightnessToolView*)self.attachedView ).delegate = self;
    self.attachedView.frame = CGRectMake(0, SCREEN.height - 88, self.view.frame.size.width, 44);
    [self.view addSubview:self.attachedView];
}

- (IBAction)onCancelClick:(id)sender {
    [self removeAttachedView];
    self.vBottomMenu.hidden = TRUE;
}

- (IBAction)onSaveClick:(id)sender {
    [self removeAttachedView];
    self.vBottomMenu.hidden = TRUE;
}

- (void)removeAttachedView {
    [self.attachedView removeFromSuperview];
    self.attachedView = nil;
}

#pragma mark - NklBrightnessToolViewDelegate

- (void)nklBrightnessToolView:(NklBrightnessToolView *)nklBrightnessToolView valueChange:(CGFloat)newValue {
    self.imageView.image = [NklBrightnessFilter adjustBrightnessOfImage:self.originalImage withValue:newValue];
}
@end
