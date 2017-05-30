//
//  RDPDirectAPIPaymentType.h
//  RDPSDK
//
//  Created by Ferico Samuel on 5/29/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#ifndef RDPDirectAPIPaymentType_h
#define RDPDirectAPIPaymentType_h
/**
An enumeration of DAPI Payment Type
*/
typedef NS_ENUM(NSUInteger, RDPDirectAPIPaymentType) {
    RDPDirectPaymentTypeSale,
    RDPDirectPaymentTypeAuthorization,
    RDPDirectPaymentTypeInstallment,
};

#endif /* RDPDirectAPIPaymentType_h */
