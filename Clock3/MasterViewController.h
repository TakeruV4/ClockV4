//
//  MasterViewController.h
//  Clock3
//
//  Created by 村川 孟 on 2013/06/22.
//  Copyright (c) 2013年 村川 孟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController<UITextFieldDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) DetailViewController *detailViewController;
@property AppDelegate *appDelegate;
@property (strong, nonatomic) IBOutlet UITextField *tf;
@property(nonatomic, strong) UITapGestureRecognizer *singleTap;//キーボード外タップ検出用


@end
