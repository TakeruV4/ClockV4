//
//  SubTableView.m
//  Clock3
//
//  Created by 村川 孟 on 2013/06/22.
//  Copyright (c) 2013年 村川 孟. All rights reserved.
//

#import "SubTableView.h"
#import "CustumCell.h"

@interface SubTableView(){
    BOOL isDispDatePicker;
    DatePickerViewController* datePickerViewController;
}
@end


@implementation SubTableView



- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self=[super initWithFrame:frame style:style];
    self.delegate=self;
    //テーブルビューデリケードセット
    self.dataSource=self;
    //データーソースデリケードセット
    if (!dataSouce) {
        dataSouce =[[NSMutableArray alloc]initWithObjects: @"新規追加", nil ];
    }    
    //DatePickerのセット
    isDispDatePicker = NO;    
    

    
    return self;
}

//セクション数 ※必須
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
} //セル数 ※必須
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSouce.count;
}
//セクションヘッダータイトル
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *str=@"Header Title";
    return str;
}
//セクションフッダータイトル
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString *str=@"Footer Title";
    return str;
}
//セル表示
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    /*
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
     */
    
    CustumCell *cell = [self dequeueReusableCellWithIdentifier:@"CustumCell"];
    if (cell == nil)
    {
        cell = [[CustumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustumCell"];
    }

    //UISwitch *masterSwitch = [[UISwitch alloc]init];
    //cell.accessoryView = masterSwitch;
    //cell.accessoryView = masterSwitch;
    //cell.textLabel.text =[dataSouce objectAtIndex:indexPath.row];
    //cell.accessoryType =UITableViewCellAccessoryNone; //セルアクセサリ設定
    //cell.selectionStyle =UITableViewCellSelectionStyleNone;
    //セル選択時のカラー設定
    return cell;
}
//セル選択
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"セル選択");
    self.selectedIndexPath = indexPath;

    UIStoryboard *myStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    datePickerViewController = [myStoryBoard instantiateViewControllerWithIdentifier:@"ID_DatePickerViewController"];
    datePickerViewController.delegate = self;
    
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    self.singleTap.delegate = self;
    self.singleTap.numberOfTapsRequired = 1;
    
    for(UIView *view in datePickerViewController.view.subviews){
        NSString* className = NSStringFromClass([view class]);
        NSLog(@"%@",className);
        if([className isEqualToString:@"UIView"]){
               [view addGestureRecognizer:self.singleTap];
        }
    }
    [self showModal:datePickerViewController.view];
    isDispDatePicker = YES;
    

}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(UITableViewCellEditingStyleDelete == editingStyle) {
        [dataSouce removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }else if(UITableViewCellEditingStyleInsert == editingStyle)
    {
        [dataSouce insertObject:[NSString stringWithFormat:@"%d",indexPath.row+1] atIndex:indexPath.row];
        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}
 

//編集スタイル
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editing == NO ) return UITableViewCellEditingStyleNone;
    if (indexPath.row >= ([dataSouce count]-1))
    {
        return UITableViewCellEditingStyleInsert;
    }
    else
    {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

-(void)setCellForTime
{
    NSLog(@"setCellForTime");
    CustumCell *setCell = [[CustumCell alloc]init];
    setCell = [self cellForRowAtIndexPath:self.selectedIndexPath];
    [setCell setTime:self.setTime];
}

#pragma mark - Date picker

-(void)onSingleTap:(UITapGestureRecognizer *)recognizer {
    NSLog(@"tap");
    [self hideModal:datePickerViewController.view];
    datePickerViewController.delegate = nil;
}

- (void) showModal:(UIView *) modalView
{
    UIWindow *mainWindow = (((AppDelegate *) [UIApplication sharedApplication].delegate).window);
    CGPoint middleCenter = modalView.center;
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width * 0.5f, offSize.height * 1.5f);
    modalView.center = offScreenCenter;
    
    [mainWindow addSubview:modalView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    modalView.center = middleCenter;

    [UIView commitAnimations];
}

- (void) hideModal:(UIView*) modalView
{
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width * 0.5f, offSize.height * 1.5f);
    [UIView beginAnimations:nil context:(__bridge_retained void *)(modalView)];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(hideModalEnded:finished:context:)];
    modalView.center = offScreenCenter;
    [UIView commitAnimations];
}

- (void) hideModalEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    UIView *modalView = (__bridge_transfer UIView *)context;
    [modalView removeFromSuperview];
}

-(void)didCommitButtonClicked:(DatePickerViewController *)controller selectedDate:(NSDate *)selectedDate
{
    [self hideModal:controller.view];
    controller.delegate = nil;
    NSLog(@"selected Date:%@",selectedDate);
    self.setTime = selectedDate;
    //self.setTime = controller.datePicker.date;
    [self setCellForTime];

}

-(void)didCancelButtonClicked:(DatePickerViewController *)controller
{
    [self hideModal:controller.view];
    controller.delegate = nil;
}

@end
