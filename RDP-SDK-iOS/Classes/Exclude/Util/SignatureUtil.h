//
//  SignatureValidator.h
//  RDPSDK
//
//  Created by Ferico Samuel on 5/3/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MD5Calculator.h"

@interface SignatureUtil : NSObject

+ (NSString*) makeSignatureFromParams:(NSDictionary*)params withSecretKey:(NSString*)secretKey;
+ (bool) matchSignature:(NSString*) signature withParams:(NSDictionary*)params andSecretKey:(NSString*) secretKey;
+ (bool) isSignatureValidatedWithQueryString:(NSString*) queryString andSecretKey:(NSString*) secretKey;
+ (NSString*) makeRAPISignatureWithMid:(NSString*) mid andOrderId:(NSString*) order_id andPaymentType:(NSString*) payment_type andAmount:(NSString*)amount andCcy:(NSString*) ccy andSecretKey:(NSString*) secret_key;
+ (NSString*) makeRAPIGenericSignature:(NSDictionary*) param andSecretKey:(NSString*) secret_key;
+ (bool) isRAPIGenericSignatureValidatedWithParams: (NSDictionary*) params andSecretKey:(NSString*) secret_key;
+ (NSString*) makeDAPISignatureWithCardModeWithMid:(NSString*) mid andOrderId:(NSString*) order_id andPaymentType:(NSString*) payment_type andAmount:(NSString*)amount andCcy:(NSString*) ccy andSecretKey:(NSString*) secret_key andCardNo:(NSString*)cardNo andExpDate:(NSString*)exp_date andCvv2:(NSString*)cvv2;
+ (NSString*) makeDAPISignatureWithTokenModeWithMid:(NSString*) mid andOrderId:(NSString*) order_id andPaymentType:(NSString*) payment_type andAmount:(NSString*)amount andCcy:(NSString*) ccy andSecretKey:(NSString*) secret_key andTokenid:(NSString*)token_id andExpDate:(NSString*)exp_date andCvv2:(NSString*)cvv2;
+ (NSString*) makeDAPIGenericSignature:(NSDictionary*) param andSecretKey:(NSString*) secret_key;
@end
