//
//  QueryStringBuilder.h
//  RDP SDK
//
//  Created by Ferico Samuel on 5/1/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 A Class to Build string query or param on url 
 */
@interface QueryStringBuilder : NSObject
/**
 Method that called to construct query from dictionary to string
 @param params the dictionary of query that want to convert to string
 @returns NSString the result string of query string
 */
+ (NSString*) constructQueryString:(NSDictionary*) params;

@end
