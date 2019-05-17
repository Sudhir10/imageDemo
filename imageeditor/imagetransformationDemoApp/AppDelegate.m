//
//  AppDelegate.m
//  imageeditorDemoApp
//
//  Created by Roshan Mishra on 10/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "U.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)openOverlay:(NklView*)overlay {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(),^{
            [self openOverlay:overlay];
        });
        return;
    }
    
    //オーバーレイのオープン
    if (_overlayControl != nil) return;
    CGRect frame = CGRectMake(0, 0, SCREEN.width, SCREEN.height);
    _overlayControl = [[UIControl alloc] initWithFrame:frame];
    _overlayControl.autoresizingMask =
    UIViewAutoresizingFlexibleWidth|
    UIViewAutoresizingFlexibleHeight;
    _overlayControl.backgroundColor = [UIColor clearColor];
    overlay.frame = frame;
    [_overlayControl addSubview:overlay];
    [self.window addSubview:_overlayControl];
    [overlay openView];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NklImageEditorViewController *imageEditorViewController = [[NklImageEditorViewController alloc] initWithNibName:@"NklImageEditorViewController" bundle:nil];
    //UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imageEditorViewController];
    self.window.rootViewController = imageEditorViewController;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)removeOverlay {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(),^{
            [self removeOverlay];
        });
        return;
    }
    
    //オーバーレイの削除
    if (_overlayControl == nil) return;
    [_overlayControl removeFromSuperview];
    _overlayControl = nil;
    
    if (U.currentDialog != nil) {
        U.currentDialog = nil;
    }
    
    _showLocationManager = NO;
    [self removeHiddenDialog];
}
/**
 * 表示しなかったダイアログの情報を削除して、ダイアログ表示処理を実行する。
 */
- (void)removeHiddenDialog
{
//    if (_hiddenDialogs.count > 0) {
//        NSString *className = (NSString*)[_hiddenDialogs objectAtIndex:0];
//        if ([className isEqualToString:NSStringFromClass([NklNoticeInfoDialog class])]) {
//            [_hiddenDialogs removeObject:className];
//            [_topView updateCameraView];
//        } else if ([className isEqualToString:NSStringFromClass([PHPhotoLibrary class])]) {
//            [_hiddenDialogs removeObject:className];
//            [self confirmPermissionPhotoLibrary];
//        } else if ([className isEqualToString:NSStringFromClass([UNUserNotificationCenter class])]) {
//            [_hiddenDialogs removeObject:className];
//            [self confirmPermissionUserNotification];
//        } else if ([className isEqualToString:NSStringFromClass([CLLocationManager class])]) {
//            [_hiddenDialogs removeObject:className];
//            [U requestLocationAuthorization];
//        }
//    }
}

@end
