//
//  RDPRedirectAPI.m
//  RDPSDK
//
//  Created by Ferico Samuel on 5/11/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import "RDPRedirectAPI.h"

@implementation RDPRedirectAPI

- (id) initWithDelegate:(id<RDPRedirectAPIDelegate>) delegate {
    self = [super init];
    self.delegate = delegate;
    return self;
}

- (void) checkVarCompletion {
    if(! self.delegate)
        [NSException raise:@"Incomplete Variable Binding" format:@"Delegate has to be set to a class"];
    if(!self.mid || [self.mid isEqualToString:@""])
        [NSException raise:@"Incomplete Variable Binding" format:@"mid can not be nil or empty"];
    if(!self.order_id || [self.order_id isEqualToString:@""])
        [NSException raise:@"Incomplete Variable Binding" format:@"order_id can not be nil or empty"];
    if(!self.amount || self.amount == 0)
        [NSException raise:@"Incomplete Variable Binding" format:@"amount can not be nil or 0"];
    if(!self.ccy || [self.ccy isEqualToString:@""])
        [NSException raise:@"Incomplete Variable Binding" format:@"ccy can not be nil or empty"];
    if(!self.back_url || [self.back_url isEqualToString:@""])
        [NSException raise:@"Incomplete Variable Binding" format:@"back_url can not be nil or empty"];
    if(!self.redirect_url || [self.redirect_url isEqualToString:@""])
        [NSException raise:@"Incomplete Variable Binding" format:@"redirect_url can not be nil or empty"];
    if(!self.notify_url || [self.notify_url isEqualToString:@""])
        [NSException raise:@"Incomplete Variable Binding" format:@"notify_url can not be nil or empty"];
    if(!self.secret_key || [self.secret_key isEqualToString:@""])
        [NSException raise:@"Incomplete Variable Binding" format:@"secret_key can not be nil or empty"];
}


- (void)checkAmoutValidation{
    if([self.ccy isEqualToString:@"THB"] && self.amount != (int)self.amount){
        [self.internalDelegate onRequestFailed];
        [self.delegate onRequestFailedWithErrorCode:0 andDescription:@"Incorrect currency amount"];
    }
}

- (void) startRequest {
    [self checkVarCompletion];
    if(self.delegate && [self.delegate respondsToSelector:@selector(paymentInterfaceWillRequest)])
        [self.delegate paymentInterfaceWillRequest];
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setValue:self.mid forKey:@"mid"];
    [dictionary setValue:RDP_RAPI_API_MODE forKey:@"api_mode"];
    if(self.payment_type == RDPRAPIPaymentTypeSale)
        [dictionary setValue:@"S" forKey:@"payment_type"];
    else if (self.payment_type == RDPRAPIPaymentTypeAuthorization)
        [dictionary setValue:@"A" forKey:@"payment_type"];
    else
        [dictionary setValue:@"I" forKey:@"payment_type"];
    [dictionary setValue:self.order_id forKey:@"order_id"];
    [dictionary setValue:self.ccy forKey:@"ccy"];
    if([self.ccy isEqualToString:@"THB"]){
        [dictionary setValue:[NSString stringWithFormat:@"%.0f", self.amount] forKey:@"amount"];
    }else{
        [dictionary setValue:[NSString stringWithFormat:@"%.02f", self.amount] forKey:@"amount"];
    }
    [dictionary setValue:self.back_url forKey:@"back_url"];
    [dictionary setValue:self.redirect_url forKey:@"redirect_url"];
    [dictionary setValue:self.notify_url forKey:@"notify_url"];
    
    if(self.payer_email != nil)
        [dictionary setValue:self.payer_email forKey:@"payer_email"];
    if(self.merchant_reference != nil)
        [dictionary setValue:self.merchant_reference forKey:@"merchant_reference"];
    if(self.locale != nil)
        [dictionary setValue:self.locale forKey:@"locale"];
    if(self.locale != nil)
        [dictionary setValue:self.locale forKey:@"locale"];
    if(self.multiple_method_page != nil)
        [dictionary setValue:self.multiple_method_page forKey:@"multiple_method_page"];
    if(self.bill_to_forename != nil)
        [dictionary setValue:self.bill_to_forename forKey:@"bill_to_forename"];
    if(self.bill_to_surname != nil)
        [dictionary setValue:self.bill_to_surname forKey:@"bill_to_surname"];
    if(self.bill_to_address_city != nil)
        [dictionary setValue:self.bill_to_address_city forKey:@"bill_to_address_city"];
    if(self.bill_to_address_line1 != nil)
        [dictionary setValue:self.bill_to_address_line1 forKey:@"bill_to_address_line1"];
    if(self.bill_to_address_line2 != nil)
        [dictionary setValue:self.bill_to_address_line2 forKey:@"bill_to_address_line2"];
    if(self.bill_to_address_country != nil)
        [dictionary setValue:self.bill_to_address_country forKey:@"bill_to_address_country"];
    if(self.bill_to_address_state != nil)
        [dictionary setValue:self.bill_to_address_state forKey:@"bill_to_address_state"];
    if(self.bill_to_address_postal_code != nil)
        [dictionary setValue:self.bill_to_address_postal_code forKey:@"bill_to_address_postal_code"];
    if(self.bill_to_phone != nil)
        [dictionary setValue:self.bill_to_phone forKey:@"bill_to_phone"];
    if(self.ship_to_forename != nil)
        [dictionary setValue:self.ship_to_forename forKey:@"ship_to_forename"];
    if(self.ship_to_surname != nil)
        [dictionary setValue:self.ship_to_surname forKey:@"ship_to_surname"];
    if(self.ship_to_address_city != nil)
        [dictionary setValue:self.ship_to_address_city forKey:@"ship_to_address_city"];
    if(self.ship_to_address_line1 != nil)
        [dictionary setValue:self.ship_to_address_line1 forKey:@"ship_to_address_line1"];
    if(self.ship_to_address_line2 != nil)
        [dictionary setValue:self.ship_to_address_line2 forKey:@"ship_to_address_line2"];
    if(self.ship_to_address_country != nil)
        [dictionary setValue:self.ship_to_address_country forKey:@"ship_to_address_country"];
    if(self.ship_to_address_state != nil)
        [dictionary setValue:self.ship_to_address_state forKey:@"ship_to_address_state"];
    if(self.ship_to_address_postal_code != nil)
        [dictionary setValue:self.ship_to_address_postal_code forKey:@"ship_to_address_postal_code"];
    if(self.ship_to_phone != nil)
        [dictionary setValue:self.ship_to_phone forKey:@"ship_to_phone"];
    if(self.tenor_month != 0)
        [dictionary setValue:[NSString stringWithFormat:@"%d", self.tenor_month] forKey:@"tenor_month"];
    
    NSString* amount = [dictionary valueForKey:@"amount"];
    NSString* paymentType = [dictionary valueForKey:@"payment_type"];
    NSString* signature = [SignatureUtil makeRAPISignatureWithMid:self.mid andOrderId:self.order_id andPaymentType:paymentType andAmount:amount andCcy:self.ccy andSecretKey:self.secret_key];
    [dictionary setValue:signature forKey:@"signature"];
    
    NSData* data = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:nil];
    NSString* dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"data string: %@", dataString);
    
    NSString* urlString = RDP_RAPI_DEV_URL;
    if([Util isProduction])
        urlString = RDP_RAPI_PRODUCTION_URL;
    NSURL* url = [[NSURL alloc]initWithString:urlString];

    [[HttpPostRequest alloc] initUsingHeader:NO andURL:url andData:data andResponseObject:[[RDPRedirectAPIResponse alloc]init] andDelegate:self];
}

- (void) onSuccessWith:(WsResponse*)responseObject {
    if(self.delegate && [self.delegate respondsToSelector:@selector(paymentInterfaceDidRequest)])
        [self.delegate paymentInterfaceDidRequest];
    
    RDPRedirectAPIResponse *response = (RDPRedirectAPIResponse*) responseObject;
    NSString* generatedSignature = [SignatureUtil makeRAPIGenericSignature:responseObject.jsonObject andSecretKey:self.secret_key];
    if([generatedSignature isEqualToString:response.signature]) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(paymentUrlWillLoad)])
            [self.delegate paymentUrlWillLoad];
            [self.internalDelegate onPaymentURLReceived:response.payment_url];
    }
    else{
        [self.internalDelegate onRequestFailed];
        [self.delegate onRequestFailedWithErrorCode:response.response_code.intValue andDescription:@"Invalid signature received!"];
    }
}

- (void) onErrorWith: (NSString*) error and:(id) request {
    [self.internalDelegate onRequestFailed];
    [self.delegate onRequestFailedWithErrorCode:0 andDescription:error.description];
}

- (void) onNoNetwork: (id) request {
    [self.internalDelegate onRequestFailed];
    [self.delegate onRequestFailedWithErrorCode:0 andDescription:@"No Internet connection"];
}

@end
