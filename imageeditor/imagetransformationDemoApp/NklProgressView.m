#import "NklProgressView.h"
#import "U.h"

//プログレスビュー
@implementation NklProgressView

//====================
//ライフサイクル
//====================
//初期化
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        
        //情報
        _rate = 0;
        _rateAnim = 0;
        _context = nil;
    }
    return self;
}


//====================
//アクセス
//====================
//割合の指定
- (void)setRate:(int)rate {
    if (_rate > rate) return;    
    _rate = rate;
    [self setNeedsDisplay];
}

//プログレスアニメの待機
- (void)waitProgressAnim {
    _rate = 100;
    dispatch_async(dispatch_get_main_queue(),^{
        [self setNeedsDisplay];
    });
    while (_rateAnim != 100) {
        [U sleep:0.5f];
    }
}

//プログレスアニメのキャンセル
- (void)cancelProgressAnim {
    _rate = 100;
    _rateAnim = 100;
}


//====================
//描画
//====================
//描画
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    _context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(_context);
    CGContextSetLineWidth(_context, 2);
    [self setColor:COLOR_DARKGRAY];
    [self drawArc:360];
    [self setColor:COLOR_ORANGE];
    [self drawArc:_rateAnim*3.6];
    if (_rate > _rateAnim) {
        _rateAnim++;
        dispatch_async(dispatch_get_global_queue(
            DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
            [U sleep:1.0/60.0];
            dispatch_async(dispatch_get_main_queue(),^{
                [self setNeedsDisplay];
            });
        });
    }
}

//色の指定
- (void)setColor:(UIColor *)color {
    CGFloat r;
    CGFloat g;
    CGFloat b;
    CGFloat a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    CGContextSetRGBStrokeColor(_context, r, g, b, a);
}

//円弧の描画
- (void)drawArc:(float)angle {
    CGContextBeginPath(_context);
    float start = (-90 *M_PI/180);
    float end = ((-90+angle)*M_PI/180);
    CGContextAddArc(_context, 50, 50, 37, start, end, 0);
    CGContextStrokePath(_context);
}
@end
