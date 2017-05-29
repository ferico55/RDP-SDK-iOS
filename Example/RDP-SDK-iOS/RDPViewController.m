//
//  RDPViewController.m
//  RDP-SDK-iOS
//
//  Created by ferico55 on 05/28/2017.
//  Copyright (c) 2017 ferico55. All rights reserved.
//

#import "RDPViewController.h"
#import <RDP_SDK_iOS/RDPDirectAPI.h>

@interface RDPViewController ()

@end

@implementation RDPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    RDPDirectAPI *directAPI = [[RDPDirectAPI alloc]initWithDelegate:self];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
