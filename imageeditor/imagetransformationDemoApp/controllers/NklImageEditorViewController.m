//
//  NklImageEditorViewController.m
//  imageeditorDemoApp
//
//  Created by Roshan Mishra on 10/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import "NklImageEditorViewController.h"
#import "U.h"

#import "NlkUtility.h"
#import "NklBrightnessToolView.h"
#import "NklFilterToolView.h"
#import "NklResizeToolView.h"
#import "PhotoTweakView.h"

#import "NklResize.h"
#import "NklCrop.h"

#import <imagetransformation/imagetransformation-Swift.h>

@implementation NklImageEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.originalImage = [UIImage imageNamed:@"sample"];
    self.imageView.image = self.originalImage;
    self.vBottomMenu.hidden = TRUE;
}

- (void)viewDidLayoutSubviews {
    if (self.attachedView != nil) {
        self.attachedView.frame = CGRectMake(0,
                                             SCREEN.height - (preferedBottomViewOffset + [NlkUtility bottomSafeInsetSize]),
                                             preferedBottomViewSize.width == 0 ? self.view.frame.size.width : preferedBottomViewSize.width,
                                             preferedBottomViewSize.height);
//        self.imageViewBottomConstraint.constant = 44 + ;
    } else {
//        self.imageViewBottomConstraint.constant = 0;
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
    ((NklBrightnessToolView*)self.attachedView ).listener = self;
    preferedBottomViewOffset = 88;
    preferedBottomViewSize.height = 44;
    preferedBottomViewSize.width = 0;
    self.attachedView.frame = CGRectMake(0, SCREEN.height - preferedBottomViewOffset, self.view.frame.size.width, preferedBottomViewSize.height);
    [self.view addSubview:self.attachedView];
}
- (IBAction)cropClick:(id)sender {
    self.vBottomMenu.hidden = FALSE;
    self.attachedView = [[PhotoTweakView alloc] initWithFrame:self.view.bounds image:self.originalImage maxRotationAngle:0.5];
    preferedBottomViewSize.height = SCREEN.height - 88;
    preferedBottomViewSize.width = 0;
    preferedBottomViewOffset = SCREEN.height - 44;
    self.attachedView.frame = CGRectMake(0, SCREEN.height - preferedBottomViewOffset, self.view.frame.size.width, preferedBottomViewSize.height);
    self.attachedView.backgroundColor = UIColor.whiteColor;
    self.attachedView.clipsToBounds = YES;
    [self.view addSubview:self.attachedView];
    
}

- (IBAction)filterClick:(id)sender {
    self.vBottomMenu.hidden = FALSE;
    self.attachedView = [U loadView:@"NklFilterToolView"];
    ((NklFilterToolView*)self.attachedView ).originalImage = self.originalImage;
    ((NklFilterToolView*)self.attachedView ).listener = self;
    preferedBottomViewOffset = 200;
    preferedBottomViewSize.height = preferedBottomViewOffset - 44;
    preferedBottomViewSize.width = 0;
    self.attachedView.frame = CGRectMake(0, SCREEN.height - preferedBottomViewOffset, self.view.frame.size.width, preferedBottomViewSize.height);
    [self.view addSubview:self.attachedView];
}

- (IBAction)inclineClick:(id)sender {
}

- (IBAction)rotateClick:(id)sender {
}

- (IBAction)resizeClick:(id)sender {
    self.attachedView = [U loadView:@"NklResizeToolView"];
    ((NklResizeToolView*)self.attachedView ).listener = self;
    preferedBottomViewSize.height = SCREEN.height;
    preferedBottomViewSize.width = 0;
    preferedBottomViewOffset = SCREEN.height;

    self.attachedView.frame = CGRectMake(0, SCREEN.height - preferedBottomViewOffset, self.view.frame.size.width, preferedBottomViewSize.height);
    [self.view addSubview:self.attachedView];

}

- (IBAction)onCancelClick:(id)sender {
    
//    [U showConfirmDialog:@"Title"
//                    text:nil
//                  noText:[U res2str:@"MID_COMMON_OK"]
//                 yesText:[U res2str:@"MID_COMMON_HELP"]
//              completion:^(int result) {
//                  if (result == DIALOG_YES) {
//                  }
//              }];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Are you sure you want to discard the changes in the selected files?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self removeAttachedView];
        self.vBottomMenu.hidden = TRUE;

        self.imageView.image = self.originalImage;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];

}

- (IBAction)onSaveClick:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Save: Do you want to save the changes you made. Photo will appear in phone gallery?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self.attachedView isKindOfClass:[PhotoTweakView class]]) {
            PhotoTweakView *cropView = (PhotoTweakView*)self.attachedView;
            UIImage *cropedImage = [NklCrop cropImage:self.originalImage
                   translation:[cropView photoTranslation]
                     transform:cropView.photoContentView.transform
                         angle:cropView.angle
                      cropSize:cropView.cropView.frame.size
                 imageViewSize:cropView.photoContentView.bounds.size];
            self.imageView.image = cropedImage;            
        }

        [self removeAttachedView];
        self.vBottomMenu.hidden = TRUE;
        //save image
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)removeAttachedView {
    [self.attachedView removeFromSuperview];
    self.attachedView = nil;
}

#pragma mark - NklBrightnessToolViewDelegate

- (void)nklBrightnessToolView:(NklBrightnessToolView *)nklBrightnessToolView valueChange:(CGFloat)newValue {
    self.imageView.image = [NklFilter adjustBrightnessOfImage:self.originalImage withValue:newValue];
//    [NklBrightnessFilter adjustBrightnessOfImage:self.originalImage withValue:newValue];
}

- (void)onFilterSelected:(NklFilterType)filterType {
    self.imageView.image = [NklFilter filterImageOnImage:self.originalImage byType:filterType];
}

- (void)nklResizeToolView:(NklResizeToolView *)nklresizeToolView valueChange:(CGFloat)newValue {
    NSLog(@"change value == %f",newValue);
    
    [self removeAttachedView];
    self.vBottomMenu.hidden = TRUE;
    self.imageView.image = [NklResize resizeImage:self.imageView.image byPercentage:newValue];
}

- (void)nklResizeToolViewCancelClick:(NklResizeToolView *)nklresizeToolView {
    [self removeAttachedView];
    self.vBottomMenu.hidden = TRUE;
}
@end
