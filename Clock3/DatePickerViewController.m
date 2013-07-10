//
//  DatePickerViewController.m
//  Clock3
//
//  Created by 村川 孟 on 2013/06/29.
//  Copyright (c) 2013年 村川 孟. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)commitButtonClicked:(id)sender {
    [_delegate didCommitButtonClicked:self selectedDate:_datePicker.date];
}


- (IBAction)cancelButtonClicked:(id)sender {
    [_delegate didCancelButtonClicked:self];
}


@end
