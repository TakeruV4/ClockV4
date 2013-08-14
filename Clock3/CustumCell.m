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
    NSString *cellString;
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
    [cellSwitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    self.textLabel.text = @"テスト";
    

    
    return self;
}

- (void)changeSwitch:(id)sender{
    UISwitch *sw = sender;
    self.SubSwitch = sw.on;
}

-(void)setTime:(NSDate *)dates
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat  = @"HH:mm";
    self.textLabel.text = [df stringFromDate:dates];
    cellString = self.textLabel.text;
}

/*
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state


}*/

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:cellSwitch forKey:@"cellSwitch"];
    [aCoder encodeObject:cellString forKey:@"cellString"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        cellSwitch = [aDecoder decodeObjectForKey:@"cellSwitch"];
        self.textLabel.text =[aDecoder decodeObjectForKey:@"cellString"];
        
    }
    return self;
}




@end
