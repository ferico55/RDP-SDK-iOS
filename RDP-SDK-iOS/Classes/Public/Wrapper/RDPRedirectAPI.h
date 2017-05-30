//
//  RDPRedirectAPI.h
//  RDPSDK
//
//  Created by Ferico Samuel on 5/11/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDPRedirectAPIPaymentType.h"
#import "RAPIFirstRequest.h"
#import "RedirectAPIInternalDelegate.h"
#import "SignatureUtil.h"
#import "HttpPostRequest.h"
#import "Util.h"
#import "RDPRedirectAPIResponse.h"
#import "RDPRedirectAPIRedirectionResponse.h"
#define RDP_RAPI_API_MODE @"redirection_hosted" 
#define RDP_RAPI_DEV_URL @"https://secure-dev.reddotpayment.com/service/payment-api"
#define RDP_RAPI_PRODUCTION_URL @"https://secure.reddotpayment.com/service/payment-api"

/**
 Set of methods to be implemented to act as a Redirect API (RAPI)
 */
@protocol RDPRedirectAPIDelegate <NSObject>
/**
 Method that called when payment url has been received
 @param url url that use to pay the payment
 @param response response that we get first after request in RDPRAPIResponse Class
 */
- (void) paymentURLDidReceivedWithURL:(NSString*) url andResponse:(RDPRedirectAPIResponse*) response;
/**
 Method that called when request transaction is failed
 @param errorCode HTTP Response Code
 @param description Description Of Error
 */
- (void) onRequestFailedWithErrorCode:(int) errorCode andDescription:(NSString*) description;
/**
 Method that called when request transaction is Finished or Success
 @param response the response that return from server
 */
- (void) onRequestFinishedWithResponseObject:(RDPRedirectAPIRedirectionResponse*) response;

@optional
/**
 Method that called just before the payment request
 */
- (void) paymentInterfaceWillRequest;
/**
 Method that called just after the payment Request
 */
- (void) paymentInterfaceDidRequest;
/**
 Method that called just before the payment url load
 */
- (void) paymentUrlWillLoad;
/**
 Method that called just after the payment url load
 */
- (void) paymentUrlDidLoad;
/**
 Method that called just before the redirection result will request
 */
- (void) redirectionResultWillRequest;
/**
 Method that called just after the redirection result request
 */
- (void) redirectionResultDidRequest;
/**
 Method that called just before the redirection url load
 */
- (void) redirectUrlWillLoad;
/**
 Method that called just after the redirection url load
 */
- (void) redirectUrlDidLoad;
/**
 Method that called just after btnBack has been tap
 */
- (void) btnBackDidTap;
/**
 Method that call when consent screen is will be appear or not.
 This method default falue is NO
 @returns returns YES if you want to dismiss consent screen, otherwise returns NO.
 */
- (BOOL) shouldDismissConsentScreen;
/**
 Method that called just after the consent screen dissapear
 */
- (void) consentScreenDidDissapear;
@end

@interface RDPRedirectAPI : NSObject<WsDelegate>

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

@property(nonatomic, strong) id<RDPRedirectAPIDelegate> delegate;
@property(nonatomic, strong) id<RedirectAPIInternalDelegate> internalDelegate;

- (id) initWithDelegate:(id<RDPRedirectAPIDelegate>) delegate;
- (void) startRequest;
- (void) checkAmountValidation;


@end
