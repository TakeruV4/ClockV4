//
//  CustumCell.m
//  Clock3
//
//  Created by 村川 孟 on 2013/06/23.
//  Copyright (c) 2013年 村川 孟. All rights reserved.
//

#import "CustumCell.h"

@interface CustumCell(){
    UISwitch *cellSwitch;
    UILabel *cellLabel;

    
}

@end

@implementation CustumCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    cellSwitch = [[UISwitch alloc]init];
    self.accessoryView = cellSwitch;
    self.textLabel.text = @"テスト";
    

    
    return self;
}

-(void)setTime:(NSDate *)dates
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat  = @"HH:mm";
    self.textLabel.text = [df stringFromDate:dates];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state


}






@end
