//
//  WCAppDelegate.h
//  wecheck
//
//  Created by Wai Lok Tsang on 6/20/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCDataAccessSvc.h"
//removing core data
//#import "WCCoreDataHelper.h"

@interface WCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong, readonly) WCDataAccessSvc *dataAccessSvc;
//removing core data
//@property (nonatomic, strong, readonly) WCCoreDataHelper *coreDataHelper;

@end
