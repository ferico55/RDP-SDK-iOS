//
//  RDPConnectAPI.h
//  RDPSDK
//
//  Created by Ricky Putra Harlim on 5/8/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "RDPConnectAPITransactionType.h"
#import "QueryStringBuilder.h"
#import "HttpPostRequest.h"
#import "Util.h"
#import "StringResponse.h"
#import "ConnectAPIInternalDelegate.h"
#define RDP_CAPI_DEV_URL @"http://test.reddotpayment.com/connect-api/cgi-bin-live"
#define RDP_CAPI_PRODUCTION_URL @"https://connect.reddotpayment.com/merchant/cgi-bin-live"

@protocol ConnectAPIDelegate <NSObject>

- (void) onRequestFailedWithErrorCode:(int) errorCode andDescription:(NSString*) description;
- (void) onRequestRejectedWithParams:(NSDictionary*) params andErrorCode:(int) errorCode;
- (void) onRequestFinishedWithParams:(NSDictionary*) params;

@optional
- (void) paymentInterfaceWillRequest;
- (void) paymentInterfaceDidRequest;
- (void) returnUrlWillLoad;
- (void) returnUrlDidLoad;
- (void) transactionSignatureWillValidate;
- (void) transactionSignatureDidValidateWithParam: (NSDictionary*) params;
- (BOOL) shouldDismissConsentScreen;
- (void) consentScreenDidDissapear;
@end

@interface RDPConnectAPI : NSObject<WsDelegate>

@property(nonatomic, strong) NSString* secret_key;
@property(nonatomic, strong) NSString* order_number;
@property(nonatomic, strong) NSString* merchant_id;
@property(nonatomic, strong) NSString* key;
@property(nonatomic) float amount;
@property(nonatomic, strong) NSString* currency_code;
@property(nonatomic, strong) NSString* email;
@property(nonatomic) enum RDPConnectAPITransactionType transaction_type;
@property(nonatomic, strong) NSString* return_url;
@property(nonatomic, strong) NSString* merchant_reference;
@property(nonatomic, strong) NSString* notify_url;
@property(nonatomic, strong) NSString* promo_code;
@property(nonatomic, strong) NSString* first_name;
@property(nonatomic, strong) NSString* last_name;
@property(nonatomic, strong) NSString* address_line1;
@property(nonatomic, strong) NSString* address_line2;
@property(nonatomic, strong) NSString* address_city;
@property(nonatomic, strong) NSString* address_postal_code;
@property(nonatomic, strong) NSString* address_state;
@property(nonatomic, strong) NSString* address_country;
@property(nonatomic, strong) NSString* merchant_data1;
@property(nonatomic, strong) NSString* merchant_data2;
@property(nonatomic, strong) NSString* merchant_data3;
@property(nonatomic, strong) NSString* merchant_data4;
@property(nonatomic, strong) NSString* merchant_data5;
@property(nonatomic, strong) NSString* card_number;
@property(nonatomic, strong) NSString* expiry_date;
@property(nonatomic, strong) NSString* cvv2;
@property(nonatomic, strong) NSString* token_id;
@property(nonatomic, strong) NSString* order_timeout;
@property(nonatomic, strong) id<ConnectAPIDelegate> delegate;
@property(nonatomic, strong) id<ConnectAPIInternalDelegate> internalDelegate;

- (id) initWithDelegate:(id<ConnectAPIDelegate>) delegate;
- (void) startRequest;
- (void) checkAmountValidation;
//TODO buang method" dibawah ini
- (void) onErrorWith:(NSString *)error;
- (void) signatureWillValidate;
- (void) signatureDidValidateWithParam: (NSDictionary*) params;
- (void) consentScreenDidDissapear;
- (void) onRequestRejectedWithParams:(NSDictionary*) params andErrorCode:(int) errorCode;
- (void) onRequestFinishedWithParams:(NSDictionary*) params;
- (BOOL) shouldDismissConsentScreen;


@end
