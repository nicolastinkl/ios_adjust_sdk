//
//  ViewControllerObjC.m
//  AdjustExample-ObjC
//
//  Created by Pedro Filipe (@nonelse) on 12th October 2015.
//  Copyright © 2015-Present Adjust GmbH. All rights reserved.
//

#import <AdjustSdk/AdjustSdk.h>
#import "Constants.h"
#import "ViewControllerObjC.h"

@interface ViewControllerObjC ()

@property (weak, nonatomic) IBOutlet UIButton *btnTrackSimpleEvent;
@property (weak, nonatomic) IBOutlet UIButton *btnTrackRevenueEvent;
@property (weak, nonatomic) IBOutlet UIButton *btnTrackCallbackEvent;
@property (weak, nonatomic) IBOutlet UIButton *btnTrackPartnerEvent;
@property (weak, nonatomic) IBOutlet UIButton *btnEnableOfflineMode;
@property (weak, nonatomic) IBOutlet UIButton *btnDisableOfflineMode;
@property (weak, nonatomic) IBOutlet UIButton *btnEnableSdk;
@property (weak, nonatomic) IBOutlet UIButton *btnDisableSdk;
@property (weak, nonatomic) IBOutlet UIButton *btnIsSdkEnabled;

@end

@implementation ViewControllerObjC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)clickTrackSimpleEvent:(UIButton *)sender {
    ADJEvent *event = [[ADJEvent alloc] initWithEventToken:kEventToken1];
    [Adjust trackEvent:event];
}

- (IBAction)clickTrackRevenueEvent:(UIButton *)sender {
    ADJEvent *event = [[ADJEvent alloc] initWithEventToken:kEventToken2];

    // Add revenue 1 cent of an EURO.
    [event setRevenue:0.01 currency:@"EUR"];

    [Adjust trackEvent:event];
}

- (IBAction)clickTrackCallbackEvent:(UIButton *)sender {
    ADJEvent *event = [[ADJEvent alloc] initWithEventToken:kEventToken3];

    // Add callback parameters to this event.
    [event addCallbackParameter:@"foo" value:@"bar"];
    [event addCallbackParameter:@"key" value:@"value"];

    [Adjust trackEvent:event];
}

- (IBAction)clickTrackPartnerEvent:(UIButton *)sender {
    ADJEvent *event = [[ADJEvent alloc] initWithEventToken:kEventToken4];

    // Add partner parameteres to this event.
    [event addPartnerParameter:@"foo" value:@"bar"];
    [event addPartnerParameter:@"key" value:@"value"];

    [Adjust trackEvent:event];
}

- (IBAction)clickEnableOfflineMode:(id)sender {
    [Adjust switchToOfflineMode];
}

- (IBAction)clickDisableOfflineMode:(id)sender {
    [Adjust switchBackToOnlineMode];
}

- (IBAction)clickEnableSdk:(id)sender {
    [Adjust enable];
}

- (IBAction)clickDisableSdk:(id)sender {
    [Adjust disable];
}

- (IBAction)clickIsSdkEnabled:(id)sender {
    [Adjust isEnabledWithCompletionHandler:^(BOOL isEnabled) {
        NSString *message;
        if (isEnabled) {
            message = @"SDK is ENABLED!";
        } else {
            message = @"SDK is DISABLED!";
        }

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Is SDK Enabled?"
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

@end
