//
//  RDPViewController.m
//  RDP-SDK-iOS
//
//  Created by ferico55 on 05/28/2017.
//  Copyright (c) 2017 ferico55. All rights reserved.
//

#import "RDPViewController.h"
#import <RDPConnectAPI.h>
#import <RDPScanCardViewController.h>

@interface RDPViewController ()

@end

@implementation RDPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    RDPScanCardViewController *vc = [RDPScanCardViewController alloc];
    vc.delegate = self;
    vc.order_number = @"123";
    vc.amount = 100;
    vc.currency_code = @"THB";
    vc.merchant_id = @"1002089803";
    vc.key = @"13f0eaf0218c2886a564991dc0791563a8120757";
    vc.email = @"fer@fer.com";
    vc.transaction_type = sale;
    vc.secret_key = @"REDDOT";
    vc.return_url = @"http://93.188.167.250/";
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:vc animated:true completion:nil];

}

/**
 Method that called when request transaction is failed
 @param errorCode HTTP Response Code
 @param description Description Of Error
 */
- (void) onRequestFailedWithErrorCode:(int) errorCode andDescription:(NSString*) description {

}
/**
 Method that called when request rejected
 @param params the dictionary or response that return from server
 @param errorCode Error Code Value from HTTP Response Code
 */
- (void) onRequestRejectedWithParams:(NSDictionary*) params andErrorCode:(int) errorCode {

}
/**
 Method that called when request transaction is Finished or Success
 @param params the dictionary or response that return from server
 */
- (void) onRequestFinishedWithParams:(NSDictionary*) params {

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
