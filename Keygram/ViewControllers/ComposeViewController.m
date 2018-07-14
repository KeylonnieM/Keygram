//
//  ComposeViewController.m
//  Keygram
//
//  Created by Keylonnie Miller on 7/9/18.
//  Copyright © 2018 Keylonnie Miller. All rights reserved.
//

#import "ComposeViewController.h"
#import "Post.h"
#import "FeedViewController.h"
#import "TabBarController.h"
#import "MBProgressHUD.h"

@interface ComposeViewController () < UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Setting up the camera/image picker controller
    [self cameraViewPresented];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)cameraViewPresented {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
}

- (void) cameraRollViewPresented {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info {
 // Get the image captured by the UIImagePickerController
 UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
 UIImage *editedImage = info[UIImagePickerControllerEditedImage];
 // Do something with the images
    editedImage = [self resizeImage:originalImage withSize:CGSizeMake(350, 295)];
   self.postedImage.image = editedImage;
// Dismiss UIImagePickerController to go back to your original view controller
 [self dismissViewControllerAnimated:YES completion:nil];
 }

- (IBAction)tappedPostButton:(UIBarButtonItem *)sender {
    // Display HUD right before the request is made
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
 [Post postUserImage:self.postedImage.image withCaption:self.captionText.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
     if(succeeded){
         NSLog(@"Posting was successful!");
         //[MBProgressHUD hideHUDForView:self.view animated:YES];
         //Transition back to home page
     }
     else {
         NSLog(@"Error posting :(");
     }
 }];
    self.tabBarController.selectedIndex = 0;
    [self.delegate fetchPosts];
    self.postedImage.image = nil;
}

- (IBAction)tappedCancelButton:(UIBarButtonItem *)sender {
    self.tabBarController.selectedIndex = 0;
}


- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
 UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
 
 resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
 resizeImageView.image = image;
 
 UIGraphicsBeginImageContext(size);
 [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
 UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
 
 return newImage;
}


@end
