//
//  MD5Calculator.h
//  RDPSDK
//
//  Created by Ferico Samuel on 5/3/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 A Class to calculate MD5 Hashing
 */
@interface MD5Calculator : NSObject
/**
 Method that called to calculate from string using MD5 
 @param input the input string to be calculated using MD5
 @returns NSString the result string that has been hash or calculate to be MD5 form
 */
+ (NSString*) calculateFrom:(NSString*)input;

@end
