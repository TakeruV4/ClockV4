//
//  SystemValueManager.m
//  Clock3
//
//  Created by 村川 孟 on 2013/08/12.
//  Copyright (c) 2013年 村川 孟. All rights reserved.
//

#import "SystemValueManager.h"


@implementation SystemValueManager

@synthesize systemValueObject = systemValueObject_;


- (id)init
{
	if (self = [super init]) {
		systemValueObject_ = [[SystemValueObject alloc] init];
	}
	return self;
}


/**
 * keyに対応したvalue文字列を返す
 */
- (NSString *)valueForKey:(NSString *)key
{
	return [[NSString alloc] initWithData:[self binaryValueForKey:key]
								  encoding:NSUTF8StringEncoding];
}


/**
 * keyに対応したバイナリデータを返す
 */
- (NSData*)binaryValueForKey:(NSString *)key
{
	return [self.systemValueObject valueForKey:key];
}


/**
 * keyに対応したvalue文字列を更新する
 * 対応するkeyがない場合は新規作成される
 */
- (void)setValue:(NSString *)value forKey:(NSString *)key
{
	[self.systemValueObject setValue:[value dataUsingEncoding:NSUTF8StringEncoding]
							  forKey:key];
}


/**
 * keyに対応したvalue文字列を更新する
 * 対応するkeyがない場合は新規作成される
 */
- (void)setBinaryValue:(NSData *)binaryValue forKey:(NSString *)key
{
	[self.systemValueObject setValue:binaryValue forKey:key];
}


/**
 * keyに対応する設定値を削除する
 */
- (void)deleteKey:(NSString *)key
{
	[self.systemValueObject removeObjectForKey:key];
}

/*
- (void)dealloc
{
	[systemValueObject_ release];
	
	[super dealloc];
}
*/

@end
