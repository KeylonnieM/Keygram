//
//  ComposeViewController.h
//  Keygram
//
//  Created by Keylonnie Miller on 7/9/18.
//  Copyright © 2018 Keylonnie Miller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedViewController.h"

@protocol ComposeViewControllerDelegate

- (void)fetchPosts;

@end

@interface ComposeViewController : UIViewController < ComposeViewControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *captionText;
@property (weak, nonatomic) IBOutlet UIImageView *postedImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *postButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;


@end
