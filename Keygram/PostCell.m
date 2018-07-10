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
    
    self.usernameTopLabel.text = self.post.author.username;
    self.usernameBottomLabel.text = self.post.author.username;
    self.captionText.text = self.post.caption;
    
    //Configuring date
    NSString *timeAgoDate = [NSDate shortTimeAgoSinceDate:self.post.createdAt];
    // Convert Date to String
    self.dateLabel.text = timeAgoDate;
    
    self.photoImageView.file = self.post.image;
    [self.photoImageView loadInBackground];
 
}

@end
