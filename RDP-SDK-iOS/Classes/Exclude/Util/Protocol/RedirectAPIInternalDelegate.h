//
//  RedirectAPIInternalDelegate.h
//  RDPSDK
//
//  Created by Ferico Samuel on 5/11/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#ifndef RedirectAPIInternalDelegate_h
#define RedirectAPIInternalDelegate_h

/**
 Set of methods to be implemented to act
 as a Redirect API (RAPI) Internal
 that only use on RDPRedirectAPIWebViewController
 */
@protocol RedirectAPIInternalDelegate <NSObject>
/**
 Method that called when payment url has been received
 @param payment_url the url that RAPI web view will request
 */
- (void) onPaymentURLReceived:(NSString*) payment_url;
/**
 Method that called when request is failed
 */
- (void) onRequestFailed;

@end

#endif /* RedirectAPIInternalDelegate_h */
