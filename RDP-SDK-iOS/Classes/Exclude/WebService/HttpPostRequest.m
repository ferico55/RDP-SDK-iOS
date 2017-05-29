//
//  HttpPostRequest.m
//  RDP SDK
//
//  Created by Ferico Samuel on 5/1/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import "HttpPostRequest.h"

@implementation HttpPostRequest

- (id) initUsingHeader:(bool) isUsingHeader andURL:(NSURL*) url andDataString:(NSString*) data andResponseObject:(WsResponse*) responseObject andDelegate:(id<WsDelegate>) delegate {
    self = [super initWithDelegate:delegate andURL:url andResponseObject:responseObject];
    self.request.HTTPMethod = @"POST";
    self.request.HTTPBody = [data dataUsingEncoding:NSUTF8StringEncoding];
    [self makeRequest:isUsingHeader];
    return self;
}
- (id) initUsingHeader:(bool) isUsingHeader andURL:(NSURL*) url andData:(NSData*) data andResponseObject:(WsResponse*) responseObject andDelegate:(id<WsDelegate>) delegate {
    self = [super initWithDelegate:delegate andURL:url andResponseObject:responseObject];
    self.request.HTTPMethod = @"POST";
    self.request.HTTPBody = data;
    [self makeRequest:isUsingHeader];
    return self;
}
- (id) initUsingHeader:(bool) isUsingHeader andURL:(NSURL*) url andResponseObject:(WsResponse*) responseObject andDelegate:(id<WsDelegate>) delegate {
    self = [super initWithDelegate:delegate andURL:url andResponseObject:responseObject];
    self.request.HTTPMethod = @"POST";
    [self makeRequest:isUsingHeader];
    return self;
}

@end
