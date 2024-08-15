//
//  AppDelegate.h
//  AdjustExample-tvOS
//
//  Created by Pedro Filipe (@nonelse) on 12th October 2015.
//  Copyright © 2015-Present Adjust GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AdjustSdk/AdjustSdk.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, AdjustDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

