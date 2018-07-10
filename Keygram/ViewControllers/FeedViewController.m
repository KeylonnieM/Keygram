//
//  FeedViewController.m
//  Keygram
//
//  Created by Keylonnie Miller on 7/9/18.
//  Copyright © 2018 Keylonnie Miller. All rights reserved.
//

#import "FeedViewController.h"
#import "Parse.h"

@interface FeedViewController () 

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.tableView.delegate = self;
   // self.tableView.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tappedLogoutButton:(UIBarButtonItem *)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        [self performSegueWithIdentifier:@"MoveToLogin" sender:nil];
    }];
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
