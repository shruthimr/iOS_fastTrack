//
//  TopRatedViewController.m
//  Flicks
//
//  Created by Shruthi Ramesh on 1/18/17.
//  Copyright © 2017 Flurry. All rights reserved.
//

#import "TopRatedViewController.h"
#import "MovieFetcher.h"


@interface TopRatedViewController ()
@property (weak, nonatomic) IBOutlet UITableView *moviesTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation TopRatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self.moviesTableView registerClass:MovieCell.self forCellReuseIdentifier:@"movieCell"]; //Not required on storyboard cells
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(loadMovies) forControlEvents:UIControlEventValueChanged];
    [self.moviesTableView addSubview:self.refreshControl];
    [self performSelectorInBackground:@selector(loadMovies) withObject:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadMovies
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    });
    
    [[MovieFetcher sharedInstance] fetchTopRated:^(NSArray *movies, NSError *error) {
        self.movieArray = [movies copy];
        
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           if (error) {
                               UIAlertController * alert=   [UIAlertController
                                                             alertControllerWithTitle:@""
                                                             message:@"Network Error!"
                                                             preferredStyle:UIAlertControllerStyleAlert];
                               
                               [self presentViewController:alert animated:YES completion:nil];
                               
                           }
                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                           [self.moviesTableView reloadData];
                           [self.refreshControl endRefreshing];
                       });
    }];
}




@end

