#import "NklViewController.h"
#import "U.h"
#import "AppDelegate.h"
#import "NklNavigationController.h"
#import "NklBarButtonView.h"

//ビューコントローラ
@implementation NklViewController

//====================
//ライフサイクル
//====================
//ビューロード時に呼ばれる
- (void)viewDidLoad {
    [super viewDidLoad];
    self.transition = TRANSITION_NORMAL;
    self.navigationPortrait = true;
    self.openCompletion = nil;
    self.closeCompletion = nil;
    
    //UI
    _lblBarText = [[UILabel alloc] initWithFrame:CGRectZero];
    
    //情報
    _textFieldText = @"";
    _barType = -1;

    //バックボタンの非表示
    self.navigationItem.hidesBackButton = true;
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
            initWithTitle:@"" style:UIBarButtonItemStylePlain
            target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:btnBack];
}

//ビュー表示時前に呼ばれる
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
    //ステータスバー変更通知の追加
    [[NSNotificationCenter defaultCenter] addObserver:self
           selector:@selector(onStatusBarFrameChanged:)
           name:UIApplicationDidChangeStatusBarFrameNotification
           object:nil];
    
    // タイトルバーのラベルがない場合は再セットする
    if (self.navigationItem.titleView == nil && _lblBarText.text != nil) {
        self.navigationItem.titleView = _lblBarText;
    }
    
    //バーの更新
    if (@available(iOS 11.0, *)) {
        if (_barType >= 0) {
             [self setBarType:_barType];
        }
    }
}

//ステータスバー変更時に呼ばれる
- (void)onStatusBarFrameChanged:(NSNotification*)notification {
    //無処理
}

//ビュー非表示時前に呼ばれる
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    
    //ステータスバー変更通知の削除
    [[NSNotificationCenter defaultCenter] removeObserver:self
           name:UIApplicationDidChangeStatusBarFrameNotification
           object:nil];
    
    self.navigationItem.titleView = nil;
}

//ステータスバー表示の取得
- (BOOL)prefersStatusBarHidden {
    return false;
}

//ステータスバー状態の取得
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


//====================
//アクセス
//====================
//バータイトルの指定
- (void)setBarTitle:(NSString *)title {
    if (title == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:
            [UIImage imageNamed:@"logo"]];
        self.navigationItem.titleView = imageView;
        return;
    } else {
        self.navigationItem.titleView = nil;
        _lblBarText.font = [UIFont boldSystemFontOfSize:16.0];
        _lblBarText.text = title;
        [_lblBarText sizeToFit];
        self.navigationItem.titleView = _lblBarText;
    }
}

//バー種別の指定
- (void)setBarType:(int)barType {
    _barType = barType;
    self.navigationItem.leftBarButtonItems = nil;
    self.navigationItem.rightBarButtonItems = nil;
    _lblBarText.textColor = COLOR_WHITE;
    
    //戻る
    if (barType == BAR_BACK) {
        [self addLeftImageButton:@"bar_btn_back" tag:1000];
    }
    //閉じる
    else if (barType == BAR_CLOSE) {
        UIButton *btnLeft = [self addLeftImageButton:@"bar_btn_close_normal" tag:1000];
        [btnLeft setImage:[UIImage imageNamed:@"bar_btn_close_pressed"]
                forState:UIControlStateHighlighted];
        [btnLeft setImage:[UIImage imageNamed:@"bar_btn_close_pressed"]
                forState:UIControlStateDisabled];
    }
    //ギャラリー(カメラ)
    else if (barType == BAR_GALLERY_CAMERA) {
        if (!U.galleryEdit) {
            [self addRightTextButton:[U res2str:@"MID_IMPORT_SELECT"]
                    enabled:U.cameraSummaries.count > 0 tag:1003];
            UIButton *btnLeft = [self addLeftImageButton:@"bar_btn_close_normal" tag:1000];
            [btnLeft setImage:[UIImage imageNamed:@"bar_btn_close_pressed"]
                    forState:UIControlStateHighlighted];
            [btnLeft setImage:[UIImage imageNamed:@"bar_btn_close_pressed"]
                    forState:UIControlStateDisabled];
            NklCameraStorage *storage = U.currentStorage;
            NklCameraDirectory *directory = U.currentDirectory;
            UIView* v = [U loadView:@"bar_text_c"];
            UIButton *button = [v.subviews objectAtIndex:0];
            UILabel *label = [v.subviews objectAtIndex:1];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            [button addTarget:self action:@selector(onClick:)
                    forControlEvents:UIControlEventTouchUpInside];
            if (storage == nil || directory == nil) {
                UIFont * font = [UIFont fontWithName:@"Helvetica Neue" size:16];
                [button setTitle:[U res2str:@"MID_IMPORT_FOLDER_ALL"]
                        forState:UIControlStateNormal];
                button.titleLabel.numberOfLines = 1;
                button.titleLabel.font = font;
                label.hidden = true;
            } else {
                UIFont * font = [UIFont fontWithName:@"Helvetica Neue" size:12];
                button.titleLabel.numberOfLines = 2;
                button.titleLabel.font = font;
                NSString *volumeLabel = storage.volumeLabel;
                if (volumeLabel == nil || [volumeLabel isEqualToString:@""]) {
                    volumeLabel = [U res2str:@"MID_COMMON_SLOT1"];
                } else {
                    volumeLabel = [volumeLabel
                            stringByReplacingOccurrencesOfString:@"]]"
                            withString:@"]"];
                }
                [button setTitle:[NSString stringWithFormat:@"%@\n%@",
                        volumeLabel, directory.name]
                        forState:UIControlStateNormal];
                label.text = [NSString stringWithFormat:@" [%@] ",
                        directory.name];
                label.font = font;
                label.hidden = false;
            }
            CGRect rect0 = [button.titleLabel.text
                    boundingRectWithSize:CGSizeMake(SCREEN.width, 44)
                    options:NSStringDrawingUsesLineFragmentOrigin
                    attributes:@{NSFontAttributeName:button.titleLabel.font}
                    context:nil];
            CGRect rect1 = [label.text
                    boundingRectWithSize:CGSizeMake(SCREEN.width, 44)
                    options:NSStringDrawingUsesLineFragmentOrigin
                    attributes:@{NSFontAttributeName:label.font}
                    context:nil];
            v.frame = CGRectMake(0,0,MAX(rect0.size.width+16*2,rect1.size.width+16*2),44);
            self.navigationItem.titleView = v;
        } else {
            _lblBarText.textColor = COLOR_ORANGE;
            NSString *textL = U.photoChecks.count > 0?
                    [U res2str:@"MID_IMPORT_CANCEL_SELECT"]:
                    [U res2str:@"MID_IMPORT_ALL_SELECT"];
            [self addLeftTextButton:textL
                    enabled:true tag:1002];
            [self addRightTextButton:[U res2str:@"MID_COMMON_CANCEL"]
                    enabled:true tag:1003];
        }
    }
    //キャンセル
    else if (barType == BAR_CANCEL) {
        [self addRightTextButton:[U res2str:@"MID_COMMON_CANCEL"]
                enabled:true tag:1003];
    }
    
    //バー色
    [self.navigationController.navigationBar setBackgroundImage:
            [U imageWithColor:U.galleryEdit?
            COLOR_BG_EDIT:COLOR_BG_BAR]
            forBarPosition:UIBarPositionAny
            barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setNeedsDisplay];
}

//左テキストボタンの追加
- (UIButton *)addLeftTextButton:(NSString *)text enabled:(BOOL)enabled tag:(int)tag {
    UIButton *button = [self makeButton:text tag:tag];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    item.enabled = enabled;
    self.navigationItem.leftBarButtonItems = @[item];
    return button;
}

//右テキストボタンの追加
- (UIButton *)addRightTextButton:(NSString *)text enabled:(BOOL)enabled tag:(int)tag {
    UIButton *button = [self makeButton:text tag:tag];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    item.enabled = enabled;
    self.navigationItem.rightBarButtonItems = @[item];
    return button;
}

//左イメージボタンの追加
- (UIButton *)addLeftImageButton:(NSString *)name tag:(int)tag {
    UIButton *button = [self makeImageButton:name tag:tag];
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 11) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:
                [[NklBarButtonView alloc] initWithButton:button align:ALIGN_LEFT]];
        self.navigationItem.leftBarButtonItems = @[item];
    }
    else {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        UIBarButtonItem *spacer = [[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                target:nil action:nil];
        spacer.width = -16;
        self.navigationItem.leftBarButtonItems = @[spacer, item];
    }
    return button;
}

//右イメージボタンの追加
- (UIButton *)addRightImageButton:(NSString *)name tag:(int)tag {
    UIButton *button = [self makeImageButton:name tag:tag];
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 11) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:
                [[NklBarButtonView alloc] initWithButton:button align:ALIGN_RIGHT]];
        self.navigationItem.leftBarButtonItems = @[item];
    } else {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        UIBarButtonItem *spacer = [[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                target:nil action:nil];
        spacer.width = -16;
        self.navigationItem.rightBarButtonItems = @[spacer, item];
    }
    return button;
}

//ボタンの生成
- (UIButton *)makeButton:(NSString *)text tag:(int)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    button.titleLabel.numberOfLines = 1;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14];;
    [button setTitleColor:COLOR_WHITE forState:UIControlStateNormal];
    [button setTitleColor:COLOR_DARKGRAY forState:UIControlStateHighlighted];
    [button setTitleColor:COLOR_DARKGRAY forState:UIControlStateDisabled];
    [button setTitle:text forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClick:)
            forControlEvents:UIControlEventTouchUpInside];
    CGSize size = [button.titleLabel sizeThatFits:CGSizeMake(SCREEN.width,44)];
    button.frame = CGRectMake(0,0,size.width,44);
    return button;
}

//イメージボタンの生成
- (UIButton *)makeImageButton:(NSString *)name tag:(int)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    UIImage *image = [UIImage imageNamed:name];
    [button setImage:image forState:UIControlStateNormal];
    button.frame = CGRectMake(0,0,40,44);
    button.contentMode = UIViewContentModeCenter;
    [button addTarget:self action:@selector(onClick:)
            forControlEvents:UIControlEventTouchUpInside];
    return button;
}

//テキストフィールドの初期化
- (void)initTextField:(UITextField *)textField inputType:(int)inputType {
    textField.tag = inputType;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    if (inputType == INPUT_TYPE_ID) {
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        textField.secureTextEntry = false;
    } else if (inputType == INPUT_TYPE_PASSWORD) {
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.secureTextEntry = true;
    } else if (inputType == INPUT_TYPE_SMART_DEVICE_NICKNAME) {
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        textField.secureTextEntry = false;
    } else if (inputType == INPUT_TYPE_CREDIT_COMMENT) {
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.secureTextEntry = false;
    }    
}

//ラベルの行間指定
- (void)setLabelLineHeight:(UILabel *)label lineHeight:(int)lineHeight {
    NSMutableParagraphStyle *paragrahStyle =
            [[NSMutableParagraphStyle alloc] init];
    paragrahStyle.minimumLineHeight = lineHeight;
    paragrahStyle.maximumLineHeight = lineHeight;
    NSMutableAttributedString *attributedText =
            [[NSMutableAttributedString alloc] initWithString:label.text];
    [attributedText addAttribute:NSParagraphStyleAttributeName
            value:paragrahStyle
            range:NSMakeRange(0, attributedText.length)];
    label.attributedText = attributedText;
}

//AVプレーヤーの追加
- (AVPlayer *)addAvPlayer:(UIView *)view frame:(CGRect)frame name:(NSString *)name {
    for (CALayer* sublayer in [view.layer sublayers]) {
        [sublayer removeFromSuperlayer];
    }
    NSString *path = [[NSBundle mainBundle]
            pathForResource:name ofType:@"m4v"];
    NSURL *url = [NSURL fileURLWithPath:path];
    AVPlayer *player = [AVPlayer playerWithURL:url];
    player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    layer.frame = frame;
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [view.layer addSublayer:layer];
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(onPlayerItemDidReachEnd:)
            name:AVPlayerItemDidPlayToEndTimeNotification
            object:[player currentItem]];
    return player;
}

//AVプレーヤーの追加
- (AVPlayer *)addAvPlayer:(UIView *)view frame:(CGRect)frame path:(NSString *)path {
    for (CALayer* sublayer in [view.layer sublayers]) {
        [sublayer removeFromSuperlayer];
    }
    path = [U correctDocumentsPath:path];
    NSURL *url = [NSURL fileURLWithPath:path];
    AVPlayer *player = [AVPlayer playerWithURL:url];
    player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    layer.frame = frame;
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [view.layer addSublayer:layer];
    [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(onPlayerItemDidReachEnd:)
            name:AVPlayerItemDidPlayToEndTimeNotification
            object:[player currentItem]];
    return player;
}


//====================
//イベント
//====================
//ボタンクリック時に呼ばれる
- (IBAction)onClick:(UIButton *)sender {
    int tag = (int)sender.tag;
    
    //戻る
    if (tag == 1000) {
        [self closeView];
    }
}

//テキストフィールドクローズ時に呼ばれる
- (IBAction)onTextFieldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
}

//テキストフィールド変更開始時に呼ばれる
-(void)textFieldDidBeginEditing:(UITextField*)textField {
    _textFieldText = textField.text;
    [textField addTarget:self action:@selector(didChangeTextField:)
            forControlEvents:UIControlEventEditingChanged];
}

//テキストフィールド編集完了時に呼ばれる
-(void)textFieldDidEndEditing:(UITextField*)textField {
    [textField removeTarget:self action:@selector(didChangeTextField:)
            forControlEvents:UIControlEventEditingChanged];
}

//テキストフィールドのテキスト変更時に呼ばれる
- (void)didChangeTextField:(UITextField *)textField {
    if ([self checkTextFieldText:textField text:textField.text]) {
        _textFieldText = textField.text;
        [self onAfterTextChanged:textField.text];
    } else {
        textField.text = _textFieldText;
    }
}

//テキストフィールドの文字変更時に呼ばれる
- (BOOL)textField:(UITextField *)textField
        shouldChangeCharactersInRange:(NSRange)range
        replacementString:(NSString *)string {
    //制限
    NSMutableString *text = [textField.text mutableCopy];
    [text replaceCharactersInRange:range withString:string];
    if ([string isEqualToString:@"\n"]) {
        return true;
    } else if ([self checkTextFieldText:textField text:text]) {
        return true;
    }
    return false;
}

//テキストフィールドのテキストのチェック
- (BOOL)checkTextFieldText:(UITextField *)textField text:(NSString *)text {
    int inputType = (int)textField.tag;
    int textFieldMaxLength = 256;
    int textFieldDigit = DIGIT_NONE;
    
    //ID
    if (inputType == INPUT_TYPE_ID) {
        textFieldMaxLength = TEXT_MAX_ID;//文字数制限
        textFieldDigit = DIGIT_ASCII;//ASCII
    }
    //パスワード
    else if (inputType == INPUT_TYPE_PASSWORD) {
        textFieldMaxLength = TEXT_MAX_PASSWORD;//文字数制限
        textFieldDigit = DIGIT_ASCII;//ASCII
    }
    //ニックネーム
    else if (inputType == INPUT_TYPE_SMART_DEVICE_NICKNAME) {
        textFieldMaxLength = TEXT_MAX_SMART_DEVICE_NICKNAME;//文字数制限
        textFieldDigit = DIGIT_ASCII;//ASCII
    }
    //クレジットコメント
    else if (inputType == INPUT_TYPE_CREDIT_COMMENT) {
        textFieldMaxLength = TEXT_MAX_CREDIT_COMMENT;//文字数制限
        textFieldDigit = DIGIT_NONE;//無制限
    }
    
    //制限
    if (textFieldDigit == DIGIT_ASCII) {
        if (![U isAsciiOnly:text]) return false;
    } else if (textFieldDigit == DIGIT_ALPHANUMERIC) {
        if (![U isAlphaNumericOnly:text]) return false;
    }
    if (text.length > textFieldMaxLength) {
        return false;
    }
    return true;
}

//テキストフィールドの文字変更時に呼ばれる
- (void)onAfterTextChanged:(NSString *)string {
}

//AVプレイヤーのループ時に呼ばれる
- (void)onPlayerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}


//====================
//アニメ
//====================
//ビューのオープン
- (void)openView {
    if (_transition == TRANSITION_NORMAL) {
        [self openViewBySlide];
    } else if (_transition == TRANSITION_CROSS) {
        [self openViewByCross];
    } else if (_transition == TRANSITION_BOTTOM) {
        [self openViewByBottom];
    } else if (_transition == TRANSITION_FULLSCREEN) {
        [self openViewByFullScreen];
    }
}

//スライドでビューのオープン
- (void)openViewBySlide {
    NklViewController *current = APP_DELEGATE.getCurrentView;
    [current.navigationController pushViewController:self animated:true];
}

//クロスでビューのオープン
- (void)openViewByCross {
    NklNavigationController *navigationController =
            [[NklNavigationController alloc] init];
    [navigationController setPortrait:self.navigationPortrait];
    [navigationController setNavigationBarHidden:true animated:false];
    [navigationController pushViewController:self animated:false];
    navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    NklViewController *current = APP_DELEGATE.getCurrentView;
    navigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [current.navigationController presentViewController:navigationController
            animated:true completion:nil];
}

//下端でビューのオープン
- (void)openViewByBottom {
    NklNavigationController *navigationController =
            [[NklNavigationController alloc] init];
    [navigationController setPortrait:self.navigationPortrait];
    [navigationController pushViewController:self animated:false];
    navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    NklViewController *current = APP_DELEGATE.getCurrentView;
    [current.navigationController presentViewController:navigationController
            animated:true completion:^() {
        if (self.openCompletion != nil) {
            self.openCompletion(1);
        }
    }];
}

//フルスクリーンでビューのオープン
- (void)openViewByFullScreen {
    NklNavigationController *navigationController =
            [[NklNavigationController alloc] init];
    [navigationController setPortrait:self.navigationPortrait];
    [navigationController setNavigationBarHidden:true animated:false];
    [navigationController pushViewController:self animated:false];
    navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    NklViewController *current = APP_DELEGATE.getCurrentView;
    [current.navigationController presentViewController:navigationController
            animated:false completion:nil];
}

//ビューのクローズ
- (void)closeView {
    //ステータスバー変更通知の削除(クローズ前に通知を無効)
    [[NSNotificationCenter defaultCenter] removeObserver:self
           name:UIApplicationDidChangeStatusBarFrameNotification
           object:nil];

    //ビューのクローズ
    if (_transition == TRANSITION_NORMAL) {
        [self closeViewBySlide];
    } else if (_transition == TRANSITION_CROSS ||
        _transition == TRANSITION_FULLSCREEN) {
        [self closeViewByCross];
    } else if (_transition == TRANSITION_BOTTOM) {
        [self closeViewByBottom];
    }
}

//スライドでビューのクローズ
- (void)closeViewBySlide {
    [self.navigationController popViewControllerAnimated:true];
}

//クロスでビューのクローズ
- (void)closeViewByCross {
    self.view.hidden = SCREEN.width > SCREEN.height;
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self dismissViewControllerAnimated:true completion:^() {
        [APP_DELEGATE.getTopView disconnectBtcDevice:true];
    }];
}

//下端でビューのクローズ
- (void)closeViewByBottom {
    [self dismissViewControllerAnimated:true completion:^() {
        [APP_DELEGATE.getTopView disconnectBtcDevice:true];
        if (self.closeCompletion != nil) {
            self.closeCompletion(1);
        }
    }];
}

//サポートしている画面向きの取得
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.navigationController != nil) {
        return [self.navigationController supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait;
}
@end
