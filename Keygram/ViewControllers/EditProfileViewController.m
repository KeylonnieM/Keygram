//
//  EditProfileViewController.m
//  Keygram
//
//  Created by Keylonnie Miller on 7/13/18.
//  Copyright © 2018 Keylonnie Miller. All rights reserved.
//

#import "EditProfileViewController.h"
#import "User.h"

@interface EditProfileViewController () < UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Setting up the camera/image picker controller
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tappedImage:(UITapGestureRecognizer *)sender {
    [self cameraRollViewPresented];
}

- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    //Dismissing the keyboard
    [self.overallView endEditing:YES];
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
    editedImage = [self resizeImage:originalImage withSize:CGSizeMake(101, 93)];
    self.profileImage.image = editedImage;
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tappedEditButton:(UIBarButtonItem *)sender {    // Display HUD right before the request is made
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [User postUserInfo:self.profileImage.image withCaption:self.bioText.text withOtherCaption:self.presentedName.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded){
            NSLog(@"Editing was successful!");
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            //Transition back to home page
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else {
            NSLog(@"Error editing :(");
        }
    }];
}

- (IBAction)tappedCancelButton:(UIBarButtonItem *)sender {
[self dismissViewControllerAnimated:YES completion:nil];
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


