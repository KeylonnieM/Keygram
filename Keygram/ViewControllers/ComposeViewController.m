//
//  ComposeViewController.m
//  Keygram
//
//  Created by Keylonnie Miller on 7/9/18.
//  Copyright © 2018 Keylonnie Miller. All rights reserved.
//

#import "ComposeViewController.h"
#import "Post.h"

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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
 // Get the image captured by the UIImagePickerController
 UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
 UIImage *editedImage = info[UIImagePickerControllerEditedImage];
 // Do something with the images
    self.postedImage.image = originalImage;
// Dismiss UIImagePickerController to go back to your original view controller
 [self dismissViewControllerAnimated:YES completion:nil];
 }

- (IBAction)tappedPostButton:(UIBarButtonItem *)sender {
 [Post postUserImage:self.postedImage.image withCaption:self.captionText.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
     if(succeeded){
         NSLog(@"Posting was successful!");
     }
     else {
         NSLog(@"Error posting :(");
     }
 }];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
