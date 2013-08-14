//
//  MasterCustumCell.m
//  Clock3
//
//  Created by 村川 孟 on 2013/07/07.
//  Copyright (c) 2013年 村川 孟. All rights reserved.
//

#import "MasterCustumCell.h"

@interface MasterCustumCell(){
    UISwitch *cellSwitch;
    //UITextField *cellText;
}

@end

@implementation MasterCustumCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    cellSwitch = [[UISwitch alloc]init];
    self.accessoryView = cellSwitch;
    [cellSwitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    //self.textLabel.text = @"テスト";
    cellText = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, 50, 30)];
    cellText.text = @"nil";
    self.str = cellText.text;
    cellText.font = [UIFont fontWithName:@"Helvetica" size:24];
    [self.contentView addSubview:cellText];
    
    
    return self;
}

- (void)changeSwitch:(id)sender{
    UISwitch *sw = sender;
    self.MasterSwitch = sw.on;
}

/*
 - (void)setSelected:(BOOL)selected animated:(BOOL)animated
 {
 //[super setSelected:selected animated:animated];
 
 // Configure the view for the selected state
 
 
 }*/

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:cellSwitch forKey:@"cellSwitch"];
    [aCoder encodeObject:cellText forKey:@"cellText"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        cellSwitch = [aDecoder decodeObjectForKey:@"cellSwitch"];
        cellText = [aDecoder decodeObjectForKey:@"cellText"];
    }
    return self;
}

@end
