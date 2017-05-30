//
//  RDPScanCardViewController.h
//  RDPSDK
//
//  Created by Ricky Putra Harlim on 5/11/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDPConnectAPI.h"
#import "RDPConnectAPIWebViewController.h"

@interface RDPScanCardViewController : UIViewController <RDPConnectAPIDelegate>
@property (strong, nonatomic) id<RDPConnectAPIDelegate> delegate;
@property NSString* secret_key;
@property NSString* order_number;
@property NSString* merchant_id;
@property NSString* key;
@property float amount;
@property NSString* currency_code;
@property NSString* email;
@property enum RDPConnectAPITransactionType transaction_type;
@property NSString* return_url;
@property NSString* card_number;
@property NSString* expiry_date;
@property NSString* cvv2;
@end
