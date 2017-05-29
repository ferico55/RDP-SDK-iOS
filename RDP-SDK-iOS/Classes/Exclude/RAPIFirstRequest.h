//
//  RAPIFirstRequest.h
//  RDPSDK
//
//  Created by Ferico Samuel on 5/11/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDPRedirectAPI.h"

@interface RAPIFirstRequest : NSObject

@property(nonatomic, strong) NSString* mid;
@property(nonatomic, strong) NSString* api_mode;
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
@property(nonatomic) int tenor_month;

@end
