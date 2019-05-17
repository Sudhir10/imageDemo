//
//  AppDelegate.h
//  imageeditorDemoApp
//
//  Created by Roshan Mishra on 10/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NklImageEditorViewController.h"
#import "NklView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UIControl *_overlayControl;
    BOOL _showLocationManager;

}

@property (strong, nonatomic) UIWindow *window;

- (void)openOverlay:(NklView*)overlay;
- (void)removeOverlay;
@end

