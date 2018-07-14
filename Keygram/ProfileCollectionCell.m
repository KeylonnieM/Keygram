//
//  ProfileCollectionCell.m
//  Keygram
//
//  Created by Keylonnie Miller on 7/13/18.
//  Copyright © 2018 Keylonnie Miller. All rights reserved.
//

#import "ProfileCollectionCell.h"

@implementation ProfileCollectionCell

- (void)setPost:(Post *)post {
    _post = post;
    
    //Loading the cell image
    //PFUser *user = [PFUser currentUser];
    self.cellImage.file = self.post.image;
    [self.cellImage loadInBackground];
}


@end
