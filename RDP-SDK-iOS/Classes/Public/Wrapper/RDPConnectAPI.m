//
//  RDPConnectAPI.m
//  RDPSDK
//
//  Created by Ricky Putra Harlim on 5/8/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//


#import "RDPConnectAPI.h"
#import "SignatureUtil.h"
#import "UIViewControllerExtension.h"

@implementation RDPConnectAPI

- (id) initWithDelegate:(id<RDPConnectAPIDelegate>) delegate {
    self = [super init];
    self.delegate = delegate;
    return self;
}

- (void) checkVarCompletion {
    if(! self.delegate)
        [NSException raise:@"Incomplete Variable Binding" format:@"Delegate has to be set to a class"];
    if(!self.order_number || [self.order_number isEqualToString:@""])
        [NSException raise:@"Incomplete Variable Binding" format:@"order_number can not be nil or empty"];
    if(!self.merchant_id || [self.merchant_id isEqualToString:@""])
        [NSException raise:@"Incomplete Variable Binding" format:@"merchant_id can not be nil or empty"];
    if(!self.key || [self.key isEqualToString:@""])
        [NSException raise:@"Incomplete Variable Binding" format:@"key can not be nil or empty"];
    if(!self.amount || self.amount == 0)
        [NSException raise:@"Incomplete Variable Binding" format:@"amount can not be nil or 0"];
    if(!self.currency_code || [self.currency_code isEqualToString:@""])
        [NSException raise:@"Incomplete Variable Binding" format:@"currency_code can not be nil or empty"];
    if(!self.email || [self.email isEqualToString:@""])
        [NSException raise:@"Incomplete Variable Binding" format:@"email can not be nil or empty"];
    if(!self.return_url || [self.return_url isEqualToString:@""])
        [NSException raise:@"Incomplete Variable Binding" format:@"return_url can not be nil or empty"];
    if(!self.secret_key || [self.secret_key isEqualToString:@""])
        [NSException raise:@"Incomplete Variable Binding" format:@"secret_key can not be nil or empty"];
    
}

- (void) checkAmountValidation{
    if([self.currency_code isEqualToString:@"THB"] && self.amount != (int)self.amount){
        [self onErrorWith:@"Incorrect currency amount"];
        [self.internalDelegate onRequestFailed];
    }
}

- (void) startRequest {
    [self checkVarCompletion];
    if(self.delegate && [self.delegate respondsToSelector:@selector(paymentInterfaceWillRequest)])
        [self.delegate paymentInterfaceWillRequest];
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setValue:self.order_number forKey:@"order_number"];
    [dictionary setValue:self.merchant_id forKey:@"merchant_id"];
    [dictionary setValue:self.key forKey:@"key"];
    [dictionary setValue:self.currency_code forKey:@"currency_code"];
    [dictionary setValue:self.email forKey:@"email"];
    if([self.currency_code isEqualToString:@"THB"])
        [dictionary setValue:[NSString stringWithFormat:@"%d", (int)self.amount] forKey:@"amount"];
    else
        [dictionary setValue:[NSString stringWithFormat:@"%.02f", self.amount] forKey:@"amount"];
    if(self.transaction_type == sale) {
        [dictionary setValue:@"Sale" forKey:@"transaction_type"];
    }
    else
        [dictionary setValue:@"Authorization" forKey:@"transaction_type"];
    [dictionary setValue:self.return_url forKey:@"return_url"];
    
    if(self.merchant_reference != nil)
        [dictionary setValue:self.merchant_reference forKey:@"merchant_reference"];
    if(self.notify_url != nil)
        [dictionary setValue:self.notify_url forKey:@"notify_url"];
    if(self.promo_code != nil)
        [dictionary setValue:self.promo_code forKey:@"promo_code"];
    if(self.first_name != nil)
        [dictionary setValue:self.first_name forKey:@"first_name"];
    if(self.last_name != nil)
        [dictionary setValue:self.last_name forKey:@"last_name"];
    if(self.address_line1 != nil)
        [dictionary setValue:self.address_line1 forKey:@"address_line1"];
    if(self.address_line2 != nil)
        [dictionary setValue:self.address_line2 forKey:@"address_line2"];
    if(self.address_city != nil)
        [dictionary setValue:self.address_city forKey:@"address_city"];
    if(self.address_postal_code != nil)
        [dictionary setValue:self.address_postal_code forKey:@"address_postal_code"];
    if(self.address_state != nil)
        [dictionary setValue:self.address_state forKey:@"address_state"];
    if(self.address_country != nil)
        [dictionary setValue:self.address_country forKey:@"address_country"];
    if(self.merchant_data1 != nil)
        [dictionary setValue:self.merchant_data1 forKey:@"merchant_data1"];
    if(self.merchant_data2 != nil)
        [dictionary setValue:self.merchant_data2 forKey:@"merchant_data2"];
    if(self.merchant_data3 != nil)
        [dictionary setValue:self.merchant_data3 forKey:@"merchant_data3"];
    if(self.merchant_data4 != nil)
        [dictionary setValue:self.merchant_data4 forKey:@"merchant_data4"];
    if(self.merchant_data5 != nil)
        [dictionary setValue:self.merchant_data5 forKey:@"merchant_data5"];
    if(self.card_number != nil)
        [dictionary setValue:self.card_number forKey:@"card_number"];
    if(self.expiry_date != nil)
        [dictionary setValue:self.expiry_date forKey:@"expiry_date"];
    if(self.cvv2 != nil)
        [dictionary setValue:self.cvv2 forKey:@"cvv2"];
    if(self.token_id != nil)
        [dictionary setValue:self.token_id forKey:@"token_id"];
    if(self.order_timeout != nil)
        [dictionary setValue:self.order_timeout forKey:@"order_timeout"];
    
    NSString* signatureValue = [SignatureUtil makeSignatureFromParams:dictionary withSecretKey:self.secret_key];
    [dictionary setValue:signatureValue forKey:@"signature"];
    
    NSString* queryString = [QueryStringBuilder constructQueryString:dictionary];
    
    NSURL* url = [[NSURL alloc]initWithString:RDP_CAPI_DEV_URL];
    if([Util isProduction])
        url = [[NSURL alloc]initWithString:RDP_CAPI_PRODUCTION_URL];
    
    [[HttpPostRequest alloc]initUsingHeader:NO andURL:url andDataString:queryString andResponseObject:[[StringResponse alloc] init] andDelegate:self];
    NSLog(@"request started");
}

- (void) onSuccessWith:(WsResponse*)responseObject {
    if(self.delegate && [self.delegate respondsToSelector:@selector(paymentInterfaceDidRequest)])
        [self.delegate paymentInterfaceDidRequest];
    StringResponse* response = (StringResponse*) responseObject;
    NSLog(@"request success");
    if(self.internalDelegate != nil)
        [self.internalDelegate onWebViewContentLoaded:response.body];
}

- (void) onErrorWith: (NSString*) error and:(id) request {
    NSLog(@"request error");
    if(self.delegate && [self.delegate respondsToSelector:@selector(onRequestFailedWithErrorCode:andDescription:)])
        [self.delegate onRequestFailedWithErrorCode:[error intValue]  andDescription:error];
}

- (void) onNoNetwork: (id) request {
    NSLog(@"request no internet");
    [self.internalDelegate onRequestFailed];
    if(self.delegate && [self.delegate respondsToSelector:@selector(onRequestFailedWithErrorCode:andDescription:)])
        [self.delegate onRequestFailedWithErrorCode:0 andDescription:@"No Internet Connection"];
}

- (void) onErrorWith:(NSString *)error {
    if(self.delegate && [self.delegate respondsToSelector:@selector(onRequestFailedWithErrorCode:andDescription:)])
        [self.delegate onRequestFailedWithErrorCode:0 andDescription:error];
}

- (void) signatureWillValidate {
    if(self.delegate && [self.delegate respondsToSelector:@selector(transactionSignatureWillValidate)])
        [self.delegate transactionSignatureWillValidate];
}

- (void) signatureDidValidateWithParam: (NSDictionary*) params{
    if(self.delegate && [self.delegate respondsToSelector:@selector(transactionSignatureDidValidateWithParam:)])
        [self.delegate transactionSignatureDidValidateWithParam:params];
}

- (void) consentScreenDidDissapear {
    if(self.delegate && [self.delegate respondsToSelector:@selector(consentScreenDidDissapear)])
        [self.delegate consentScreenDidDissapear];
}

- (void) onRequestRejectedWithParams:(NSDictionary*) params andErrorCode:(int) errorCode {
    if(self.delegate && [self.delegate respondsToSelector:@selector(onRequestRejectedWithParams:andErrorCode:)])
       [self.delegate onRequestRejectedWithParams:params andErrorCode:errorCode];
}

- (void) onRequestFinishedWithParams:(NSDictionary*) params {
    if(self.delegate && [self.delegate respondsToSelector:@selector(onRequestFinishedWithParams:)])
        [self.delegate onRequestFinishedWithParams:params];
}

- (BOOL) shouldDismissConsentScreen {
    if(self.delegate && [self.delegate respondsToSelector:@selector(shouldDismissConsentScreen)])
        return [self.delegate shouldDismissConsentScreen];
    return NO;
}

@end
