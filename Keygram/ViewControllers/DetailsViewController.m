//
//  DetailsViewController.m
//  Keygram
//
//  Created by Keylonnie Miller on 7/9/18.
//  Copyright © 2018 Keylonnie Miller. All rights reserved.
//

#import "DetailsViewController.h"
#import "DateTools.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.usernameLabel.text = self.post.author.username;
    self.captionLabel.text = self.post.caption;
    
    //Configuring date
    NSString *timeAgoDate = [NSDate shortTimeAgoSinceDate:self.post.createdAt];
    // Convert Date to String
    self.datePostedLabel.text = timeAgoDate;
    
    self.postedImage.file = self.post.image;
    [self.postedImage loadInBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
