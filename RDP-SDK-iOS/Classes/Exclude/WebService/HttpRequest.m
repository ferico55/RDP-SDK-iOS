//
//  HttpRequest.m
//  RDP SDK
//
//  Created by Ferico Samuel on 5/1/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest

- (id) initWithDelegate: (id) delegate andURL:(NSURL*) url andResponseObject:(WsResponse*) responseObject {
    self.delegate = delegate;
    self.request = [[NSMutableURLRequest alloc]initWithURL:url];
    self.responseObject = responseObject;
    return self;
}

- (void) makeRequest: (bool)isUsingHeader {
    self.isUsingHeader = isUsingHeader;
    NSURLSession* session = [NSURLSession sharedSession];
    [self.request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    if(isUsingHeader) {
        //TODO generate header
        //NSString* bearer = Util
    }
    //TODO check internet connection
    //NSURLSessionDataTask* task = [session dataTaskWithRequest:request];
    NSURLSessionDataTask* task = [session dataTaskWithRequest:self.request completionHandler:^(NSData* data, NSURLResponse* response, NSError* error){
        NSHTTPURLResponse* httpUrlResponse = (NSHTTPURLResponse*)response;
        if(httpUrlResponse.statusCode >= 200 && httpUrlResponse.statusCode < 300) {
            [self.responseObject parse:data];
            if([self.responseObject isSuccess]) {
                [self.delegate onSuccessWith:self.responseObject];
                return;
            }
            [self.delegate onErrorWith:self.responseObject.response_msg and:self];
        }
        else {
            if(httpUrlResponse == nil) {
                [self.delegate onErrorWith:@"0" and:self];
                return;
            }
            [self.delegate onErrorWith:[[NSString alloc]initWithFormat:@"%d" arguments:httpUrlResponse.statusCode] and:self];
        }
    }];
    [task resume];
}

- (void) retry {
    NSLog(@"%@", self.request.URL.absoluteString);
    //NSData* data = request.HTTPBody;
    [self makeRequest:self.isUsingHeader];
    
}

@end
