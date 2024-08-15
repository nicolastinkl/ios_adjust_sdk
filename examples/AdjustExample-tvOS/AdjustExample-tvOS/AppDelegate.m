//
//  AppDelegate.m
//  AdjustExample-tvOS
//
//  Created by Pedro Filipe (@nonelse) on 12th October 2015.
//  Copyright © 2015-Present Adjust GmbH. All rights reserved.
//

#import "Constants.h"
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Configure adjust SDK.
    NSString *yourAppToken = kAppToken;
    NSString *environment = ADJEnvironmentSandbox;
    ADJConfig *adjustConfig = [[ADJConfig alloc] initWithAppToken:yourAppToken
                                                      environment:environment];

    // Change the log level.
    [adjustConfig setLogLevel:ADJLogLevelVerbose];
    
    // Set default tracker.
    // [adjustConfig setDefaultTracker:@"{TrackerToken}"];
    
    // Send in the background.
    [adjustConfig enableSendingInBackground];

    // Add global callback parameters.
    [Adjust addGlobalCallbackParameter:@"sp_bar" forKey:@"sp_foo"];
    [Adjust addGlobalCallbackParameter:@"sp_value" forKey:@"sp_key"];

    // Add global partner parameters.
    [Adjust addGlobalPartnerParameter:@"sp_bar" forKey:@"sp_foo"];
    [Adjust addGlobalPartnerParameter:@"sp_value" forKey:@"sp_key"];

    // Remove global callback parameter.
    [Adjust removeGlobalCallbackParameterForKey:@"sp_key"];

    // Remove global partner parameter.
    [Adjust removeGlobalPartnerParameterForKey:@"sp_foo"];

    // Set an attribution delegate.
    [adjustConfig setDelegate:self];
    
    // Initialise the SDK.
    [Adjust initSdk:adjustConfig];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    NSLog(@"Scheme based deep link opened an app: %@", url);

    // Call the below method to send deep link to Adjust backend
    [Adjust processDeeplink:[[ADJDeeplink alloc] initWithDeeplink:url]];

    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> *restorableObjects))restorationHandler {
    if ([[userActivity activityType] isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        NSLog(@"continueUserActivity method called with URL: %@", [userActivity webpageURL]);
        [Adjust convertUniversalLink:[userActivity webpageURL] withScheme:@"adjustExample"];
        [Adjust processDeeplink:[[ADJDeeplink alloc] initWithDeeplink:[userActivity webpageURL]]];
    }
    
    return YES;
}

- (void)adjustAttributionChanged:(ADJAttribution *)attribution {
    NSLog(@"Attribution callback called!");
    NSLog(@"Attribution: %@", attribution);
}

- (void)adjustEventTrackingSucceeded:(ADJEventSuccess *)eventSuccessResponseData {
    NSLog(@"Event success callback called!");
    NSLog(@"Event success data: %@", eventSuccessResponseData);
}

- (void)adjustEventTrackingFailed:(ADJEventFailure *)eventFailureResponseData {
    NSLog(@"Event failure callback called!");
    NSLog(@"Event failure data: %@", eventFailureResponseData);
}

- (void)adjustSessionTrackingSucceeded:(ADJSessionSuccess *)sessionSuccessResponseData {
    NSLog(@"Session success callback called!");
    NSLog(@"Session success data: %@", sessionSuccessResponseData);
}

- (void)adjustSessionTrackingFailed:(ADJSessionFailure *)sessionFailureResponseData {
    NSLog(@"Session failure callback called!");
    NSLog(@"Session failure data: %@", sessionFailureResponseData);
}

// Evaluate deeplink to be launched.
- (BOOL)adjustDeferredDeeplinkReceived:(NSURL *)deeplink {
    NSLog(@"Deferred deep link callback called!");
    NSLog(@"Deferred deep link URL: %@", [deeplink absoluteString]);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
