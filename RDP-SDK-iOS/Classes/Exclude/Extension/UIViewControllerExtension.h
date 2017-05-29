//
//  UIViewControllerExtension.h
//  RDPSDK
//
//  Created by Ricky Putra Harlim on 5/4/17.
//  Copyright © 2017 d'Amigos. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIViewControllerExtension : UIViewController
@property(nonatomic, strong) UIAlertController* loadingPopUp;
@property(nonatomic,strong) UIActivityIndicatorView* indicator;
+ (void)showLoadingPopUp:(UIViewController*) delegate;
+ (void)dismissPopUp:(UIViewController*)delegate;
+ (void)dismissPopUpUsingDispatch:(UIViewController *)delegete  completion: (void (^ __nullable)(void))completion;
+ (void)showViewControllerPresentWithDispatch:(UIViewController*) delegate withviewController:(UIViewController *)viewController;
@end

