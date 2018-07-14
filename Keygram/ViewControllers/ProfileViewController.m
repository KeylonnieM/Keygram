//
//  ProfileViewController.m
//  Keygram
//
//  Created by Keylonnie Miller on 7/10/18.
//  Copyright © 2018 Keylonnie Miller. All rights reserved.
//

#import "ProfileViewController.h"
#import "Post.h"
#import "Parse.h"
#import "ParseUI.h"
#import "User.h"
#import "ProfileViewController.h"
#import "ProfileCollectionCell.h"

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *profileFeed;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.postGrid.delegate = self;
    self.postGrid.dataSource = self;
    
    //Initialize array
    self.profileFeed = [[NSArray alloc]init];

    //Setting the view controller with data
    PFUser * user = PFUser.currentUser;
    self.usernameLabel.text = user[@"name"];
    self.profileBioLabel.text = user[@"bio"];
    
    //Load profile Image
    self.profileImage.file = user[@"profileImage"];
    [self.profileImage loadInBackground];
    
    //Crop profile image to a circle
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2;
    self.profileImage.clipsToBounds = YES;
    
    //Get post for grid
    [self fetchPosts];
    
    //Grid layout
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.postGrid.collectionViewLayout;
    
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    
    CGFloat postersPerLine = 3;
    CGFloat itemWidth = (self.postGrid.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine - 1)) / postersPerLine;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
}

- (void) fetchPosts {
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery whereKey:@"author" equalTo:[PFUser currentUser]];
    postQuery.limit = 20;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            self.profileFeed = posts;
            [self.postGrid reloadData];
        }
        else {
            // handle error
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfileCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCell" forIndexPath:indexPath];
    
    cell.post = self.profileFeed[indexPath.item];
    [cell setPost:self.profileFeed[indexPath.item]];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.profileFeed.count;
}

@end
