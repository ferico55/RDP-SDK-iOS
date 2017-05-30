//
//  RDPRedirectAPIPaymentType.h
//  RDPSDK
//
//  Created by Ferico Samuel on 5/29/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#ifndef RDPRedirectAPIPaymentType_h
#define RDPRedirectAPIPaymentType_h
/**
An enumeration of RAPI Payment Type
*/

typedef NS_ENUM(NSUInteger, RDPRedirectAPIPaymentType) {
    RDPRAPIPaymentTypeSale,
    RDPRAPIPaymentTypeAuthorization,
    RDPRAPIPaymentTypeInstallment,
};

#endif /* RDPRedirectAPIPaymentType_h */
