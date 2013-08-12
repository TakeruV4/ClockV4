//
//  SystemValueManager.h
//  Clock3
//
//  Created by 村川 孟 on 2013/08/12.
//  Copyright (c) 2013年 村川 孟. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSMutableDictionary SystemValueObject;


@interface SystemValueManager : NSObject {
	SystemValueObject *systemValueObject_;
}


//==========================================
// Properties
//==========================================
@property (nonatomic, retain) SystemValueObject *systemValueObject;



//==========================================
// Methods
//==========================================
// keyに対応したvalue文字列を返す
- (NSString *)valueForKey:(NSString *)key;

// keyに対応したバイナリデータを返す
- (NSData *)binaryValueForKey:(NSString *)key;

// keyに対応したvalue文字列を更新する
// 対応するkeyがない場合は新規作成される
- (void)setValue:(NSString *)value forKey:(NSString *)key;

// keyに対応したvalue文字列を更新する
// 対応するkeyがない場合は新規作成される
- (void)setBinaryValue:(NSData *)value forKey:(NSString *)key;

// keyに対応する設定値を削除する
- (void)deleteKey:(NSString *)key;


@end
