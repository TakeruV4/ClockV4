//
//  MasterViewController.m
//  Clock3
//
//  Created by 村川 孟 on 2013/06/22.
//  Copyright (c) 2013年 村川 孟. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "MasterCustumCell.h"
#import "CustumCell.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
    BOOL editLabel;
    UITextField *selectedTextField;
    DetailViewController *detailViewController;
}
@end

@implementation MasterViewController

#define MAX_LENGTH 8


- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    

    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
       NSLog(@"crateDetailViewControler");
    
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    self.singleTap.delegate = self;
    self.singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singleTap];
    
    NSLog(@"データロード");
	// アラームを管理するマネージャを作成
	//alermManager = [[AlermManager alloc] init];
    
	// 前回の状態を復元
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *Mdata = [defaults objectForKey:@"M_ARRAY"];
    NSData *Sdata = [defaults objectForKey:@"S_ARRAY"];
    
    if(Mdata){
        self.appDelegate.masterTables = [NSKeyedUnarchiver unarchiveObjectWithData:Mdata];
        NSDate *dt = [[NSDate alloc]init];
        dt = [self.appDelegate.masterTables objectAtIndex:1];
        NSLog(@"復元１のラベル %@",dt);
    }
    
    if(Sdata){
        self.appDelegate.subTables = [NSKeyedUnarchiver unarchiveObjectWithData:Sdata];
    }
    [defaults synchronize];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    //データ保存用
    if (!self.appDelegate.masterTables) {
        NSLog(@"オブジェクト作成");
        self.appDelegate.masterTables = [[NSMutableArray alloc] init];
    }else{
        NSLog(@"オブジェクト作成しない");
    }
    [self.appDelegate.masterTables insertObject:[NSDate date] atIndex:0];
    /*
    if (!_objects) {
        NSLog(@"オブジェクト作成");
        _objects = [[NSMutableArray alloc] init];
    }else{
        NSLog(@"オブジェクト作成しない");
    }
    [_objects insertObject:[NSDate date] atIndex:0];
     */
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    //サブテーブル作成時にnullを追加
    NSLog(@"null 追加");
    NSLog(@"masterTables %d",self.appDelegate.masterTables.count);
    [self.appDelegate.subTables insertObject:[NSNull null] atIndex:indexPath.row];
    NSLog(@"master  subTables %d",self.appDelegate.subTables.count);
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return _objects.count;
    return self.appDelegate.masterTables.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    CustumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2"];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //NSDate *object = _objects[indexPath.row];
    
    UISwitch *masterSwitch = [[UISwitch alloc]init];
    cell.accessoryView = masterSwitch;

    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, 50, 30)];
    textField.text = @"nil";
    textField.font = [UIFont fontWithName:@"Helvetica" size:24];

    [cell.contentView addSubview:textField];

    //TableViewCellからUITextFieldViewを取得
    for (UIView* view in cell.contentView.subviews) {
        NSString *cl = view.class;
        NSLog(@"class name: %@",cl);
        if ([view isKindOfClass:NSClassFromString(@"UITextField")]) {
            UITextField *tf = (UITextField*)view;
            tf.delegate = self;//delegateをセット
        }
    }
    */
    
    MasterCustumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasterCustumCell"];
    for (UIView* view in cell.contentView.subviews) {
        NSString *cl = view.class;
        NSLog(@"class name: %@",cl);
        if ([view isKindOfClass:NSClassFromString(@"UITextField")]) {
            UITextField *tf = (UITextField*)view;
            tf.delegate = self;//delegateをセット
        }
    }
    /*
    NSString *reuseIdentifier = @"CellID";
    
    MasterCustumCell *cell = (MasterCustumCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[MasterCustumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }*/
    /*
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [cell addGestureRecognizer:longPress];
    */
    return cell;
}

#pragma mark - text field

//テキストフィールドを編集する直前に呼ばれる
-(BOOL)textFieldShouldBeginEditing:(UITextField*)textField{
    selectedTextField = textField;
    
    return YES;
}

-(void)onSingleTap:(UITapGestureRecognizer *)recognizer {
    [selectedTextField resignFirstResponder];
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == self.singleTap) {
        // キーボード表示中のみ有効
        if (selectedTextField.isFirstResponder) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    // すでに入力されているテキストを取得
    NSMutableString *text = [textField.text mutableCopy];
    
    // すでに入力されているテキストに今回編集されたテキストをマージ
    [text replaceCharactersInRange:range withString:string];
    
    // 結果が文字数をオーバーしていないならYES，オーバーしている場合はNO
    return ([text length] <= MAX_LENGTH);
}

//キーボードのリターンキーが押されたときに、キーボードを閉じる
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //データ保存用
        [self.appDelegate.masterTables removeObjectAtIndex:indexPath.row];
        //[_objects removeObjectAtIndex:indexPath.row];
        NSLog(@"master  subTables %d",self.appDelegate.subTables.count);
        if(self.appDelegate.subTables.count >= indexPath.row){
            NSLog(@"delete");
            [self.appDelegate.subTables removeObjectAtIndex:indexPath.row];
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {

        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

-(IBAction)longPressAction:(UILongPressGestureRecognizer *)gestureRecognizer{
    if(self.editing){
        NSLog(@"long press on table view");
        UITextField *textView = [[UITextField alloc]initWithFrame:CGRectZero];
        [textView becomeFirstResponder];
        
        
    }else{
        NSLog(@"not long press on table view");

    }
    
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:detailViewController animated:YES];
    /*
    if(!self.editing){
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            NSDate *object = _objects[indexPath.row];
            self.detailViewController.detailItem = object;
        }
    }else{
        //セルがタップされたときに編集モード中であるなら、ラベルの変更
        NSLog(@"ラベル変更");
    }
     */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"遷移");
    if(!self.editing){
        NSLog(@"1");
        if ([[segue identifier] isEqualToString:@"showDetail"]) {
            NSLog(@"2");
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            NSLog(@"indexpath.row : %d",indexPath.row);
            //データ保存用
            NSDate *object = self.appDelegate.masterTables[indexPath.row];
            //NSDate *object = _objects[indexPath.row];
            //[[segue destinationViewController] setDetailItem:object];
            [[segue destinationViewController] setDetailItem:indexPath.row];
        }
    }else{
        NSLog(@"else");
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
    if(self.editing){
        NSLog(@"編集モード");
        
    }else{
        NSLog(@"非編集モード");
    }
}
/*
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return ![self.tableView isEditing];
}
*/

@end
