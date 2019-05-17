//
//  U.h
//  imageeditorDemoApp
//
//  Created by Roshan Mishra on 13/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NklView.h"
#import "AppDelegate.h"
#import "NklDialog.h"
//#import "NklViewController.h"

NS_ASSUME_NONNULL_BEGIN
#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

//トランジション定数
#define TRANSITION_NORMAL      0
#define TRANSITION_CROSS       1
#define TRANSITION_BOTTOM      2
#define TRANSITION_DIALOG      3
#define TRANSITION_ACTIONSHEET 4
#define TRANSITION_FULLSCREEN  5

#define DIALOG_ALERT 0
#define DIALOG_CONFIRM 1
#define DIALOG_CHECK 2
#define DIALOG_YES -1
#define DIALOG_NO -2
#define DIALOG_CANCEL -3
#define DIALOG_LINK -4
#define DIALOG_NONE -9

//マクロ
#define APP_DELEGATE U.appDelegate
#define SCREEN [[UIScreen mainScreen] bounds].size
#define COLOR_DARKGRAY RGB(128,128,128)
#define COLOR_ORANGE RGB(255,247,0)

#define SCREEN [[UIScreen mainScreen] bounds].size

//システム情報
static AppDelegate *_appDelegate;
static NklDialog *_currentDialog;
static NklDialog *_currentDialog;


@interface U : NSObject

//初期化
+ (void)init;
+ (AppDelegate *)appDelegate;

//UI
+ (NklView *)loadView:(NSString *)name;
//+ (NklViewController *)loadViewController:(NSString *)name;

+ (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled;
+ (BOOL)userInteractionEnabled;
+ (void)showConfirmDialog:(NSString *)title text:(NSString *)text
                   noText:(NSString *)noText yesText:(NSString *)yesText
               completion:(void (^)(int result))completion;
+ (NSString *)res2str:(NSString *)resId;
+ (void)sleep:(float)time;
+ (void)setPreloaderVisible:(UIView *)view visible:(BOOL)visible;
+ (void)stopImageViewAnim:(UIImageView *)iv;
+ (void)startImageViewAnim:(UIImageView *)iv name:(NSString *)name;
+ (void)startImageViewAnim:(UIImageView *)iv name:(NSString *)name
                  duration:(int)duration;
+ (NklDialog *)currentDialog;
+ (void)setCurrentDialog:(NklDialog *)currentDialog;
@end

NS_ASSUME_NONNULL_END
