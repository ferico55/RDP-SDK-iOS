//
//  RDPScanCardViewController.m
//  RDPSDK
//
//  Created by Ricky Putra Harlim on 5/11/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import "RDPScanCardViewController.h"
#import <CardIO.h>
#import "UIViewControllerExtension.h"

@interface RDPScanCardViewController ()<CardIOPaymentViewControllerDelegate>

@end

@implementation RDPScanCardViewController

@synthesize order_number,amount,secret_key,currency_code,merchant_id,key,email,transaction_type,return_url,cvv2,card_number,expiry_date,delegate;



- (void)viewDidLoad {
    [super viewDidLoad];
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    scanViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [UIViewControllerExtension showViewControllerPresentWithDispatch:self withviewController:scanViewController];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/// This method will be called if the user cancels the scan. You MUST dismiss paymentViewController.
/// @param paymentViewController The active CardIOPaymentViewController.
- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)paymentViewController{
    NSLog(@"User cancelled scan");
    [UIViewControllerExtension dismissPopUpUsingDispatch:self completion:^{
        [UIViewControllerExtension dismissPopUpUsingDispatch:self completion:nil];
    }];
}

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)cardInfo inPaymentViewController:(CardIOPaymentViewController *)paymentViewController{
    NSLog(@"Scan succeeded with info: %@", cardInfo);
    [UIViewControllerExtension dismissPopUpUsingDispatch:self completion:nil];
    RDPConnectAPIWebViewController *vc = [RDPConnectAPIWebViewController alloc];
    vc.delegate = delegate;
    vc.order_number = order_number;
    vc.amount = amount;
    vc.currency_code = currency_code;
    vc.merchant_id = merchant_id;
    vc.key =key;
    vc.email = email;
    vc.transaction_type = transaction_type;
    vc.secret_key = secret_key;
    vc.return_url = return_url;
    vc.origin_type = RDPScanCard;
    NSString *year = [[NSString stringWithFormat:@"%-4lu",(unsigned long)cardInfo.expiryYear] substringFromIndex:2];
    vc.expiry_date = [NSString stringWithFormat:@"%02lu%@",(unsigned long)cardInfo.expiryMonth, year];
    vc.cvv2 = cardInfo.cvv;
    vc.card_number = cardInfo.cardNumber;
    [UIViewControllerExtension showViewControllerPresentWithDispatch:self withviewController:vc];
    
}

@end
