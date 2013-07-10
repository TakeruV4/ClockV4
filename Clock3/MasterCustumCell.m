//
//  MasterCustumCell.m
//  Clock3
//
//  Created by 村川 孟 on 2013/07/07.
//  Copyright (c) 2013年 村川 孟. All rights reserved.
//

#import "MasterCustumCell.h"

@implementation MasterCustumCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"MasterCustumCell" owner:self options:nil];
        UIView *viewOnContentView = [views objectAtIndex:0];
        
        viewOnContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.frame = viewOnContentView.bounds;
        
        [self.contentView addSubview:viewOnContentView];
    }
    return self;
}

@end
