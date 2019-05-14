#import "NklView.h"
#import "U.h"
#import "AppDelegate.h"

//基本ビュー
@implementation NklView

//====================
//ライフサイクル
//====================
//初期化
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.transition = TRANSITION_NORMAL;
        self.closeCompletion = nil;
    }
    return self;
}

//表示時に呼ばれる
- (void)onAppear {
}

/**
 * 表示後に呼ばれる。
 */
- (void)onDidAppear
{
}

//非表示時に呼ばれる
- (void)onDisappear {
}


//====================
//イベント
//====================
//クリック時に呼ばれる
- (IBAction)onClick:(UIButton*)sender {
}

//====================
//アニメ
//====================
//ビューのオープン
- (void)openView {
    if (_transition == TRANSITION_NORMAL) {
    } else if (_transition == TRANSITION_DIALOG) {
        [self openViewByDialog];
    } else if (_transition == TRANSITION_ACTIONSHEET) {
        [self openViewByActionSheet];
    }
}

//ダイアログでのビューのオープン
- (void)openViewByDialog {
    U.userInteractionEnabled = false;
    
    //UI
    [self onAppear];

    //アニメ
    UIView *dialog = [self.subviews objectAtIndex:0];
    dialog.alpha = 0.0f;
    dialog.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
    [UIView beginAnimations:@"openViewByDialog" context:nil];
    [UIView setAnimationDuration:0.2f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelegate:self];
    dialog.alpha = 1.0f;
    dialog.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView commitAnimations];
}

//アクションシートでのビューのオープン
- (void)openViewByActionSheet {
    U.userInteractionEnabled = false;
    
    //UI
    [self onAppear];

    //アニメ
    UIView *v = [self.subviews objectAtIndex:0];
    v.transform = CGAffineTransformMakeTranslation(0, 57*4+15+57+15);
    self.alpha = 0;
    [UIView beginAnimations:@"openViewByActionSheet" context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    v.transform = CGAffineTransformMakeTranslation(0, 0);
    self.alpha = 1;
    [UIView commitAnimations];
}

//ビューのクローズ
- (void)closeView {
   /* if (_transition == TRANSITION_NORMAL) {
        [APP_DELEGATE removeOverlay];
    } else if (_transition == TRANSITION_DIALOG) {
        [self closeViewByDialog];
    } else if (_transition == TRANSITION_ACTIONSHEET) {
        [self closeViewByActionSheet];
    }*/
}

//ダイアログでのビューのクローズ
- (void)closeViewByDialog {
    U.userInteractionEnabled = false;
    
    //アニメ
    UIView *dialog = [self.subviews objectAtIndex:0];
    dialog.alpha = 1.0f;
    [UIView beginAnimations:@"closeViewByDialog" context:nil];
    [UIView setAnimationDuration:0.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    dialog.alpha = 0.0f;
    [UIView commitAnimations];
}

//アクションシートでのビューのクローズ
- (void)closeViewByActionSheet {
    U.userInteractionEnabled = false;
    
    //アニメ
    UIView *v = [self.subviews objectAtIndex:0];
    v.transform = CGAffineTransformMakeTranslation(0, 0);
    self.alpha = 1.0f;
    [UIView beginAnimations:@"closeViewByActionSheet" context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelegate:self];
    v.transform = CGAffineTransformMakeTranslation(0, 57*4+15+57+15);
    self.alpha = 0.0f;
    [UIView commitAnimations];
}

//アニメ終了時に呼ばれる
- (void)animationDidStop:(NSString *)animId
    finished:(NSNumber *)finished context:(void *)context {
    U.userInteractionEnabled = true;
}
@end
