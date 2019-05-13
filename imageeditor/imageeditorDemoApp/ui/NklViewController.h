#import <UIKit/UIKit.h>
@import AVFoundation;
@import AVKit;

typedef void (^ICompletion)(int result);

//ビューコントローラ
@interface NklViewController : UIViewController <
        UITextFieldDelegate> {
     //UI
     UILabel *_lblBarText;
    
     //情報
     NSString *_textFieldText;
     int _barType;
}

//プロパティ
@property int transition;
@property BOOL navigationPortrait;
@property ICompletion openCompletion;
@property ICompletion closeCompletion;

//アクセス
- (void)setBarTitle:(NSString *)title;
- (void)setBarType:(int)barType;
- (void)initTextField:(UITextField *)textField inputType:(int)inputType;
- (void)setLabelLineHeight:(UILabel *)label lineHeight:(int)lineHeight;
- (AVPlayer *)addAvPlayer:(UIView *)view frame:(CGRect)frame name:(NSString *)name;
- (AVPlayer *)addAvPlayer:(UIView *)view frame:(CGRect)frame path:(NSString *)path;

//アニメ
- (void)openView;
- (void)closeView;
- (void)closeViewByBottom;

//イベント
- (IBAction)onClick:(UIButton *)sender;
- (void)onAfterTextChanged:(NSString *)string;

@end
