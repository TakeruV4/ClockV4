//
//  AlermManager.m
//  Clock3
//
//  Created by 村川 孟 on 2013/08/12.
//  Copyright (c) 2013年 村川 孟. All rights reserved.
//

#import "AlermManager.h"


@implementation AlermManager

@synthesize alermObjects = alermObjects_;
@synthesize enabledAlermsObjects = enabledAlermsObjects_;


- (id)init
{
	if (self = [super init]) {
		alermObjects_ = [[NSMutableArray alloc] init];
		enabledAlermsObjects_ = [[NSArray alloc] init];
	}
	return self;
}


/**
 * アラームの設定を１つ追加する
 */
- (void)insertAlermAwakedAt:(NSDate *)timeStamp
				withMessage:(NSString *)message
				   switchON:(BOOL)alermSwitch
{
	// timeStamp をアラーム用の NSDate に変換
	NSDate *time = [self alermDateWithDate:timeStamp];
	
	AlermObject *newObject;
	newObject = [AlermObject dictionaryWithObjectsAndKeys:
				 [NSNumber numberWithBool:alermSwitch], @"on"
				 , time, @"timeStamp"
				 , message, @"message"
				 , nil];
    
	[self.alermObjects addObject:newObject];
	[self syncronize];
}


/**
 * 指定アラームオブジェクトの設定を変更する
 */
- (void)updateAlermObject:(AlermObject *)alermObject
				 awakedAt:(NSDate *)timeStamp
			  withMessage:(NSString *)message
				 switchON:(BOOL)alermSwitch
{
	// timeStamp をアラーム用の NSDate に変換
	NSDate *time = [self alermDateWithDate:timeStamp];
	
	[alermObject setValue:[NSNumber numberWithBool:alermSwitch] forKey:@"on"];
	[alermObject setValue:time forKey:@"timeStamp"];
	[alermObject setValue:message forKey:@"message"];
    
	[self syncronize];
}


/**
 * 設定していたアラーム情報を取り除く
 */
- (void)deleteAlermObject:(AlermObject *)alermObject
{
	// 値を取り除く
	[self.alermObjects removeObjectsInArray:[NSArray arrayWithObject:alermObject]];
    
	[self syncronize];
}


/**
 * enabledAlermsManagedObjectsを同期する
 */
- (void)syncronize
{
	NSMutableArray *alermObjects = self.alermObjects;
	NSMutableArray *enabledAlermObjects = [[NSMutableArray alloc] init];
    
	// アラームスイッチが on のモノを抽出する
	for (AlermObject *obj in alermObjects) {
		if ([(NSNumber*)[obj valueForKey:@"on"] boolValue]) {
			[enabledAlermObjects addObject:obj];
		}
	}
	
	// enabledAlermsManagedObjectsを更新
	//[enabledAlermsObjects_ release];
	enabledAlermsObjects_ = [NSArray arrayWithArray:enabledAlermObjects];
	//[enabledAlermsObjects_ retain];
}


/**
 * 指定時刻とマッチしたアラーム用のmanagedObjectを返す
 * マッチするアラーム設定がない場合、nilを返す
 */
- (AlermObject *)alermObjectTimeMatched:(NSDate *)timeStamp
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
    
	// アラーム時刻比較の為、現在時刻から日時情報をアラーム用日時に変更する
	NSDateComponents *comp = [calendar components:(NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit)
										 fromDate:timeStamp];
	[comp setYear:2001];
	[comp setMonth:1];
	[comp setDay:1];
	
	NSDate *now = [calendar dateFromComponents:comp];
	
	// アラーム時刻と比較し、一致するものを取得
	for (AlermObject *alerm in self.enabledAlermsObjects) {
		if ([(NSDate*)[alerm valueForKey:@"timeStamp"] compare:now] == NSOrderedSame) {
			return alerm;
		}
	}
	return nil;
}


/**
 * 引数の日付情報を 2001年1月1日 に変更し、さらに秒を 0 に変更した NSDate を返す
 * アラームでは日付は考慮しないため、日付部分を統一することで後で計算がしやすくなります。
 */
- (NSDate *)alermDateWithDate:(NSDate *)timeStamp
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *comp = [calendar components:(NSHourCalendarUnit|NSMinuteCalendarUnit)
										 fromDate:timeStamp];
	[comp setYear:2001];
	[comp setMonth:1];
	[comp setDay:1];
	[comp setSecond:0];
	
	return [calendar dateFromComponents:comp];
}
@end
