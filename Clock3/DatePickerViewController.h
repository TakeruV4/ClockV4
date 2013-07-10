//
//  DatePickerViewController.h
//  Clock3
//
//  Created by 村川 孟 on 2013/06/29.
//  Copyright (c) 2013年 村川 孟. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DatePickerViewController;
@protocol DatePickerViewControllerDelegate
- (void)didCommitButtonClicked:(DatePickerViewController *)controller selectedDate:(NSDate *)selectedDate;
- (void)didCancelButtonClicked:(DatePickerViewController *)controller;
@end

@interface DatePickerViewController : UIViewController
@property (nonatomic, assign) id<DatePickerViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
