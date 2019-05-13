/*
 * Copyright (c) 2016. Nikon. All rights reserved.
 */

/**
 * @file NklCommonLog.m
 */

#import "NklCommonLog.h"

/** ライブラリ名 */
NSString *NklCommonLogLibName = @"IMAGE";

/** ダンプ出力最大サイズ */
const int NklCommonLogDumpOutMaxSize = 64;

int NklCommonLogConfigLogLevel = 0;

/**
 * ログ出力を行う為の共通処理クラス
 */
@implementation NklCommonLog

+ (void)load
{
#if DEBUG
    NklCommonLogConfigLogLevel = 99;
    
    // ログレベルを環境変数から取得する
    NSString *logLevelStr = [[[NSProcessInfo processInfo]environment]objectForKey:@"LOG_LEVEL"];
    if (logLevelStr) {
        NklCommonLogConfigLogLevel = [logLevelStr intValue];
    }
#else
    NklCommonLogConfigLogLevel = 0;
#endif
}

/**
 * トレースログの出力
 *
 * @param tag TAG
 * @param msg 出力メッセージ
 */
+ (void)trace:(NSString*)tag
      message:(NSString*)msg
{
    if (NklCommonLogLogLevelVerbose <= NklCommonLogConfigLogLevel) {
        NSLog(@"V/%@: %@", tag, [NklCommonLog build:NklCommonLogOutputLevelTrace
                                            message:msg]);
    }
}

/**
 * ダンプログ
 *
 * @param tag  TAG
 * @param msg  メッセージ
 * @param data ダンプ出力するデータ
 */
+ (void)dump:(NSString*)tag
     message:(NSString*)msg
        data:(NSData*)data
{
    if (NklCommonLogLogLevelVerbose <= NklCommonLogConfigLogLevel) {
        NSLog(@"V/%@: %@", tag, [NklCommonLog build:NklCommonLogOutputLevelDump
                                            message:[NklCommonLog buildDump:data]]);
    }
}

/**
 * デバッグログの出力
 *
 * @param tag TAG
 * @param msg 出力メッセージ
 */
+ (void)debug:(NSString*)tag
      message:(NSString*)msg
{
    if (NklCommonLogLogLevelDebug <= NklCommonLogConfigLogLevel) {
        NSLog(@"D/%@: %@", tag, [NklCommonLog build:NklCommonLogOutputLevelDebug
                                            message:msg]);
    }
}

/**
 * インフォメーションログの出力
 *
 * @param tag TAG
 * @param msg 出力メッセージ
 */
+ (void)info:(NSString*)tag
     message:(NSString*)msg
{
    if (NklCommonLogLogLevelInfo <= NklCommonLogConfigLogLevel) {
        NSLog(@"I/%@: %@", tag, [NklCommonLog build:NklCommonLogOutputLevelInfo
                                            message:msg]);
    }
}

/**
 * エラーログの出力
 *
 * @param tag TAG
 * @param msg 出力メッセージ
 */
+ (void)error:(NSString*)tag
      message:(NSString*)msg
{
    if (NklCommonLogLogLevelError <= NklCommonLogConfigLogLevel) {
        NSLog(@"E/%@: %@", tag, [NklCommonLog build:NklCommonLogOutputLevelError
                                            message:msg]);
    }
}

/**
 * バイト配列をダンプ文字列にする処理
 *
 * @param data 出力するbyte配列
 * @return ダンプ文字列
 */
+ (NSString*)buildDump:(NSData*)data
{
    NSMutableString *str = [NSMutableString stringWithCapacity:data.length * 3 + 2];
    const unsigned char *p = (const unsigned char*)[data bytes];
    [str appendString:@"["];
    for (NSUInteger i = 0; i < data.length; i++) {
        @autoreleasepool {
            if (i > NklCommonLogDumpOutMaxSize) {
                [str appendString:@"..."];
                break;
            }
            [str appendString:[NSString stringWithFormat:@"%02X", p[i]]];
            if (i != data.length - 1) {
                [str appendString:@" "];
            }
        }
    }
    [str appendString:@"]"];
    return str;
}

/**
 * 文字列の構築
 *
 * @param level ログ出力レベル
 * @param msg   ログ出力メッセージ
 * @return ログ出力される文字列
 */
+ (NSString*)build:(NklCommonLogOutputLevel)level
           message:(NSString*)msg
{
    switch (level) {
        case NklCommonLogOutputLevelTrace:
            return [NSString stringWithFormat:@"[%@] <TRACE> %@", NklCommonLogLibName, msg];
        case NklCommonLogOutputLevelDump:
            return [NSString stringWithFormat:@"[%@] <DUMP> %@", NklCommonLogLibName, msg];
        default:
            return [NSString stringWithFormat:@"[%@] %@", NklCommonLogLibName, msg];
    }
}


@end
