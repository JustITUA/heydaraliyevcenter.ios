//
//  hcViewController.m
//  heydaraliyevcenter
//
//  Created by Anton Rogachevskiy on 6/11/14.
//  Copyright (c) 2014 JustIT. All rights reserved.
//

#import "hcViewController.h"

@interface hcViewController ()

@end

@implementation hcViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)networkTestPressed:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[hcAPIClient sharedClient] testWithCompletion:^(BOOL success, NSString * message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (success) {
            UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [errorView show];
        }
        else
        {
            UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(message, nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [errorView show];
        }
    }];
    
}


@end
