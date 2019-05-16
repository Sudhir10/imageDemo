#import <UIKit/UIKit.h>
#import "NklView.h"
#import "NklProgressView.h"

//ダイアログ
@interface NklDialog : NklView {
    //情報
    int _type;
    int _result;
    BOOL _checked;
    BOOL _progress;
}

//UI
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblText;
@property (weak, nonatomic) IBOutlet UIImageView *ivIcon;
@property (weak, nonatomic) IBOutlet UIView *vBottom;
@property (weak, nonatomic) IBOutlet UIButton *btnOk;
@property (weak, nonatomic) IBOutlet UIButton *btnNo;
@property (weak, nonatomic) IBOutlet UIButton *btnYes;
@property (weak, nonatomic) IBOutlet NklProgressView *vProgress;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cIconTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cIconBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cTitleBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cTextBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cFooterH;
@property (weak, nonatomic) IBOutlet UIImageView *ivCheck;
@property (weak, nonatomic) IBOutlet UIView *vCheck;
@property (weak, nonatomic) IBOutlet UIButton *btnCheck;
@property (weak, nonatomic) IBOutlet UILabel *lblCheck;
@property (weak, nonatomic) IBOutlet UIButton *btnLink;


//情報
@property ICompletion completion;

//メソッド
- (void)setPreloaderVisible:(BOOL)visible;
- (void)setProgress:(BOOL)progress;
- (BOOL)isProgress;
- (void)setType:(int)type;
- (void)setTitle:(NSString *)title;
- (void)setText:(NSString *)text;
- (void)setOkText:(NSString *)okText;
- (void)setOkEnabled:(BOOL)enabled;
- (void)setNoText:(NSString *)noText;
- (void)setYesText:(NSString *)yesText;
- (void)setCheckText:(NSString *)checkText;
- (void)setIcon:(NSString *)icon;
- (void)setProgressRate:(int)rate;
- (void)setLinkText:(NSString *)linkText;
- (void)waitProgressAnim;
- (void)cancelProgressAnim;
@end
