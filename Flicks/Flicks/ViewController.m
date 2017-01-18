//
//  ViewController.m
//  Flicks
//
//  Created by Shruthi Ramesh on 1/12/17.
//  Copyright © 2017 Flurry. All rights reserved.
//

#import "ViewController.h"
#import "MovieFetcher.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *moviesTableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.moviesTableView.delegate = self;
    self.moviesTableView.dataSource = self;
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(loadMovies) forControlEvents:UIControlEventValueChanged];
    [self.moviesTableView addSubview:self.refreshControl];
    self.tabBarItem.image = [UIImage imageNamed:@"playback_play_icon&32.png"];
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
    
    [[MovieFetcher sharedInstance] fetchNowPlaying:^(NSArray *movies, NSError *error) {
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
