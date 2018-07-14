//
//  PostCell.m
//  Keygram
//
//  Created by Keylonnie Miller on 7/9/18.
//  Copyright © 2018 Keylonnie Miller. All rights reserved.
//

#import "PostCell.h"
#import "Post.h"
#import "DateTools.h"
#import "User.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(Post *)post{
    _post = post;
    
    self.usernameBottomLabel.text = self.post.author.username;
    self.captionText.text = self.post.caption;
    
    self.likeLabel.text = [self.post.likeCount stringValue];
    
    //Configuring date
    NSString *timeAgoDate = [NSDate shortTimeAgoSinceDate:self.post.createdAt];
    // Convert Date to String
    self.dateLabel.text = timeAgoDate;
    
    //Loading the profile image
    PFUser *user = self.post.author;
    self.profileImage.file = user[@"profileImage"];
    [self.profileImage loadInBackground];
    
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2;
    self.profileImage.clipsToBounds = YES;
    
    //Loading the main post image
    self.photoImageView.file = self.post.image;
    [self.photoImageView loadInBackground];
 
}

- (IBAction)tappedLikeButton:(UIButton *)sender {
    if (self.post.likedPost != YES){
        self.post.likedPost = YES;
        NSInteger myInteger = [self.post.likeCount integerValue];
        myInteger+=1;
        NSNumber *final = [NSNumber numberWithInteger:myInteger];
        self.post.likeCount = final;
        self.likeLabel.text = [final stringValue];
        self.likeButton.selected = self.post.likedPost;
    }
    else {
        self.post.likedPost = NO;
        NSInteger myInteger = [self.post.likeCount integerValue];
        myInteger-=1;
        NSNumber *final = [NSNumber numberWithInteger:myInteger];
        self.post.likeCount = final;
        self.likeLabel.text = [final stringValue];
        self.likeButton.selected = self.post.likedPost;
    }
}

- (IBAction)tappedCommentButton:(UIButton *)sender {
}


@end
