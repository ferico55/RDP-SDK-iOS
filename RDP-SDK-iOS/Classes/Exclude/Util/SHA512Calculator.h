//
//  SHA512Calculator.h
//  RDPSDK
//
//  Created by Ferico Samuel on 5/11/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CommonCrypto/CommonDigest.h>
/**
 A Class to calculate SHA512 Hashing
 */
@interface SHA512Calculator : NSObject
/**
 Method that called to calculate from string using SHA512 
 @param source the source string to be calculated using MD5
 @returns NSString the result string that has been hash or calculate to be SHA512 form
 */
+ (NSString *) createSHA512:(NSString *)source;

@end
