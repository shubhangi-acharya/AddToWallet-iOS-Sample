//
//  ViewController.m
//  ApplePassBook-Sample
//
//  Created by Shubhangi Pandya on 04/05/16.
//  Copyright © 2016 Shubhangi Pandya. All rights reserved.
//

#import "ViewController.h"
#import <PassKit/PassKit.h>

@interface ViewController () <PKAddPassesViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addToPassBook:(id)sender {
    
    NSURL *url = [[NSURL alloc] initWithString:@"https://q.pass.is/99SEE7BYA6NU"]; // This is just a sample pass used for testing purpose which was available on internet. Cannot use this commercially.
    if (![PKAddPassesViewController canAddPasses]) {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Warning"
                                              message:@"Cannot add Pass"
                                              preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"OK action");
                                   }];
        
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    } else {
        NSData *passData = [NSData dataWithContentsOfURL:url];
        
        NSError* error = nil;
        PKPass *newPass = [[PKPass alloc] initWithData:passData error:&error];
        PKPassLibrary *passLibrary = [[PKPassLibrary alloc] init];
        if ([passLibrary containsPass:newPass]) {
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Warning"
                                                  message:@"Pass already exist."
                                                  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"OK action");
                                       }];
            
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
            return;

        }
        else if (!error) {
            PKAddPassesViewController *passController = [[PKAddPassesViewController alloc] initWithPass:newPass];
            passController.delegate = self;
            [self presentViewController:passController animated:YES completion:nil];
        } else {
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Error"
                                                  message:@"Unable to Add Pass"
                                                  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"OK action");
                                       }];
            
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    }
    
}

@end
