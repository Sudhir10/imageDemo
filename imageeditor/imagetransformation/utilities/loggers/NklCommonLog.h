/*
 * Copyright (c) 2016. Nikon. All rights reserved.
 */

/**
 * @file NklCommonLog.h
 */

#import <Foundation/Foundation.h>

/**
 * @file NklCommonLog.h
 *
 * ログ出力レベル
 */
typedef NS_ENUM(int,  NklCommonLogOutputLevel) {
    NklCommonLogOutputLevelTrace,
    NklCommonLogOutputLevelDump,
    NklCommonLogOutputLevelDebug,
    NklCommonLogOutputLevelInfo,
    NklCommonLogOutputLevelError,
};

/**
 * @file NklCommonLog.h
 *
 * ログレベル
 */
typedef NS_ENUM(int, NklCommonLogLogLevel) {
    NklCommonLogLogLevelVerbose = 2,
    NklCommonLogLogLevelDebug = 3,
    NklCommonLogLogLevelInfo = 4,
    NklCommonLogLogLevelWarn = 5,
    NklCommonLogLogLevelError = 6,
    NklCommonLogLogLevelAssert = 7,
};

extern NSString *NklCommonLogLibName;
extern int NklCommonLogConfigLogLevel;

/**
 * ログ出力を行う為の共通処理クラス
 */
@interface NklCommonLog : NSObject

/**
 * トレースログの出力
 *
 * @param tag TAG
 * @param msg 出力メッセージ
 */
+ (void)trace:(NSString*)tag
      message:(NSString*)msg;

/**
 * ダンプログ
 *
 * @param tag  TAG
 * @param msg  メッセージ
 * @param data ダンプ出力するデータ
 */
+ (void)dump:(NSString*)tag
     message:(NSString*)msg
        data:(NSData*)data;

/**
 * デバッグログの出力
 *
 * @param tag TAG
 * @param msg 出力メッセージ
 */
+ (void)debug:(NSString*)tag
      message:(NSString*)msg;

/**
 * インフォメーションログの出力
 *
 * @param tag TAG
 * @param msg 出力メッセージ
 */
+ (void)info:(NSString*)tag
     message:(NSString*)msg;

/**
 * エラーログの出力
 *
 * @param tag TAG
 * @param msg 出力メッセージ
 */
+ (void)error:(NSString*)tag
      message:(NSString*)msg;

/**
 * バイト配列をダンプ文字列にする処理
 *
 * @param data 出力するbyte配列
 * @return ダンプ文字列
 */
+ (NSString*)buildDump:(NSData*)data;

/**
 * 文字列の構築
 *
 * @param level ログ出力レベル
 * @param msg   ログ出力メッセージ
 * @return ログ出力される文字列
 */
+ (NSString*)build:(NklCommonLogOutputLevel)level
           message:(NSString*)msg;

@end
