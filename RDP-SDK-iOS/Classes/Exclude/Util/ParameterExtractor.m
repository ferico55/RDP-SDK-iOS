//
//  ParameterExtractor.m
//  RDPSDK
//
//  Created by Ferico Samuel on 5/9/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import "ParameterExtractor.h"

@implementation ParameterExtractor

+ (NSDictionary*) extractParamFromURL: (NSString*) url {
    url = [url componentsSeparatedByString:@"?"][1];
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    NSArray* paramArray = [url componentsSeparatedByString:@"&"];
    for(NSString* param in paramArray) {
        NSArray* keyValue = [param componentsSeparatedByString:@"="];
        
        NSString *value = [keyValue[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        value = [value lowercaseString];
        NSString *key = [keyValue[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        key = [key lowercaseString];
        [params setValue:value forKey:key];
    }
    return params;
}

@end
