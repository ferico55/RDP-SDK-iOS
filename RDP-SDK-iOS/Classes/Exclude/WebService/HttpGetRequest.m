//
//  HttpGetRequest.m
//  RDP SDK
//
//  Created by Ferico Samuel on 5/1/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import "HttpGetRequest.h"

@implementation HttpGetRequest

- (id) initUsingHeader:(bool)isUsingHeader withURL:(NSURL*) url andResponseObject:(WsResponse*) responseObject andDelegate:(id) delegate {
    self = [super initWithDelegate:delegate andURL:url andResponseObject:responseObject];
    self.request.HTTPMethod = @"GET";
    [self makeRequest:isUsingHeader];
    return self;
}

@end
