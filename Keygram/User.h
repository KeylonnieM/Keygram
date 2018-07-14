//
//  User.h
//  Keygram
//
//  Created by Keylonnie Miller on 7/13/18.
//  Copyright © 2018 Keylonnie Miller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface User : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *bio;
@property (nonatomic, strong) PFFile *profileImage;


+ (void) postUserInfo: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )bio withOtherCaption:( NSString * _Nullable )name withCompletion: (PFBooleanResultBlock  _Nullable)completion;
@end
