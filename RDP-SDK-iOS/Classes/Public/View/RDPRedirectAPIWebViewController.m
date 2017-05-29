//
//  RDPRedirectAPIWeb.m
//  RDPSDK
//
//  Created by Ferico Samuel on 5/13/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import "RDPRedirectAPIWebViewController.h"
#import "RDPRedirectAPIRedirectionResponse.h"

@implementation RDPRedirectAPIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initRDPRedirectAPIWrapper{
    RDPRedirectAPI *api = [[RDPRedirectAPI alloc]initWithDelegate:self.delegate];
    api.secret_key = self.secret_key;
    api.mid = self.mid;
    api.payment_type = self.payment_type;
    api.order_id = self.order_id;
    api.ccy = self.ccy;;
    api.amount = self.amount;
    api.back_url = self.back_url;
    api.redirect_url = self.redirect_url;
    api.notify_url= self.notify_url;
    api.payer_email = self.payer_email;
    api.merchant_reference = self.merchant_reference;
    api.locale = self.locale;
    api.multiple_method_page = self.multiple_method_page;
    api.bill_to_forename = self.bill_to_forename;
    api.bill_to_surname = self.bill_to_surname;
    api.bill_to_address_city = self.bill_to_address_city;
    api.bill_to_address_line1 = self.bill_to_address_line1;
    api.bill_to_address_line2 = self.bill_to_address_line2;
    api.bill_to_address_country = self.bill_to_address_country;
    api.bill_to_address_state = self.bill_to_address_state;
    api.bill_to_address_postal_code = self.bill_to_address_postal_code;
    api.bill_to_phone = self.bill_to_phone;
    api.ship_to_forename = self.ship_to_forename;
    api.ship_to_surname = self.ship_to_surname;
    api.ship_to_address_city = self.ship_to_address_city;
    api.ship_to_address_line1 = self.ship_to_address_line1;
    api.ship_to_address_line2 = self.ship_to_address_line2;
    api.ship_to_address_country = self.ship_to_address_country;
    api.ship_to_address_state = self.ship_to_address_state;
    api.ship_to_address_postal_code = self.ship_to_address_postal_code;
    api.ship_to_phone = self.ship_to_phone;
    
    self.redirectAPIWrapper = api;
}

- (void)initView{
    CGRect frame = CGRectMake(self.view.frame.origin.x, 47, self.view.frame.size.width, self.view.frame.size.height);
    self.webView = [[UIWebView alloc]initWithFrame:frame];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    self.btnNavDone = [[UIBarButtonItem alloc]
                  initWithTitle:@"Done"
                  style:UIBarButtonItemStyleBordered
                  target:self
                  action:@selector(OnFinishConnectAPI:)];
    self.btnNavDone.enabled = NO;
    if(self.navigationController == nil){
        UINavigationBar *navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        UINavigationItem *navItem = [[UINavigationItem alloc]init];
        navItem.rightBarButtonItem = self.btnNavDone;
        navbar.items = @[ navItem ];
        [self.view addSubview:navbar];
    }else{
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = self.btnNavDone;
    }
}

-(IBAction)OnFinishConnectAPI:(id)sender{
    if(self.navigationController == nil){
        [self dismissViewControllerAnimated:true completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:true];
    }
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIViewControllerExtension dismissPopUp:self];
    
    if([webView.request.URL.absoluteString isEqualToString:self.payment_url]) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(paymentUrlDidLoad)])
            [self.delegate paymentUrlDidLoad];
    }
    else if([webView.request.URL.absoluteString isEqualToString:self.redirect_url]) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(redirectUrlDidLoad)])
            [self.delegate redirectUrlDidLoad];
    }
}

- (void) webViewDidStartLoad:(UIWebView *)webView {
    [UIViewControllerExtension showLoadingPopUp:self];
}


- (void) viewWillAppear:(BOOL)animated {
    [self initRDPRedirectAPIWrapper];
    self.redirectAPIWrapper.internalDelegate = self;
    [self.redirectAPIWrapper startRequest];
    [UIViewControllerExtension showLoadingPopUp:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated{
    self.webView = nil;
    self.btnNavDone = nil;
    if(self.delegate && [self.delegate respondsToSelector:@selector(consentScreenDidDissapear)])
        [self.delegate consentScreenDidDissapear];
}

- (void) onRequestFailed {
    [UIViewControllerExtension dismissPopUpUsingDispatch:self completion:^{
        if(self.navigationController == nil){
            [self dismissViewControllerAnimated:true completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:true];
        }
    }];}

- (void) onPaymentURLReceived:(NSString*) payment_url {
    self.payment_url = payment_url;
    NSURL *url = [[NSURL alloc] initWithString:payment_url];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [self.webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"trying to load %@", request.URL.absoluteString);
    if([request.URL.absoluteString containsString:self.redirectAPIWrapper.redirect_url]) {
        self.btnNavDone.enabled = YES;
        NSDictionary* returnParams = [ParameterExtractor extractParamFromURL:request.URL.absoluteString];
        NSString *transaction_id = [returnParams objectForKey:@"transaction_id"];
        if(transaction_id == nil) {
            if([self.webView isLoading])
                [UIViewControllerExtension dismissPopUp:self];
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.delegate onRequestFailedWithErrorCode:0 andDescription:@"Invalid transaction id"];
        }
        
        [returnParams setValue:self.mid forKey:@"request_mid"];
        NSString* signature = [SignatureUtil makeRAPIGenericSignature:returnParams andSecretKey:self.secret_key];
        [returnParams setValue:signature forKey:@"signature"];
        
        NSData* data = [NSJSONSerialization dataWithJSONObject:returnParams options:0 error:nil];
        
        NSString* urlString = RDP_REDIRECT_API_QUERY_SERVICE_DEV_ENPOINT;
        if([Util isProduction])
            urlString = RDP_REDIRECT_API_QUERY_SERVICE_PRODUCTION_ENPOINT;
        NSURL* url = [[NSURL alloc]initWithString:urlString];
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(redirectionResultWillRequest)])
            [self.delegate redirectionResultWillRequest];
        [[HttpPostRequest alloc] initUsingHeader:NO andURL:url andData:data andResponseObject:[[RDPRedirectAPIRedirectionResponse alloc]init] andDelegate:self];
        if(self.delegate && [self.delegate respondsToSelector:@selector(redirectUrlWillLoad)])
            [self.delegate redirectUrlWillLoad];
    }
    else if([request.URL.absoluteString containsString:self.redirectAPIWrapper.back_url]) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(btnBackDidTap)])
            [self.delegate btnBackDidTap];
        if([self.webView isLoading])
            [UIViewControllerExtension dismissPopUp:self];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if(error.code == 999 || error.code == -999)
        return;
        
    [self.delegate onRequestFailedWithErrorCode:(int)error.code andDescription:error.description];
    if([self.webView isLoading])
        [UIViewControllerExtension dismissPopUp:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) onSuccessWith:(WsResponse*)responseObject {
    if(self.delegate && [self.delegate respondsToSelector:@selector(redirectionResultDidRequest)])
        [self.delegate redirectionResultDidRequest];
    
    if([SignatureUtil isRAPIGenericSignatureValidatedWithParams:responseObject.jsonObject andSecretKey:self.secret_key]) {
        RDPRedirectAPIRedirectionResponse *response = (RDPRedirectAPIRedirectionResponse*) responseObject;
        [self.delegate onRequestFinishedWithResponseObject:response];
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(shouldDismissConsentScreen)]) {
            if([self.delegate shouldDismissConsentScreen]) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }
    else {
        [self.delegate onRequestFailedWithErrorCode:0 andDescription:@"Invalid signature received while trying to get transaction detail"];
        if([self.webView isLoading])
            [UIViewControllerExtension dismissPopUp:self];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void) onErrorWith: (NSString*) error and:(id) request {
    [self.delegate onRequestFailedWithErrorCode:0 andDescription:error.description];
    if([self.webView isLoading])
        [UIViewControllerExtension dismissPopUp:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) onNoNetwork: (id) request {
    [self.delegate onRequestFailedWithErrorCode:0 andDescription:@"No Internet connection"];
    if([self.webView isLoading])
        [UIViewControllerExtension dismissPopUp:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
