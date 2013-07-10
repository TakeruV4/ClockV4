//
//  SubTableView.h
//  Clock3
//
//  Created by 村川 孟 on 2013/06/22.
//  Copyright (c) 2013年 村川 孟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatePickerViewController.h"
#import "AppDelegate.h"

@interface SubTableView :  UITableView<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    NSMutableArray *dataSouce;

}

@property (strong, nonatomic) NSDate *setTime;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property(nonatomic, strong) UITapGestureRecognizer *singleTap;//日付ピッカー外タップ検出用
@end
