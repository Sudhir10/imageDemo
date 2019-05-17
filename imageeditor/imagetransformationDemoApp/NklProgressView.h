#import <UIKit/UIKit.h>

//プログレスビュー
@interface NklProgressView : UIView {
    //情報
    int _rate;
    int _rateAnim;
    CGContextRef _context;
}

//メソッド
- (void)setRate:(int)rate;
- (void)waitProgressAnim;
- (void)cancelProgressAnim;
@end
