//
//  PostCell.h
//  Keygram
//
//  Created by Keylonnie Miller on 7/9/18.
//  Copyright © 2018 Keylonnie Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "ParseUI.h"

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usernameTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet PFImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameBottomLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionText;
@property (nonatomic, strong) Post *post;
@end
