//
//  U.m
//  imageeditorDemoApp
//
//  Created by Roshan Mishra on 13/05/19.
//  Copyright © 2019 HCL Technology Pvt Ltd. All rights reserved.
//

#import "U.h"

@implementation U

//====================
//初期化
//====================
//初期化
+ (void)init {
    //ナビゲーション
    _appDelegate = ((AppDelegate*)[[UIApplication sharedApplication] delegate]);
}

//====================
//UI
//====================
//ビューの読み込み
+ (NklView *)loadView:(NSString *)name  {
    NklView *v = (NklView *)[[[NSBundle mainBundle]
                              loadNibNamed:name
                              owner:nil options:nil] firstObject];
    return v;
}

//ビューコントローラの読み込み
/*+ (NklViewController *)loadViewController:(NSString *)name {
    NklViewController *vc = (NklViewController *)[[[NSBundle mainBundle]
                                                   loadNibNamed:name
                                                   owner:nil options:nil] firstObject];
    return vc;
}*/

//操作有効の指定
+ (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(),^{
            [self setUserInteractionEnabled:userInteractionEnabled];
        });
        return;
    }
    
    //操作有効の指定
    APP_DELEGATE.window.userInteractionEnabled = userInteractionEnabled;
}

//操作有効の取得
+ (BOOL)userInteractionEnabled {
    return APP_DELEGATE.window.userInteractionEnabled;
}

@end
