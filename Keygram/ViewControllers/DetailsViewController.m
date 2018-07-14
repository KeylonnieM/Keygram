//
//  DetailsViewController.m
//  Keygram
//
//  Created by Keylonnie Miller on 7/9/18.
//  Copyright © 2018 Keylonnie Miller. All rights reserved.
//

#import "DetailsViewController.h"
#import "DateTools.h"
#import "ParseUI.h"
#import "Parse.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.usernameLabel.text = self.post.author.username;
    self.captionLabel.text = self.post.caption;
    self.likeButton.selected = self.post.likedPost;
    
    //Loading the profile image
    PFUser *user = self.post.author;
    self.profileImage.file = user[@"profileImage"];
    [self.profileImage loadInBackground];
    
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2;
    self.profileImage.clipsToBounds = YES;
    
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


- (IBAction)tappedLikeButton:(UIButton *)sender {
    if (self.post.likedPost != YES){
        self.post.likedPost = YES;
        NSInteger myInteger = [self.post.likeCount integerValue];
        myInteger+=1;
        NSNumber *final = [NSNumber numberWithInteger:myInteger];
        self.post.likeCount = final;
       self.likeButton.selected = self.post.likedPost;
    }
    else {
        self.post.likedPost = NO;
        NSInteger myInteger = [self.post.likeCount integerValue];
        myInteger-=1;
        NSNumber *final = [NSNumber numberWithInteger:myInteger];
        self.post.likeCount = final;
        self.likeButton.selected = self.post.likedPost;
    }
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
