//
//  Util.m
//  RDP SDK
//
//  Created by Ferico Samuel on 5/1/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import "Util.h"

@implementation Util

static const NSString* ENVIRONMENT_PLIST_KEY = @"RDPEnvironment";
static const NSString* PRODUCTION_ENVIRONMENT_PLIST_VALUE = @"production";
static const NSString* DEVELOPMENT_ENVIRONMENT_PLIST_VALUE = @"development";

+ (BOOL) isProduction {
    NSString* path = [[NSBundle mainBundle]pathForResource:@"Info" ofType:@"plist"];
    NSDictionary* dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    if (dictionary != nil) {
        NSString* env = (NSString*)[dictionary valueForKey:ENVIRONMENT_PLIST_KEY];
        if([env isEqualToString:PRODUCTION_ENVIRONMENT_PLIST_VALUE])
            return true;
        return false;
    }
    return true;
}

@end
