//
//  CustumCell.h
//  Clock3
//
//  Created by 村川 孟 on 2013/06/23.
//  Copyright (c) 2013年 村川 孟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustumCell : UITableViewCell <NSCoding>{
    
}
@property (nonatomic) BOOL SubSwitch;
-(void)setTime:(NSDate*)date;

@end
