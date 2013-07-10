//
//  UINavigationController+Portrait.m
//  Clock3
//
//  Created by 村川 孟 on 2013/06/30.
//  Copyright (c) 2013年 村川 孟. All rights reserved.
//

#import "UINavigationController+Portrait.h"

@implementation UINavigationController (Portrait)

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

@end
