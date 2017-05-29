//
//  RAPIFirstRequest.m
//  RDPSDK
//
//  Created by Ferico Samuel on 5/11/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import "RAPIFirstRequest.h"

@implementation RAPIFirstRequest

- (id) init {
    self = [super init];
    self.mid = [[NSString alloc]init];
    self.api_mode = [[NSString alloc]init];
    self.order_id = [[NSString alloc]init];
    self.ccy = [[NSString alloc]init];
    self.notify_url = [[NSString alloc]init];
    self.redirect_url = [[NSString alloc]init];
    self.back_url = [[NSString alloc]init];
    self.payer_email = [[NSString alloc]init];
    self.merchant_reference = [[NSString alloc]init];
    self.locale = [[NSString alloc]init];
    self.bill_to_forename = [[NSString alloc]init];
    self.bill_to_address_city = [[NSString alloc]init];
    self.bill_to_surname = [[NSString alloc]init];
    self.bill_to_address_city = [[NSString alloc]init];
    self.bill_to_address_line1 = [[NSString alloc]init];
    self.bill_to_address_line2 = [[NSString alloc]init];
    self.bill_to_address_country = [[NSString alloc]init];
    self.bill_to_address_postal_code = [[NSString alloc]init];
    self.bill_to_phone = [[NSString alloc]init];
    self.bill_to_address_state = [[NSString alloc]init];
    self.ship_to_forename = [[NSString alloc]init];
    self.ship_to_address_city = [[NSString alloc]init];
    self.ship_to_surname = [[NSString alloc]init];
    self.ship_to_address_city = [[NSString alloc]init];
    self.ship_to_address_line1 = [[NSString alloc]init];
    self.ship_to_address_line2 = [[NSString alloc]init];
    self.ship_to_address_country = [[NSString alloc]init];
    self.ship_to_address_postal_code = [[NSString alloc]init];
    self.ship_to_phone = [[NSString alloc]init];
    self.ship_to_address_state = [[NSString alloc]init];
    return self;
}

@end
