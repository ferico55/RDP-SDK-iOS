//
//  SignatureValidator.h
//  RDPSDK
//
//  Created by Ferico Samuel on 5/3/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MD5Calculator.h"
/**
 A Class to for Signature Functionality 
 */
@interface SignatureUtil : NSObject
/**
 Method that called to make signature from params and secret key on RDPConnectAPI .
 @param params the dictionary of param that want to generate to be signature
 @param secretKey the key that use to make queryString and join the last after params
 @returns NSString a string of signature value that has been calculate.
 */
+ (NSString*) makeSignatureFromParams:(NSDictionary*)params withSecretKey:(NSString*)secretKey;
/**
 Method that called to check is signature is equal to signature that will be generate using makeSingatureFromParams Function
 @param NSString the signature that already provide to compare with new generated signature using params and secret key
 @param params the dictionary of param that want to generate to be new generated signature to compare with signature from parameter that provided
 @param secretKey the key that use to make queryString and join the last after params to be new generated signature to compare with signature from parameter that provided
 @returns bool yes if signature and generated signature is same and vice versa.
 */
+ (bool) matchSignature:(NSString*) signature withParams:(NSDictionary*)params andSecretKey:(NSString*) secretKey;
/**
 Method that called to compare queryString signature with new generated key from query string and secret key is match using at RDPConnectAPIWebViewController.
 @param queryString the queryString that contains signature and other value that needs to make signature
 @param secretKey the key that use to make queryString and join the last after params
 @returns bool yes if signature and generated signature is same and vice versa.
 */
+ (bool) isSignatureValidatedWithQueryString:(NSString*) queryString andSecretKey:(NSString*) secretKey;
/**
 Method that called to make RAPI signature using Merchant ID for RDPRedirectAPI
 @param mid the merchant id given by RDP when setting up an account.
 @param order_id Merchant defined order-id for the transaction. Used for identifying the transaction request. Suggested to be of unique values.
 @param payment_type the payment_type that used.
 @param amount amount of payment that requested
 @param ccy currency that used
 @param secretKey the key that given by RDP
 @returns NSString a string of signature value that has been calculate using SHA512Calculator.
 */
+ (NSString*) makeRAPISignatureWithMid:(NSString*) mid andOrderId:(NSString*) order_id andPaymentType:(NSString*) payment_type andAmount:(NSString*)amount andCcy:(NSString*) ccy andSecretKey:(NSString*) secret_key;
/**
 Method that called to make RAPI Generic Signature 
 @param params the dictionary of param that want to generate to be signature
 @param secretKey the key that given by RDP to make generic signature value
 @returns NSString a string of signature value that has been calculate using SHA512Calculator.
 */
+ (NSString*) makeRAPIGenericSignature:(NSDictionary*) param andSecretKey:(NSString*) secret_key;
/**
 Method that called to check is signature from params is equal to signature that will be generate using makeRAPIGenericSignature Function
 @param params the dictionary consist of signature value and other value to make generated Signature
 @param secretKey the key that given by RDP to make generic signature value
 @returns bool yes if signature and generated signature is same and vice versa.
 */
+ (bool) isRAPIGenericSignatureValidatedWithParams: (NSDictionary*) params andSecretKey:(NSString*) secret_key;
/**
 Method that called to make DAPI signature using Card Mode
 @param mid the merchant id given by RDP when setting up an account.
 @param order_id Merchant defined order-id for the transaction. Used for identifying the transaction request. Suggested to be of unique values.
 @param payment_type the payment_type that used.
 @param amount amount of payment that requested
 @param ccy currency that used
 @param secretKey the key that given by RDP
 @param cardNo the card number
 @param exp_date the expiry date of card
 @param cvv2  the 3 – 4 digits security code on the back of a credit card
 @returns NSString a string of signature value that has been calculate using SHA512Calculator.
 */
+ (NSString*) makeDAPISignatureWithCardModeWithMid:(NSString*) mid andOrderId:(NSString*) order_id andPaymentType:(NSString*) payment_type andAmount:(NSString*)amount andCcy:(NSString*) ccy andSecretKey:(NSString*) secret_key andCardNo:(NSString*)cardNo andExpDate:(NSString*)exp_date andCvv2:(NSString*)cvv2;
/**
 Method that called to make DAPI signature using Token ID
 @param mid the merchant id given by RDP when setting up an account.
 @param order_id Merchant defined order-id for the transaction. Used for identifying the transaction request. Suggested to be of unique values.
 @param payment_type the payment_type that used.
 @param amount amount of payment that requested
 @param ccy currency that used
 @param secretKey the key that given by RDP
 @param token_id the card number
 @param exp_date the expiry date of card
 @param cvv2  the 3 – 4 digits security code on the back of a credit card
 @returns NSString a string of signature value that has been calculate using SHA512Calculator.
 */
+ (NSString*) makeDAPISignatureWithTokenModeWithMid:(NSString*) mid andOrderId:(NSString*) order_id andPaymentType:(NSString*) payment_type andAmount:(NSString*)amount andCcy:(NSString*) ccy andSecretKey:(NSString*) secret_key andTokenid:(NSString*)token_id andExpDate:(NSString*)exp_date andCvv2:(NSString*)cvv2;
/**
 Method that called to make RAPI Generic Signature 
 @param params the dictionary of param that want to generate to be signature
 @param secretKey the key that given by RDP to make generic signature value
 @returns NSString a string of signature value that has been calculate using SHA512Calculator.
 */
+ (NSString*) makeDAPIGenericSignature:(NSDictionary*) param andSecretKey:(NSString*) secret_key;
@end
