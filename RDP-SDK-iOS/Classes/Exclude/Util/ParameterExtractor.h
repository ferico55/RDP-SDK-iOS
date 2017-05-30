//
//  ParameterExtractor.h
//  RDPSDK
//
//  Created by Ferico Samuel on 5/9/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 A Class to extract the parameter from the url
 */
@interface ParameterExtractor : NSObject
/**
 Method that called to calculate from string using MD5 
 @param url the url that want being extracted its parameter
 @returns NSDictionary a Dictionary that consist key (param) and value (param value)
 */
+ (NSDictionary*) extractParamFromURL: (NSString*) url;

@end
