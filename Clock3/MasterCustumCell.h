//
//  MasterCustumCell.h
//  Clock3
//
//  Created by 村川 孟 on 2013/07/07.
//  Copyright (c) 2013年 村川 孟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterCustumCell : UITableViewCell<NSCoding>{
    UITextField *cellText;
    NSString *str;
}
@property (nonatomic) BOOL MasterSwitch;
@property (nonatomic) NSString* str;


@end
