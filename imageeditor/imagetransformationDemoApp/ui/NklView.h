#import <UIKit/UIKit.h>

typedef void (^ICompletion)(int result);

//基本ビュー
@interface NklView : UIView

//プロパティ
@property int transition;
@property ICompletion closeCompletion;

//ライフサイクル
- (void)onAppear;
/**
 * 表示後に呼ばれる。
 */
- (void)onDidAppear;
- (void)onDisappear;

//イベント
- (IBAction)onClick:(UIButton*)sender;

//アニメ
- (void)openView;
- (void)closeView;
@end
