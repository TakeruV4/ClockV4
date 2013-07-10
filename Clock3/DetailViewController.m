//
//  DetailViewController.m
//  Clock3
//
//  Created by 村川 孟 on 2013/06/22.
//  Copyright (c) 2013年 村川 孟. All rights reserved.
//

#import "DetailViewController.h"


@interface DetailViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item
/*
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}*/
- (void)setDetailItem:(NSInteger)newDetailItem
{
    NSLog(@"setDetailItem");
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        NSLog(@"currentRow : %d",_detailItem);
                
        // Update the view.
        [self configureView];
    }
    
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}




- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        //self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.


    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //カスタムセルのセット
    //[tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"CustumCell"];
    
    NSLog(@"table count : %d",self.appDelegate.subTables.count);
    NSLog(@"detail Item %d",_detailItem);
    
    //if(self.appDelegate.subTables.count <= _detailItem || self.appDelegate.subTables.count ==0 ){
    if([self.appDelegate.subTables objectAtIndex:_detailItem] == [NSNull null]){
        NSLog(@"テーブル作成");
        tableView =[[SubTableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        tableView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;//オートリサイズ
        [self.appDelegate.subTables replaceObjectAtIndex:_detailItem withObject:tableView];
    NSLog(@"table count : %d",self.appDelegate.subTables.count);
        [self.view addSubview:tableView];
    }else{
        NSLog(@"テーブル作成しない");
        [self setEditing:NO animated:YES];
        [self.view addSubview:[self.appDelegate.subTables objectAtIndex:_detailItem]];
    }

    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    SubTableView *currentTableView = [[SubTableView alloc]init];
    currentTableView = [self.appDelegate.subTables objectAtIndex:_detailItem];
    [currentTableView setEditing:editing animated:YES];
    if (editing) { // 現在編集モードです。
        //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd                                                                        target:self action:@selector(addRow:)];
        //[self.navigationItem setLeftBarButtonItem:addButton animated:YES]; // 追加ボタンを表示します。
    } else { // 現在通常モードです。
        //[self.navigationItem setLeftBarButtonItem:nil animated:YES]; // 追加ボタンを非表示にします。
    }
}



#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}





@end
