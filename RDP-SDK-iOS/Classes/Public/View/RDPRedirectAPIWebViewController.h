//
//  RDPRedirectAPIWeb.h
//  RDPSDK
//
//  Created by Ferico Samuel on 5/13/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedirectAPIInternalDelegate.h"
#import "RDPRedirectAPI.h"
#import "UIViewControllerExtension.h"
#import "ParameterExtractor.h"
#import "HttpPostRequest.h"
#define RDP_REDIRECT_API_QUERY_SERVICE_DEV_ENPOINT @"https://secure-dev.reddotpayment.com/service/Merchant_processor/query_redirection"
#define RDP_REDIRECT_API_QUERY_SERVICE_PRODUCTION_ENPOINT @"https://secure.reddotpayment.com/service/Merchant_processor/query_redirection"

@interface RDPRedirectAPIWebViewController : UIViewController<UIWebViewDelegate, RedirectAPIInternalDelegate, WsDelegate>

@property(nonatomic, strong) NSString* mid;
@property(nonatomic) enum RDPRedirectAPIPaymentType payment_type;
@property(nonatomic, strong) NSString* order_id;
@property(nonatomic, strong) NSString* ccy;
@property(nonatomic) float amount;
@property(nonatomic, strong) NSString* back_url;
@property(nonatomic, strong) NSString* redirect_url;
@property(nonatomic, strong) NSString* notify_url;
@property(nonatomic, strong) NSString* payer_email;
@property(nonatomic, strong) NSString* merchant_reference;
@property(nonatomic, strong) NSString* locale;
@property(nonatomic, strong) NSString* multiple_method_page;
@property(nonatomic, strong) NSString* bill_to_forename;
@property(nonatomic, strong) NSString* bill_to_surname;
@property(nonatomic, strong) NSString* bill_to_address_city;
@property(nonatomic, strong) NSString* bill_to_address_line1;
@property(nonatomic, strong) NSString* bill_to_address_line2;
@property(nonatomic, strong) NSString* bill_to_address_country;
@property(nonatomic, strong) NSString* bill_to_address_state;
@property(nonatomic, strong) NSString* bill_to_address_postal_code;
@property(nonatomic, strong) NSString* bill_to_phone;
@property(nonatomic, strong) NSString* ship_to_forename;
@property(nonatomic, strong) NSString* ship_to_surname;
@property(nonatomic, strong) NSString* ship_to_address_city;
@property(nonatomic, strong) NSString* ship_to_address_line1;
@property(nonatomic, strong) NSString* ship_to_address_line2;
@property(nonatomic, strong) NSString* ship_to_address_country;
@property(nonatomic, strong) NSString* ship_to_address_state;
@property(nonatomic, strong) NSString* ship_to_address_postal_code;
@property(nonatomic, strong) NSString* ship_to_phone;
@property(nonatomic, strong) NSString* secret_key;
@property(nonatomic) int tenor_month;

@property(nonatomic, strong) id<RedirectAPIDelegate> delegate;
@property(nonatomic, strong) RDPRedirectAPI* redirectAPIWrapper;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIBarButtonItem *btnNavDone;
@property(strong, nonatomic) NSString* payment_url;

@end
