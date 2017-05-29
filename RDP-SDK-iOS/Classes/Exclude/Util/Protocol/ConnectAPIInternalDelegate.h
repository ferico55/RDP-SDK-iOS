//
//  ConnectAPIInternalDelegate.h
//  RDP SDK
//
//  Created by Ferico Samuel on 5/3/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#ifndef ConnectAPIInternalDelegate_h
#define ConnectAPIInternalDelegate_h

@protocol ConnectAPIInternalDelegate <NSObject>

- (void) onWebViewContentLoaded:(NSString*) content;
- (void) onRequestFailed;

@end


#endif /* ConnectAPIInternalDelegate_h */
