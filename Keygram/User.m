//
//  User.m
//  Keygram
//
//  Created by Keylonnie Miller on 7/13/18.
//  Copyright © 2018 Keylonnie Miller. All rights reserved.
//

#import "User.h"


@implementation User

@dynamic profileImage;
@dynamic bio;
@dynamic name;
@dynamic username;

+ (nonnull NSString *)parseClassName {
    return @"User";
}

+ (void) postUserInfo: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )bio withOtherCaption:( NSString * _Nullable )name withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    PFUser *user = [PFUser currentUser];
    user[@"profileImage"] = [self getPFFileFromImage:image];
    user.username = PFUser.currentUser.username;
    user[@"bio"] = bio;
    user[@"name"] = name;

    [user saveInBackgroundWithBlock: completion];
    
}

+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFile fileWithName:@"image.png" data:imageData];
}

@end
