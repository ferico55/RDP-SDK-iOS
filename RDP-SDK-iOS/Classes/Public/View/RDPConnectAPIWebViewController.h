//
//  RDPConnectAPIWebViewController.h
//  RDP SDK
//
//  Created by Ricky Putra Harlim on 5/2/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDPConnectAPI.h"
#import "SignatureUtil.h"
#import "UIViewControllerExtension.h"
#import "ParameterExtractor.h"
#import "OriginViewType.h"

@interface RDPConnectAPIWebViewController : UIViewController<UIWebViewDelegate, ConnectAPIInternalDelegate>

@property(nonatomic, strong) RDPConnectAPI* connectAPIWrapper;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIBarButtonItem *btnNavDone;
@property (strong, nonatomic) id<ConnectAPIDelegate> delegate;


@property enum OriginViewType origin_type;
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
