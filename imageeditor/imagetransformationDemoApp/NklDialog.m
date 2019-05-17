#import "NklDialog.h"
#import "U.h"
#import "AppDelegate.h"

//ダイアログ
@implementation NklDialog

//====================
//ライフサイクル
//====================
//初期化
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.transition = TRANSITION_DIALOG;
        self.completion = nil;
        _result = DIALOG_NONE;
        _checked = false;
        _progress = false;
    }
    return self;
}

//初期化
- (void)awakeFromNib {
    [super awakeFromNib];
    
    //UI
    _btnOk.exclusiveTouch = true;
    _btnOk.titleLabel.numberOfLines = 2;
    _btnOk.titleLabel.textAlignment = NSTextAlignmentCenter;
    _btnYes.exclusiveTouch = true;
    _btnYes.titleLabel.numberOfLines = 2;
    _btnYes.titleLabel.textAlignment = NSTextAlignmentCenter;
    _btnNo.exclusiveTouch = true;
    _btnNo.titleLabel.numberOfLines = 2;
    _btnNo.titleLabel.textAlignment = NSTextAlignmentCenter;
    _btnLink.titleLabel.numberOfLines = 2;
    _btnLink.titleLabel.textAlignment = NSTextAlignmentCenter;
}

//レイアウトの更新
- (void)updateLayout {
    //アイコンあり
    if (!_ivIcon.hidden) {
        _cIconTop.constant = 12;
        _cIconBottom.constant = 12;
    }
    //アイコンなし
    else {
        _cIconTop.constant = -_ivIcon.frame.size.height;
        _cIconBottom.constant = 32;
    }

    //テキスト+タイトル
    if (!_lblTitle.hidden && !_lblText.hidden) {
        _cTitleBottom.constant = 24;
        _cTextBottom.constant = 32;
    }
    //タイトルのみ
    else if (!_lblTitle.hidden) {
        _cTitleBottom.constant = 32;
        _cTextBottom.constant = -_lblText.frame.size.height;
    }
    //テキストのみ
    else {
        _cTitleBottom.constant = -_lblTitle.frame.size.height;
        _cTextBottom.constant = 32;
    }
    
    
    //フッタあり
    if (!_vBottom.hidden) {
        _cFooterH.constant = 56;
    }
    //フッタなし
    else {
        _cFooterH.constant = 0;
    }
    
    //チェックあり
    if (!_vCheck.hidden) {
        _cIconBottom.constant = 24+64+24;
        _cTextBottom.constant += 24+16;
    }
    [self setNeedsLayout];
}


//====================
//アクセス
//====================
//プリローダー表示の指定
- (void)setPreloaderVisible:(BOOL)visible {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(),^{
            [self setPreloaderVisible:visible];
        });
        return;
    }

    //プリローダー表示の指定
    if (visible) {
        _ivIcon.image = [UIImage imageNamed:@"preloader_dialog"];
    }
    [U setPreloaderVisible:_ivIcon visible:visible];
    [self updateLayout];
}

//プログレスの指定
- (void)setProgress:(BOOL)progress {
    _progress = progress;
}

//プログレスの取得
- (BOOL)isProgress {
    return _progress;
}

//種別の指定
- (void)setType:(int)type {
    _type = type;
    if (_type == DIALOG_ALERT) {
        _btnOk.hidden = false;
        _btnNo.hidden = true;
        _btnYes.hidden = true;
    } else if (_type == DIALOG_CONFIRM) {
        _btnOk.hidden = true;
        _btnNo.hidden = false;
        _btnYes.hidden = false;
    } else if (_type == DIALOG_CHECK) {
        _btnOk.hidden = false;
        _btnNo.hidden = true;
        _btnYes.hidden = true;
        _checked = false;
        _vCheck.hidden = false;
        _ivCheck.hidden = false;
    }
    [self updateLayout];
}

//タイトルの指定
- (void)setTitle:(NSString *)title {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(),^{
            [self setTitle:title];
        });
        return;
    }
    
    //タイトルの指定
    if (title == nil || [title isEqualToString:@""]) {
        _lblTitle.hidden = true;
    } else {
        _lblTitle.text = title;
        _lblTitle.hidden = false;
    }
    [self updateLayout];
}

//テキストの指定
- (void)setText:(NSString *)text {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(),^{
            [self setText:text];
        });
        return;
    }
    
    //テキストの指定
    if (text == nil || [text isEqualToString:@""]) {
        _lblText.hidden = true;
    } else {
        _lblText.text = text;
        _lblText.hidden = false;
    }
    [self updateLayout];
}

//OKテキストの指定
- (void)setOkText:(NSString *)okText {
    [_btnOk setTitle:okText forState:UIControlStateNormal];
    _vBottom.hidden = (okText==nil);
    [self updateLayout];
}

//OK有効の指定
- (void)setOkEnabled:(BOOL)enabled {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(),^{
            [self setOkEnabled:enabled];
        });
        return;
    }
    
    //OK有効の指定
    _btnOk.enabled = enabled;
}

//Noテキストの指定
- (void)setNoText:(NSString *)noText {
    [_btnNo setTitle:noText forState:UIControlStateNormal];
}

//Yesテキストの指定
- (void)setYesText:(NSString *)yesText {
    [_btnYes setTitle:yesText forState:UIControlStateNormal];
}

//チェックテキストの指定
- (void)setCheckText:(NSString *)checkText {
    _lblCheck.text = checkText;
}

//アイコンの指定
- (void)setIcon:(NSString *)icon {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(),^{
            [self setIcon:icon];
        });
        return;
    }

    //アイコンの指定
    [U stopImageViewAnim:_ivIcon];
    if (icon == nil) {
        _ivIcon.hidden = true;
    }
    //画像+プログレス
    else if ([icon isEqualToString:@"icon_ble"] ||
            [icon isEqualToString:@"icon_wifi_disable"]) {
        _ivIcon.image = [UIImage imageNamed:icon];
        _ivIcon.hidden = false;
        [self setProgress:true];
        [self setProgressRate:0];
    }
    //アニメ
    else {
        _ivIcon.hidden = false;
        [U startImageViewAnim:_ivIcon name:icon];
    }
    [self updateLayout];
}

//プログレス割合の指定
- (void)setProgressRate:(int)rate {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(),^{
            [self setProgressRate:rate];
        });
        return;
    }

    //プログレス割合の指定
    if (_progress && _vProgress != nil) {
        _vProgress.hidden = !(rate >= 0);
        [_vProgress setRate:rate];
    }
}

//リンクテキストの指定
- (void)setLinkText:(NSString *)linkText {
    [_btnLink setTitle:linkText forState:UIControlStateNormal];
}

//プログレスアニメの待機
- (void)waitProgressAnim {
    if (_vProgress != nil && !_vProgress.hidden) {
        [_vProgress waitProgressAnim];
    }
}

//プログレスアニメのキャンセル
- (void)cancelProgressAnim {
    if (_vProgress != nil && !_vProgress.hidden) {
        [_vProgress cancelProgressAnim];
    }
}


//====================
//イベント
//====================
//ボタンクリック時に呼ばれる
- (IBAction)onClick:(UIButton*)sender {
	int tag = (int)sender.tag;
    //はい
    if (tag == 2000) {
        if (_type == DIALOG_CHECK) {
            _result = _btnCheck.selected ? DIALOG_YES : DIALOG_NO;
        } else {
            _result = DIALOG_YES;
        }
        [self closeView];
    }
    //いいえ
    else if (tag == 2001) {
        _result = DIALOG_NO;
        [self closeView];
    }
    //リンク
    else if (tag == 2002) {
        if (_completion != nil) {
            _completion(DIALOG_LINK);
        }
    }
    //チェック
    else if (tag == 2003) {
        _btnCheck.selected = !_btnCheck.selected;
    }
}

//アニメ終了時に呼ばれる
- (void)animationDidStop:(NSString *)animId
    finished:(NSNumber *)finished context:(void *)context {
    U.userInteractionEnabled = true;
    if ([animId isEqualToString:@"closeViewByDialog"]) {
        //UI
        [U stopImageViewAnim:_ivIcon];
        [U setPreloaderVisible:_ivIcon visible:false];
        [self onDisappear];
        [APP_DELEGATE removeOverlay];
        if (_vProgress != nil) {
            [_vProgress cancelProgressAnim];
        }
        
        //通知
        if (_completion != nil && _result != DIALOG_NONE) {
            _completion(_result);
        } else if (self.closeCompletion != nil) {
            self.closeCompletion(1);
        }
    }
}
@end
