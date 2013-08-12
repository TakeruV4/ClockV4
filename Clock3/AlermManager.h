//
//  AlermManager.h
//  Clock3
//
//  Created by 村川 孟 on 2013/08/12.
//  Copyright (c) 2013年 村川 孟. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSMutableDictionary AlermObject;


@interface AlermManager : NSObject {
@private
	NSMutableArray *alermObjects_;	// アラーム作動設定の入ったアラーム設定情報配列
	NSArray *enabledAlermsObjects_;	// on になっているアラームのアラーム設定情報配列
	NSCalendar *calendar_;			// 日付変換に使うカレンダー
}

//==========================================
// Properties
//==========================================
@property (retain, nonatomic) NSMutableArray *alermObjects;
@property (retain, nonatomic, readonly) NSArray *enabledAlermsObjects;


//==========================================
// Methods
//==========================================
// アラームの設定を１つ追加する
- (void)insertAlermAwakedAt:(NSDate *)timeStamp
				withMessage:(NSString *)message
				   switchON:(BOOL)alermSwitch;

// 指定アラームオブジェクトの設定を変更する
- (void)updateAlermObject:(AlermObject *)alermObject
				 awakedAt:(NSDate *)timeStamp
			  withMessage:(NSString *)message
				 switchON:(BOOL)alermSwitch;

// 設定していたアラーム情報を取り除く
- (void)deleteAlermObject:(AlermObject *)alermObject;

// アラームの設定を同期する
- (void)syncronize;

// 指定時刻とマッチしたアラーム用のアラーム設定情報を返す
// マッチするアラーム設定がない場合、nilを返す
- (AlermObject *)alermObjectTimeMatched:(NSDate *)timeStamp;

// 引数の日付情報を 2001年1月1日 に変更し、さらに秒を 0 に変更した NSDate を返す
- (NSDate *)alermDateWithDate:(NSDate *)timeStamp;

@end
