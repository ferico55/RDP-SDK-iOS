//
//  ConnectAPIInternalDelegate.h
//  RDP SDK
//
//  Created by Ferico Samuel on 5/3/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#ifndef ConnectAPIInternalDelegate_h
#define ConnectAPIInternalDelegate_h
/**
 Set of methods to be implemented to act
 as a Connect API (CAPI) Internal
 that only use on RDPConnectAPIWebViewController
 */
@protocol ConnectAPIInternalDelegate <NSObject>
/**
 Method that called when web view content has been loaded
 @param content the content that loaded on web view
 */
- (void) onWebViewContentLoaded:(NSString*) content;
/**
 Method that called when request is failed
 */
- (void) onRequestFailed;

@end


#endif /* ConnectAPIInternalDelegate_h */
