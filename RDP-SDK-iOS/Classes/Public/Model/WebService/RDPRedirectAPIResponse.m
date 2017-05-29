//
//  RDPRedirectAPIResponse.m
//  RDPSDK
//
//  Created by Ferico Samuel on 5/29/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import "RDPRedirectAPIResponse.h"

@implementation RDPRedirectAPIResponse

- (void) parse :(NSData*)data {
    [super parse:data];
    if(self.response_code.intValue == 0) {
        self.mid = [self.jsonObject objectForKey:@"mid"];
        self.signature = [self.jsonObject objectForKey:@"signature"];
        self.expired_timestamp = [self.jsonObject objectForKey:@"expired_timestamp"];
        self.created_timestamp = [self.jsonObject objectForKey:@"created_timestamp"];
        self.order_id = [self.jsonObject objectForKey:@"order_id"];
        self.transaction_id = [self.jsonObject objectForKey:@"transaction_id"];
        self.payment_url = [self.jsonObject objectForKey:@"payment_url"];
    }
}

@end
