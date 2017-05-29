//
//  HttpPostRequest.h
//  RDP SDK
//
//  Created by Ferico Samuel on 5/1/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequest.h"

@interface HttpPostRequest : HttpRequest

- (id) initUsingHeader:(bool) isUsingHeader andURL:(NSURL*) url andDataString:(NSString*) data andResponseObject:(WsResponse*) responseObject andDelegate:(id) delegate;
- (id) initUsingHeader:(bool) isUsingHeader andURL:(NSURL*) url andData:(NSData*) data andResponseObject:(WsResponse*) responseObject andDelegate:(id) delegate;
- (id) initUsingHeader:(bool) isUsingHeader andURL:(NSURL*) url andResponseObject:(WsResponse*) responseObject andDelegate:(id) delegate;

@end
