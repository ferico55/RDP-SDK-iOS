//
//  RDPDirectAPI.h
//  RDPSDK
//
//  Created by Ricky Putra Harlim on 5/17/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "HttpPostRequest.h"
#import "RDPDirectAPIPaymentType.h"
#import "QueryStringBuilder.h"
#import "SignatureUtil.h"
#import "RDPDirectAPIResponse.h"
#import "Util.h"
#define RDP_DAPI_API_MODE @"direct_n3d"
#define RDP_DAPI_DEV_URL @"https://secure-dev.reddotpayment.com/service/payment-api"
#define RDP_DAPI_PRODUCTION_URL @"https://secure.reddotpayment.com/service/payment-api"

@protocol DirectAPIDelegate <NSObject>

- (void) onRequestFailedWithErrorCode:(int) errorCode andDescription:(NSString*) description;
- (void) onRequestFinishedWithResponseObject:(RDPDirectAPIResponse*) response;

@optional
- (void) paymentInterfaceWillRequest;
- (void) paymentInterfaceDidRequest;
- (void) transactionSignatureWillValidate;
- (void) transactionSignatureDidValidateWithParam: (NSDictionary*) params;
@end

@interface RDPDirectAPI : NSObject

@property(nonatomic, strong) NSString* mid;
@property(nonatomic, strong) NSString* order_id;
@property(nonatomic, strong) NSString* ccy;
@property(nonatomic) enum RDPDirectAPIPaymentType payment_type;
@property(nonatomic) float amount;
@property(nonatomic, strong) NSString* payer_email;
@property(nonatomic, strong) NSString* card_no;
@property(nonatomic, strong) NSString* exp_date;
@property(nonatomic, strong) NSString* payer_name;
@property(nonatomic, strong) NSString* cvv2;
@property(nonatomic, strong) NSString* token_id;
@property(nonatomic, strong) id<DirectAPIDelegate> delegate;
@property(nonatomic, strong) NSString* merchant_reference;
@property(nonatomic, strong) NSString* client_user_agent;
@property(nonatomic, strong) NSString* client_ip_address;
@property(nonatomic, strong) NSString* tenor_month;
@property(nonatomic, strong) NSString* secret_key;

- (id) initWithDelegate:(id<DirectAPIDelegate>) delegate;
- (void) startRequest;


@end
/* RDPDirectAPI_h */
