//
//  RDPRedirectAPIResponse.h
//  RDPSDK
//
//  Created by Ferico Samuel on 5/29/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WsResponse.h"

@interface RDPRedirectAPIResponse : WsResponse

@property(nonatomic, strong) NSString* mid;
@property(nonatomic, strong) NSString* signature;
@property(nonatomic, strong) NSString* expired_timestamp;
@property(nonatomic, strong) NSString* created_timestamp;
@property(nonatomic, strong) NSString* order_id;
@property(nonatomic, strong) NSString* transaction_id;
@property(nonatomic, strong) NSString* payment_url;

- (void) parse :(NSData*)data;

@end
