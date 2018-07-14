//
//  ProfileViewController.h
//  Keygram
//
//  Created by Keylonnie Miller on 7/10/18.
//  Copyright © 2018 Keylonnie Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseUI.h"

@interface ProfileViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet PFImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;
@property (weak, nonatomic) IBOutlet UILabel *profileBioLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *postGrid;
@property (nonatomic, weak) PFUser *user;

@end
