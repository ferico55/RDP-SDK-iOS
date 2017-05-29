//
//  HttpRequest.h
//  RDP SDK
//
//  Created by Ferico Samuel on 5/1/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WsResponse.h"

@protocol WsDelegate <NSObject>

- (void) onSuccessWith:(WsResponse*)responseObject;
- (void) onErrorWith: (NSString*) error and:(id) request;
- (void) onNoNetwork: (id) request;

@end

@interface HttpRequest : NSObject

@property(nonatomic, strong) id<WsDelegate> delegate;
@property(nonatomic) bool isUsingHeader;
@property(nonatomic, strong) NSMutableURLRequest* request;
@property(nonatomic, strong) WsResponse* responseObject;
- (void) makeRequest: (bool)isUsingHeader;
- (id) initWithDelegate: (id<WsDelegate>) delegate andURL:(NSURL*) url andResponseObject:(WsResponse*) responseObject;
- (void) retry;

@end
