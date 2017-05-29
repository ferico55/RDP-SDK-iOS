//
//  UIViewControllerExtension.m
//  RDPSDK
//
//  Created by Ricky Putra Harlim on 5/4/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//

#import "UIViewControllerExtension.h"

@implementation UIViewControllerExtension

//@synthesize loadingPopUp,indicator;
UIAlertController* loadingPopUp;
UIActivityIndicatorView* indicator;
+ (void)showLoadingPopUp:(UIViewController*) delegate{
    
    loadingPopUp = [UIAlertController alertControllerWithTitle:nil message:@"Please wait\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
    CGRect frame = loadingPopUp.view.bounds;
    frame.origin.y += 20;
    indicator = [[UIActivityIndicatorView alloc] initWithFrame:frame];
    indicator.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [indicator startAnimating];
    [loadingPopUp.view addSubview:indicator];
    [delegate presentViewController:loadingPopUp animated:NO completion:nil];
}


+ (void)dismissPopUp:(UIViewController *)delegate{
    [delegate dismissViewControllerAnimated:YES completion:nil];
    loadingPopUp = nil;
    indicator = nil;
}


+ (void)dismissPopUpUsingDispatch:(UIViewController *)delegate completion: (void (^ __nullable)(void))completion{
    dispatch_async(dispatch_get_main_queue(), ^{
        [delegate dismissViewControllerAnimated:YES completion:completion];
        loadingPopUp = nil;
        indicator = nil;
    });
}


+ (void)showViewControllerPresentWithDispatch:(UIViewController*) delegate withviewController:(UIViewController *) viewController{
    dispatch_async(dispatch_get_main_queue(), ^{
        [delegate presentViewController:viewController animated:YES completion:nil];
    });
}

@end
