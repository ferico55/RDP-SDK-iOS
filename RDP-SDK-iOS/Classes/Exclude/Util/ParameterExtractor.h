//
//  ParameterExtractor.h
//  RDPSDK
//
//  Created by Ferico Samuel on 5/9/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParameterExtractor : NSObject

+ (NSDictionary*) extractParamFromURL: (NSString*) url;

@end
