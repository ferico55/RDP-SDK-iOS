//
//  WsResponse.h
//  RDP SDK
//
//  Created by Ferico Samuel on 5/1/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import <Foundation/Foundation.h>
#define SUCCESS_RESPONSE_CODE "0"

@interface WsResponse : NSObject

@property(nonatomic, strong) NSString* response_msg;
@property(nonatomic, strong) NSString* response_code;
@property(nonatomic, strong) id jsonObject;

- (void) parse :(NSData*)data;
- (BOOL) isSuccess;

@end
