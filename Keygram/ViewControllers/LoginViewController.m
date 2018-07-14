//
//  LoginViewController.m
//  Keygram
//
//  Created by Keylonnie Miller on 7/9/18.
//  Copyright © 2018 Keylonnie Miller. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.testView.bounds;
    (void)(gradient.colors = @[(id)[UIColor whiteColor].CGColor,(id)[UIColor purpleColor].CGColor]);
    [self.testView.layer addSublayer:gradient];*/
}

- (void)checkTextFieldsAlert {
    //initialize alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Problem"
                                                                   message:@"Either username or password is empty"
                                                            preferredStyle:(UIAlertControllerStyleAlert)];
    
    // create an OK action button for alert
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         // handle response here.
                                                     }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    
    //Show the view controller
    [self presentViewController:alert animated:YES completion:^{
    }];
}

- (void)errorWithLogin {
    //initialize alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login Error"
                                                                   message:@"There was a problem logging in. Please try again."
                                                            preferredStyle:(UIAlertControllerStyleAlert)];
    
    // create an OK action button for alert
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         // handle response here.
                                                     }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    
    //Show the view controller
    [self presentViewController:alert animated:YES completion:^{
    }];
}

- (void)errorWithSignUp {
    //initialize alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sign Up Error"
                message:@"There was a problem signing up. Please try again."
                preferredStyle:(UIAlertControllerStyleAlert)];
    
    // create an OK action button for alert
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         // handle response here.
                                                     }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    
    //Show the view controller
    [self presentViewController:alert animated:YES completion:^{
    }];
}


- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameText.text;
    //newUser.email = self.emailField.text;
    newUser.password = self.passwordText.text;
    
    if ([self.usernameText.text isEqualToString: @""] || [self.passwordText.text isEqualToString: @""]) {
        [self checkTextFieldsAlert];
    }
    else {
        // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
                [self errorWithSignUp];
            } else {
                NSLog(@"User registered successfully");
                [self performSegueWithIdentifier:@"MoveToFeed" sender:nil];
                //////// manually segue to logged in view
            }
        }];
    }
}

- (void)loginUser {
    NSString *username = self.usernameText.text;
    NSString *password = self.passwordText.text;
    
    if ([self.usernameText.text isEqualToString:@""] || [self.passwordText.text isEqualToString:@""]) {
        [self checkTextFieldsAlert];
    }
    else {
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                NSLog(@"User log in failed: %@", error.localizedDescription);
                [self errorWithLogin];
            } else {
                NSLog(@"User logged in successfully");
                // display chat view controller after successful login
                [self performSegueWithIdentifier:@"MoveToFeed" sender:nil];
                
            }
        }];
    }
}

- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    //Dismissing the keyboard
    [self.overallView endEditing:YES];
}


- (IBAction)tappedSignUp:(UIButton *)sender {
    [self registerUser];
}

- (IBAction)tappedLogin:(id)sender {
    [self loginUser];
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
