//
//  RDPConnectAPIWebViewController.m
//  RDP SDK
//
//  Created by Ricky Putra Harlim on 5/2/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import "RDPConnectAPIWebViewController.h"

@interface RDPConnectAPIWebViewController ()

@end

@implementation RDPConnectAPIWebViewController

@synthesize webView,btnNavDone,order_number,amount,secret_key,currency_code,merchant_id,key,email,transaction_type,return_url,card_number,cvv2,expiry_date;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initRDPConnectAPIWrapper{
    RDPConnectAPI *api = [[RDPConnectAPI alloc]initWithDelegate:self.delegate];
    api.order_number = order_number;
    api.amount =  amount;
    api.currency_code = currency_code;
    api.merchant_id = merchant_id;
    api.key = key;
    api.email = email;
    api.transaction_type = transaction_type;
    api.secret_key = secret_key;
    api.return_url = return_url;
    if(self.card_number && ![self.card_number isEqualToString:@""] ){
        api.card_number = card_number;
        api.cvv2 = cvv2;
        api.expiry_date = expiry_date;
    }

    self.connectAPIWrapper = api;
}

- (void)initView{
    CGRect frame = CGRectMake(self.view.frame.origin.x, 47, self.view.frame.size.width, self.view.frame.size.height);
    webView = [[UIWebView alloc]initWithFrame:frame];
    webView.delegate = self;
    [self.view addSubview:webView];
    btnNavDone = [[UIBarButtonItem alloc]
                  initWithTitle:@"Done"
                  style:UIBarButtonItemStyleBordered
                  target:self
                  action:@selector(OnFinishConnectAPI:)];
    btnNavDone.enabled = NO;
    if(self.navigationController == nil){
        UINavigationBar *navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        UINavigationItem *navItem = [[UINavigationItem alloc]init];
        navItem.rightBarButtonItem = btnNavDone;
        navbar.items = @[ navItem ];
        [self.view addSubview:navbar];
    }else{
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = btnNavDone;
    }
}

-(IBAction)OnFinishConnectAPI:(id)sender{
     if(self.navigationController == nil){
         if(self.origin_type == RDPScanCard){
             UIViewController *presentingView = self.presentingViewController;
             [self dismissViewControllerAnimated:NO completion:^{
                 [presentingView dismissViewControllerAnimated:YES completion:nil];
             }];
         }
        [self dismissViewControllerAnimated:true completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:true];
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIViewControllerExtension dismissPopUp:self];
    if([webView.request.URL.absoluteString containsString:self.return_url]) {
        if(self.delegate && [self.delegate respondsToSelector:@selector(returnUrlDidLoad)])
            [self.delegate returnUrlDidLoad];
    }
}

- (void) webViewDidStartLoad:(UIWebView *)webView {
    //Duplicate Show
    //[UIViewControllerExtension showLoadingPopUp:self];
}


- (void) viewWillAppear:(BOOL)animated {
    [self initRDPConnectAPIWrapper];
    self.connectAPIWrapper.internalDelegate = self;
    [self.connectAPIWrapper startRequest];
    [UIViewControllerExtension showLoadingPopUp:self];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.connectAPIWrapper checkAmountValidation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated{
    webView = nil;
    btnNavDone = nil;
    [self.connectAPIWrapper consentScreenDidDissapear];
}

- (void) onWebViewContentLoaded:(NSString*) content {
    NSString* urlString = RDP_CAPI_DEV_URL;;
    if([Util isProduction])
        urlString = RDP_CAPI_PRODUCTION_URL;
    NSURL* url = [[NSURL alloc]initWithString:urlString];
    [webView loadHTMLString:content baseURL:url];
    //Duplicate Dismiss and overlap withshouldStarLoad 
   // [UIViewControllerExtension dismissPopUp:self];
}

- (void) onRequestFailed {
    [UIViewControllerExtension dismissPopUpUsingDispatch:self completion:^{
        if(self.navigationController == nil){
            [self dismissViewControllerAnimated:true completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:true];
        }
    }];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"trying to load %@", request.URL.absoluteString);
    btnNavDone.enabled = YES;
    if([request.URL.absoluteString containsString:self.connectAPIWrapper.return_url]) {
        NSDictionary* returnParams = [ParameterExtractor extractParamFromURL:request.URL.absoluteString];
        NSString* result = [returnParams objectForKey:@"result"];
        if(self.delegate && [self.delegate respondsToSelector:@selector(returnUrlWillLoad)])
            [self.delegate returnUrlWillLoad];
        if([result isEqualToString:@"paid"]) {
            [self.connectAPIWrapper signatureWillValidate];
            if([SignatureUtil isSignatureValidatedWithQueryString:request.URL.absoluteString andSecretKey:self.connectAPIWrapper.secret_key]) {
                [self.connectAPIWrapper signatureDidValidateWithParam:returnParams];
                [self.connectAPIWrapper onRequestFinishedWithParams:returnParams];
            }
            else {
                if([self.webView isLoading])
                    [UIViewControllerExtension dismissPopUp:self];
                [self.connectAPIWrapper onErrorWith:@"Signature sent from server is invalid"];
                [self dismissViewControllerAnimated:YES completion:nil];
                return NO;
            }
            btnNavDone.enabled = YES;
            return YES;
        }
        else {
            int errorCode = (int) [[returnParams objectForKey:@"error_code"] integerValue];
            [self.connectAPIWrapper onRequestRejectedWithParams:returnParams andErrorCode:errorCode];
        }
        if([self.connectAPIWrapper shouldDismissConsentScreen]) {
            [self.navigationController popViewControllerAnimated:true];
        }
    }
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if(error.code == 999 || error.code == -999)
        return;
    [self.connectAPIWrapper onErrorWith:error.description];
    if([self.webView isLoading])
        [UIViewControllerExtension dismissPopUp:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
