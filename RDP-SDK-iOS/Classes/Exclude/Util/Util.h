//
//  Util.h
//  RDP SDK
//
//  Created by Ferico Samuel on 5/1/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 A Class to place a utility of this SDK
 */
@interface Util : NSObject
 /**
 Method that called to set is this SDK being used for Production or for Development 
 @returns BOOL the result is the boolean of production (YES) and Development (NO)
 */
+ (BOOL) isProduction;

@end
