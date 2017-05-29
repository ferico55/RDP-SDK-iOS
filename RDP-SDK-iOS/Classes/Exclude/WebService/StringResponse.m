//
//  StringResponse.m
//  RDP SDK
//
//  Created by Ferico Samuel on 5/3/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import "StringResponse.h"

@implementation StringResponse

- (void) parse :(NSData*)data {
    self.response_code = @SUCCESS_RESPONSE_CODE;
    self.body = [[NSString alloc]initWithData:data encoding: NSUTF8StringEncoding];
}

@end
