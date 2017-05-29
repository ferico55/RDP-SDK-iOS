//
//  WsResponse.m
//  RDP SDK
//
//  Created by Ferico Samuel on 5/1/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import "WsResponse.h"

@implementation WsResponse

- (void) parse :(NSData*)data {
    NSError* error;
    self.jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &error];
    if(error)
        return;
    self.response_code = [self.jsonObject objectForKey:@"response_code"];
    self.response_msg = [self.jsonObject objectForKey:@"response_msg"];
}

- (BOOL) isSuccess {
    if(self.response_code.intValue == 0)
        return YES;
    return NO;
}

@end
