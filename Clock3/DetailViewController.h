//
//  DetailViewController.h
//  Clock3
//
//  Created by 村川 孟 on 2013/06/22.
//  Copyright (c) 2013年 村川 孟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubTableView.h"
#import "AppDelegate.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>
{
    SubTableView *tableView;
}

@property NSInteger detailItem;
@property AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;



@end
