//
//  SHA512Calculator.h
//  RDPSDK
//
//  Created by Ferico Samuel on 5/11/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHA512Calculator : NSObject

+ (NSString *) createSHA512:(NSString *)source;

@end
