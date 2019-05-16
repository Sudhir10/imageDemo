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

//確認ダイアログの表示
+ (void)showConfirmDialog:(NSString *)title text:(NSString *)text
                   noText:(NSString *)noText yesText:(NSString *)yesText
               completion:(void (^)(int result))completion {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(),^{
            [U showConfirmDialog:title text:text
                          noText:noText yesText:yesText
                      completion:completion];
        });
        return;
    }
    
    //確認ダイアログの表示
    NklDialog *v = (NklDialog *)[U loadView:@"dialog"];
    _currentDialog = v;
    [v setType:DIALOG_CONFIRM];
    [v setTitle:title];
    [v setText:text];
    [v setNoText:noText];
    [v setYesText:yesText];
    [v setCompletion:completion];
    [U init];
    [APP_DELEGATE openOverlay:v];
}
+ (NSString *)res2str:(NSString *)resId {
    return NSLocalizedString(resId, nil);
}
//スリープ
+ (void)sleep:(float)time {
    if (time > 0) {
        [NSThread sleepForTimeInterval:time];
    }
}
+ (void)setPreloaderVisible:(UIView *)view visible:(BOOL)visible {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(),^{
            [U setPreloaderVisible:view visible:visible];
        });
        return;
    }
    
    //インジケータ表示の指定
    if (visible != view.hidden) return;
    [view.layer removeAllAnimations];
    if (visible) {
        view.hidden = false;
        CABasicAnimation* animation = [CABasicAnimation
                                       animationWithKeyPath:@"transform.rotation"];
        animation.additive = true;
        animation.removedOnCompletion = false;
        animation.fillMode = kCAFillModeForwards;
        animation.fromValue = [NSNumber numberWithFloat:0];
        animation.toValue = [NSNumber numberWithFloat:M_PI*2];
        animation.duration = 1;
        animation.repeatCount = INFINITY;
        [view.layer addAnimation:animation forKey:@"IndicatorRotation"];
    } else {
        view.hidden = true;
    }
}
+ (void)stopImageViewAnim:(UIImageView *)iv {
    [iv stopAnimating];
}
+ (void)startImageViewAnim:(UIImageView *)iv name:(NSString *)name {
    [U startImageViewAnim:iv name:name duration:33];
}
//イメージビューのアニメ開始
+ (void)startImageViewAnim:(UIImageView *)iv name:(NSString *)name
                  duration:(int)duration {
    if ([iv isAnimating]) return;//★
    NSMutableArray *images = [NSMutableArray array];
    int num = 0;
    for(; num < 100; num++) {
        UIImage *image = [UIImage imageNamed:
                          [NSString stringWithFormat:@"%@_%d",name,num]];
        if (image == nil) break;
        [images addObject:image];
    }
    iv.image = [images objectAtIndex:0];
    iv.animationImages = images;
    iv.animationRepeatCount = 0;
    iv.animationDuration = ((float)duration/1000.0)*(float)num;
    [iv startAnimating];
}
+ (NklDialog *)currentDialog {
    return _currentDialog;
}
+ (void)setCurrentDialog:(NklDialog *)currentDialog {
    _currentDialog = currentDialog;
}
//AppDelegateの取得
+ (AppDelegate *)appDelegate {
    return _appDelegate;
}
@end
