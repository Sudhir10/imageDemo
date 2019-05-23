//
//  NklImageEditorViewController.m
//  imageeditorDemoApp
//
//  Created by Roshan Mishra on 10/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import "NklImageEditorViewController.h"


#import <imagetransformation/imagetransformation-Swift.h>

#import "U.h"
#import "NlkUtility.h"

#import "NklBrightnessToolView.h"
#import "NklFilterToolView.h"
#import "NklResizeToolView.h"
#import "NklPhotoCropAndStraightenView.h"

#import "NklResize.h"
#import "NklCrop.h"


// image editor view controller
@implementation NklImageEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.originalImage = [UIImage imageNamed:@"sample"];
    self.imageView.image = self.originalImage;
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

//====================
//event
//====================
//Called when scale button click
- (IBAction)scaleButtonClick:(UIButton*)sender {
    UIView* v = [U loadView:@"NklBottomMenuView"];
    v.frame = CGRectMake(0, SCREEN.height - 44, self.view.frame.size.width, 44);
    [self.view addSubview:v];
}

//Called when brightness button click
- (IBAction)onBrightnessClick:(id)sender {
    [self changeBottomViewToIcon:YES];
    self.attachedView = (NklBrightnessToolView*)[U loadView:@"NklBrightnessToolView"];
    ((NklBrightnessToolView*)self.attachedView ).listener = self;
    preferedBottomViewOffset = 88;
    preferedBottomViewSize.height = 44;
    preferedBottomViewSize.width = 0;
    self.attachedView.frame = CGRectMake(0, SCREEN.height - preferedBottomViewOffset, self.view.frame.size.width, preferedBottomViewSize.height);
    [self.view addSubview:self.attachedView];
}

//Called when crop button click
- (IBAction)cropClick:(id)sender {
    self.vBottomMenu.hidden = FALSE;
    self.attachedView = [[NklPhotoCropAndStraightenView alloc] initWithFrame:self.view.bounds image:self.originalImage maxRotationAngle:0.5];
    preferedBottomViewSize.height = SCREEN.height - 165;
    preferedBottomViewSize.width = 0;
    preferedBottomViewOffset = SCREEN.height - 120;
    self.attachedView.frame = CGRectMake(0, SCREEN.height - preferedBottomViewOffset, self.view.frame.size.width, preferedBottomViewSize.height);
    self.attachedView.backgroundColor = UIColor.whiteColor;
    self.attachedView.clipsToBounds = YES;
    [self.view addSubview:self.attachedView];
    [self changeBottomViewToIcon:YES];
}

//Called when filter button click
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
    [self changeBottomViewToIcon:YES];
}

//Called when incline button click
- (IBAction)inclineClick:(id)sender {
}

//Called when rotate button click
- (IBAction)rotateClick:(id)sender {
}

//Called when resize button click
- (IBAction)resizeClick:(id)sender {
    self.attachedView = [U loadView:@"NklResizeToolView"];
    ((NklResizeToolView*)self.attachedView ).listener = self;
    preferedBottomViewSize.height = SCREEN.height;
    preferedBottomViewSize.width = 0;
    preferedBottomViewOffset = SCREEN.height;

    self.attachedView.frame = CGRectMake(0, SCREEN.height - preferedBottomViewOffset, self.view.frame.size.width, preferedBottomViewSize.height);
    [self.view addSubview:self.attachedView];

}

//Called when cancel button click
- (IBAction)onCancelClick:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Are you sure you want to discard the changes in the selected files?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self removeAttachedView];
        self.imageView.image = self.originalImage;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];

}

//Called when save button click
- (IBAction)onSaveClick:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Save: Do you want to save the changes you made. Photo will appear in phone gallery?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self.attachedView isKindOfClass:[NklPhotoCropAndStraightenView class]]) {
            NklPhotoCropAndStraightenView *cropView = (NklPhotoCropAndStraightenView*)self.attachedView;
            UIImage *cropedImage = [NklCrop cropImage:self.originalImage
                   translation:[cropView photoTranslation]
                     transform:cropView.photoContentView.transform
                         angle:cropView.angle
                      cropSize:cropView.cropView.frame.size
                 imageViewSize:cropView.photoContentView.bounds.size];
            self.imageView.image = cropedImage;            
        }

        [self removeAttachedView];
        //save image
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)onDiscardClick:(id)sender {
    [self changeBottomViewToIcon:NO];
    [self removeAttachedView];
    self.imageView.image = self.originalImage;
}

- (IBAction)onAcceptClick:(id)sender {
    
    if ([self.attachedView isKindOfClass:[NklPhotoCropAndStraightenView class]]) {
        NklPhotoCropAndStraightenView *cropView = (NklPhotoCropAndStraightenView*)self.attachedView;
        UIImage *cropedImage = [NklCrop cropImage:self.originalImage
                                      translation:[cropView photoTranslation]
                                        transform:cropView.photoContentView.transform
                                            angle:cropView.angle
                                         cropSize:cropView.cropView.frame.size
                                    imageViewSize:cropView.photoContentView.bounds.size];
        self.imageView.image = cropedImage;
    }
    self.originalImage = self.imageView.image;
    
    [self changeBottomViewToIcon:NO];
    [self removeAttachedView];    
}

// remove attached view
- (void)removeAttachedView {
    [self.attachedView removeFromSuperview];
    self.attachedView = nil;
}

// change bottom view appearance
- (void) changeBottomViewToIcon:(BOOL)icon {
    // change text
    [self.cancelButton setTitle:icon ? @"✕" : @"Cancel" forState:UIControlStateNormal];
    [self.saveButton setTitle:icon ? @"✓" : @"Save" forState:UIControlStateNormal];
    
    // remove previous selector
    [self.saveButton removeTarget:self action:@selector(onCancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton removeTarget:self action:@selector(onSaveClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.saveButton removeTarget:self action:@selector(onDiscardClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton removeTarget:self action:@selector(onAcceptClick:) forControlEvents:UIControlEventTouchUpInside];

    // add target
    [self.saveButton addTarget:self action: icon ? @selector(onAcceptClick:) : @selector(onSaveClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton addTarget:self action: icon ? @selector(onDiscardClick:) : @selector(onCancelClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - NklBrightnessToolViewDelegate

//Called when brightness value change
- (void)nklBrightnessToolView:(NklBrightnessToolView *)nklBrightnessToolView valueChange:(CGFloat)newValue {
    self.imageView.image = [NklFilter adjustBrightnessOfImage:self.originalImage withValue:newValue];
}

//Called when filter selected
- (void)onFilterSelected:(NklFilterType)filterType {
    self.imageView.image = [NklFilter filterImageOnImage:self.originalImage byType:filterType];
}

//Called when resize value change
- (void)nklResizeToolView:(NklResizeToolView *)nklresizeToolView valueChange:(CGFloat)newValue {
    self.imageView.image = [NklResize resizeImage:self.originalImage byPercentage:newValue];
}

- (void)nklResizeToolView:(NklResizeToolView *)nklresizeToolView doneClickWithValueChange:(CGFloat)newValue {
    [self removeAttachedView];
    self.imageView.image = [NklResize resizeImage:self.originalImage byPercentage:newValue];
    self.originalImage = self.imageView.image;
}
//Called when cancel clicked on resize view
- (void)nklResizeToolViewCancelClick:(NklResizeToolView *)nklresizeToolView {
    [self removeAttachedView];
    self.imageView.image = self.originalImage;
}

@end
