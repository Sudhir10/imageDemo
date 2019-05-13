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
//#import "NklViewController.h"

NS_ASSUME_NONNULL_BEGIN

//トランジション定数
#define TRANSITION_NORMAL      0
#define TRANSITION_CROSS       1
#define TRANSITION_BOTTOM      2
#define TRANSITION_DIALOG      3
#define TRANSITION_ACTIONSHEET 4
#define TRANSITION_FULLSCREEN  5

//マクロ
#define APP_DELEGATE U.appDelegate
#define SCREEN [[UIScreen mainScreen] bounds].size

//システム情報
static AppDelegate *_appDelegate;


@interface U : NSObject

//初期化
+ (void)init;
+ (AppDelegate *)appDelegate;

//UI
+ (NklView *)loadView:(NSString *)name;
//+ (NklViewController *)loadViewController:(NSString *)name;

+ (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled;
+ (BOOL)userInteractionEnabled;

@end

NS_ASSUME_NONNULL_END
