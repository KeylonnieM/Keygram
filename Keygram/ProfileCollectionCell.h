//
//  ProfileCollectionCell.h
//  Keygram
//
//  Created by Keylonnie Miller on 7/13/18.
//  Copyright © 2018 Keylonnie Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseUI.h"
#import "Parse.h"
#import "Post.h"

@interface ProfileCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PFImageView *cellImage;
@property (nonatomic, strong) Post *post;

@end
