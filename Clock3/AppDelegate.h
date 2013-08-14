//
//  AppDelegate.h
//  Clock3
//
//  Created by 村川 孟 on 2013/06/22.
//  Copyright (c) 2013年 村川 孟. All rights reserved.
//

#import <UIKit/UIKit.h>


//@class AlermManager;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    //@private AlermManager *alermManager;
}


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *subTables;
@property (strong, nonatomic) NSMutableArray *masterTables;

//@property (nonatomic, retain) AlermManager *alermManager;

@end
