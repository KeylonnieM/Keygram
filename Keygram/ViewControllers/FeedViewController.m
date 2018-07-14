//
//  FeedViewController.m
//  Keygram
//
//  Created by Keylonnie Miller on 7/9/18.
//  Copyright © 2018 Keylonnie Miller. All rights reserved.
//

#import "FeedViewController.h"
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Parse.h"
#import "Post.h"
#import "PostCell.h"
#import "DateTools.h"
#import "DetailsViewController.h"

@interface FeedViewController ()<ComposeViewControllerDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *postFeed;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //Initialize postFeed
    self.postFeed = [[NSArray alloc]init];
    
    //Have data in timeline on first view
    [self fetchPosts];
    
    //Initialize pull down to refresh control
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    //Linking pull down action to refresh control
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    //Adding refresh information to the tableview
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    //Setup Nav Title
    //[self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:@"LobsterTwo" size:21]}];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fetchPosts {
// construct PFQuery
PFQuery *postQuery = [Post query];
[postQuery orderByDescending:@"createdAt"];
[postQuery includeKey:@"author"];
postQuery.limit = 10;
    
// fetch data asynchronously
[postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
    if (posts) {
        // do something with the data fetched
        self.postFeed = posts;
        self.isMoreDataLoading = false;
        [self.tableView reloadData];
    }
    else {
        // handle error
        NSLog(@"%@", error.localizedDescription);
    }
}];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self fetchPosts];
    // Tell the refreshControl to stop spinning
    [refreshControl endRefreshing];
}

- (IBAction)tappedLogoutButton:(UIBarButtonItem *)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        [self logoutAlert];
        // PFUser.current() will now be nil
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        appDelegate.window.rootViewController = loginViewController;
    }];
    
}

- (void)logoutAlert {
    //initialize alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Logged Out"
            message:@"You have been logged out successfully."
            preferredStyle:(UIAlertControllerStyleAlert)];
    
    // create an OK action button for alert
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         // handle response here.
                                                     }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    
    //Show the view controller
    [self presentViewController:alert animated:YES completion:^{
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    
    cell.post = self.postFeed[indexPath.row];
    
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postFeed.count;
}

-(void)loadMoreData{
    [self fetchPosts];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(!self.isMoreDataLoading){
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            self.isMoreDataLoading = true;
            [self loadMoreData];
        }
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        if ([segue.identifier isEqual: @"MoveToDetails"]){
            PostCell *tappedPost = sender;
            Post *post = tappedPost.post;
            //NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedPost];
            DetailsViewController *detailsViewController = [segue destinationViewController];
            detailsViewController.post = post;
        }
        else {
            ComposeViewController *composeController = [segue destinationViewController];
            composeController.delegate = self;
        }
}

@end
