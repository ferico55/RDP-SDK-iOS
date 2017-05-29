//
//  RDPRedirectAPIRedirectionResponse.h
//  RDPSDK
//
//  Created by Ferico Samuel on 5/29/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WsResponse.h"
#import "RDPRedirectAPIPaymentType.h"

@interface RDPRedirectAPIRedirectionResponse : WsResponse

@property(nonatomic, strong) NSString* mid;
@property(nonatomic, strong) NSString* request_mid;
@property(nonatomic, strong) NSString* order_id;
@property(nonatomic, strong) NSString* transaction_id;
@property(nonatomic) float request_amount;
@property(nonatomic, strong) NSString* request_ccy;
@property(nonatomic) float authorized_amount;
@property(nonatomic, strong) NSString* authorized_ccy;
@property(nonatomic) enum RDPRedirectAPIPaymentType transaction_type;
@property(nonatomic, strong) NSString* created_timestamp;
@property(nonatomic, strong) NSString* acquirer_response_code;
@property(nonatomic, strong) NSString* acquirer_response_msg;
@property(nonatomic, strong) NSString* signature;
@property(nonatomic) float acquirer_authorized_amount;
@property(nonatomic, strong) NSString* acquirer_authorized_ccy;
@property(nonatomic, strong) NSString* merchant_reference;
@property(nonatomic, strong) NSString* acquirer_created_timestamp;
@property(nonatomic, strong) NSString* acquirer_transaction_id;
@property(nonatomic, strong) NSString* acquirer_authorization_code;
@property(nonatomic, strong) NSString* first_6;
@property(nonatomic, strong) NSString* last_4;
@property(nonatomic, strong) NSString* payer_name;
@property(nonatomic, strong) NSString* exp_date;

@end
