//
//  QueryStringBuilder.m
//  RDP SDK
//
//  Created by Ferico Samuel on 5/1/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import "QueryStringBuilder.h"

@implementation QueryStringBuilder

+ (NSString*) constructQueryString:(NSDictionary*) params {
    NSMutableString* queryString = [[NSMutableString alloc]init];
    for(NSString* key in params) {
        if(![queryString isEqualToString:@""])
           [queryString appendString:@"&"];
        [queryString appendString:key];
        [queryString appendString:@"="];
        [queryString appendString:[params valueForKey:key]];
    }
    return queryString;
}

@end
