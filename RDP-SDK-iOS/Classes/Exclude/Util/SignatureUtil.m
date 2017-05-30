//
//  SignatureValidator.m
//  RDPSDK
//
//  Created by Ferico Samuel on 5/3/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import "SignatureUtil.h"
#import "SHA512Calculator.h"

@implementation SignatureUtil

+ (NSString*) makeSignatureFromParams:(NSDictionary*)params withSecretKey:(NSString*)secretKey {
    NSArray* keys = [params allKeys];
    NSArray* sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(NSString* a, NSString* b) {
        return [a compare:b];
    }];
    
    NSMutableString* queryString = [[NSMutableString alloc]init];
    for(NSString* key in sortedKeys) {
        if([key isEqualToString:@"signature"])
            continue;
        [queryString appendString:key];
        [queryString appendString:@"="];
        [queryString appendString:[params valueForKey:key]];
        [queryString appendString:@"&"];
    }
    
    [queryString appendString:@"secret_key="];
    [queryString appendString:secretKey];
    
    return [[MD5Calculator calculateFrom:queryString] lowercaseString];
}

+ (bool) matchSignature:(NSString*) signature withParams:(NSDictionary*)params andSecretKey:(NSString*) secretKey {
    return [signature isEqualToString:[self makeSignatureFromParams:params withSecretKey:secretKey]];
}

+ (bool) isSignatureValidatedWithQueryString:(NSString*) queryString andSecretKey:(NSString*) secretKey {
    queryString = [queryString componentsSeparatedByString:@"?"][1];
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    NSArray* paramArray = [queryString componentsSeparatedByString:@"&"];
    for(NSString* param in paramArray) {
        NSArray* keyValue = [param componentsSeparatedByString:@"="];
        [params setValue:keyValue[1] forKey:keyValue[0]];
    }
    
    NSString* signature = [params valueForKey:@"signature"];
    return [self matchSignature:signature withParams:params andSecretKey:secretKey];
}

+ (NSString*) makeRAPISignatureWithMid:(NSString*) mid andOrderId:(NSString*) order_id andPaymentType:(NSString*) payment_type andAmount:(NSString*)amount andCcy:(NSString*) ccy andSecretKey:(NSString*) secret_key {
    NSMutableString* key = [[NSMutableString alloc]init];
    [key appendString:mid];
    [key appendString:order_id];
    [key appendString:payment_type];
    [key appendString:amount];
    [key appendString:ccy];
    [key appendString:secret_key];
    
//    key = CC_SHA512(CFBridgingRetain([key dataUsingEncoding:NSUTF8StringEncoding]), (int)[key length], 'a');
//    return key;
    return [SHA512Calculator createSHA512:key];
}

+ (NSString*) makeRAPIGenericSignature:(NSDictionary*) param andSecretKey:(NSString*) secret_key {
    NSMutableString* raw = [[NSMutableString alloc] initWithString:[self generateGenericSignatureRawString:param]];
    [raw appendString:secret_key];
    
    return [SHA512Calculator createSHA512:raw];
}

+ (NSString*) makeDAPIGenericSignature:(NSDictionary*) param andSecretKey:(NSString*) secret_key{
    NSMutableString* raw = [[NSMutableString alloc] initWithString:[self generateGenericSignatureRawString:param]];
    [raw appendString:secret_key];
    return [SHA512Calculator createSHA512:raw];

}

+ (bool) isRAPIGenericSignatureValidatedWithParams: (NSDictionary*) params andSecretKey:(NSString*) secret_key {
    NSString* generatedSignature = [SignatureUtil makeRAPIGenericSignature:params andSecretKey:secret_key];
    NSString* signature = [params objectForKey:@"signature"];
    if([generatedSignature isEqualToString:signature])
        return true;
    return false;
}
/**
 Method that called recursive to make RAPI and DAPI param becomes NSString
 @param params the obj that provide to get the string from that
 @returns NSString a string of object to return
 */
+ (NSString*) generateGenericSignatureRawString:(id)params {
    if([params isKindOfClass:[NSString class]])
        return params;
    NSArray* keys = [params allKeys];
    NSArray* sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(NSString* a, NSString* b) {
        return [a compare:b];
    }];
    
    NSMutableString* result = [[NSMutableString alloc]init];
    for(NSString* key in sortedKeys) {
        if([key isEqualToString:@"signature"])
            continue;
        if([params valueForKey:key] == nil)
            continue;
        
        if([[params valueForKey:key] isKindOfClass:[NSString class]])
            [result appendString:[params valueForKey:key]];
        else if([[params valueForKey:key] isKindOfClass:[NSNumber class]]) {
            NSNumber *number = [params valueForKey:key];
            [result appendString:number.stringValue];
        }
        else if([[params valueForKey:key] isKindOfClass:[NSArray class]]) {
            NSArray* arr = [params valueForKey:key];
            for(id obj in arr)
                [result appendString:[self generateGenericSignatureRawString:obj]];
        }
        else
            [result appendString:[self generateGenericSignatureRawString:[params valueForKey:key]]];
    }
    return result;
}

+ (NSString*) makeDAPISignatureWithCardModeWithMid:(NSString*) mid andOrderId:(NSString*) order_id andPaymentType:(NSString*) payment_type andAmount:(NSString*)amount andCcy:(NSString*) ccy andSecretKey:(NSString*) secret_key andCardNo:(NSString*)cardNo andExpDate:(NSString*)exp_date andCvv2:(NSString*)cvv2{
    NSMutableString* key = [[NSMutableString alloc]init];
    [key appendString:mid];
    [key appendString:order_id];
    [key appendString:payment_type];
    [key appendString:amount];
    [key appendString:ccy];
    [key appendString:[cardNo substringWithRange:NSMakeRange(0, 6)]];
    [key appendString:[cardNo substringWithRange:NSMakeRange(cardNo.length-4, 4)]];
    [key appendString:exp_date];
    [key appendString:[cvv2 substringFromIndex:cvv2.length-1]];
    [key appendString:secret_key];
    return [SHA512Calculator createSHA512:key];
}
+ (NSString*) makeDAPISignatureWithTokenModeWithMid:(NSString*) mid andOrderId:(NSString*) order_id andPaymentType:(NSString*) payment_type andAmount:(NSString*)amount andCcy:(NSString*) ccy andSecretKey:(NSString*) secret_key andTokenid:(NSString*)token_id andExpDate:(NSString*)exp_date andCvv2:(NSString*)cvv2{
    NSMutableString* key = [[NSMutableString alloc]init];
    [key appendString:mid];
    [key appendString:order_id];
    [key appendString:payment_type];
    [key appendString:amount];
    [key appendString:ccy];
    [key appendString:[token_id substringWithRange:NSMakeRange(0, 6)]];
    [key appendString:[token_id substringWithRange:NSMakeRange(token_id.length-4, token_id.length-1)]];
    if(exp_date && ![exp_date isEqualToString:@""]){
        [key appendString:exp_date];
    }
    if(cvv2 && ![cvv2 isEqualToString:@""]){
        [key appendString:[cvv2 substringFromIndex:cvv2.length-1]];
    }
    [key appendString:secret_key];
    return [SHA512Calculator createSHA512:key];
}

//+ (NSString*) makeDAPISignatureWithTokenMode:(NSString*) mid andOrderId:(NSString*) order_id andPaymentType:(NSString*) payment_type andAmount:(NSString*)amount andCcy:(NSString*) ccy andSecretKey:(NSString*) secret_key{

@end
