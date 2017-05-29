//
//  HttpGetRequest.h
//  RDP SDK
//
//  Created by Ferico Samuel on 5/1/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequest.h"

@interface HttpGetRequest : HttpRequest

- (id) initUsingHeader:(bool)isUsingHeader withURL:(NSURL*) url andResponseObject:(WsResponse*) responseObject andDelegate:(id) delegate;

@end
