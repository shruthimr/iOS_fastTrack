//
//  BaseViewController.m
//  Flicks
//
//  Created by Shruthi Ramesh on 1/18/17.
//  Copyright © 2017 Flurry. All rights reserved.
//

#import "BaseViewController.h"
#import "MovieFetcher.h"
#import "MovieItem.h"
#import "MovieCell.h"
#import "MovieGridCell.h"
#import "MovieDetailsViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+AFNetworking.h"

@interface BaseViewController () 
@property (strong, nonatomic) NSIndexPath* selectedPath;
@property (nonatomic,strong) NSString *layoutType;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.moviesTableView.delegate = self;
    self.moviesTableView.dataSource = self;
    
    // Grid View
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.layoutType = @"list";
    [self.layoutControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)segmentAction:(UISegmentedControl *)segment {
    if(segment.selectedSegmentIndex == 0) {
        self.layoutType = @"list";
        [self.moviesTableView setHidden:NO];
        [self.collectionView setHidden:YES];
        [self.moviesTableView addSubview:self.refreshControl];
        [self reloadData];
    }else if(segment.selectedSegmentIndex == 1){
        self.layoutType = @"grid";
        [self.moviesTableView setHidden:YES];
        [self.collectionView setHidden:NO];
        [self.collectionView addSubview:self.refreshControl];
        [self reloadData];
    }
}

#pragma UITableViewDataSource methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movieArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCell* cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MovieItem* movieItem = [self.movieArray objectAtIndex:indexPath.row];
    cell.movieTitle.text = movieItem.title;
    cell.movieSummary.text = movieItem.overview;
    NSURL* url = [movieItem getURLForImage:POSTER withResolution:HIGH];
    [cell.movieImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Icon-60@2x.png"]];
    
    return cell;
}

#pragma UITableViewDelegate methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170.0f;
}

- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    self.selectedPath = indexPath;
    [self performSegueWithIdentifier:@"Details" sender:self];
    return  indexPath;
}


#pragma Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Details"])
    {
        MovieDetailsViewController *movieDetailsViewController = [segue destinationViewController];
        movieDetailsViewController.hidesBottomBarWhenPushed = YES;
        movieDetailsViewController.delegate = self;
        movieDetailsViewController.movie = [self.movieArray objectAtIndex:self.selectedPath.row];
        movieDetailsViewController.tabBarController.tabBar.hidden = YES;
        
    }
    NSIndexPath *indexPath;
    if ([self.layoutType isEqualToString:@"grid"]) {
        UICollectionViewCell *cell = sender;
        indexPath = [self.collectionView indexPathForCell:cell];
    } else {
        UITableViewCell *cell = sender;
        indexPath = [self.moviesTableView indexPathForCell:cell];
    }
}

- (void)reloadData {
    if ([self.layoutType isEqualToString:@"grid"]) {
        [self.collectionView reloadData];
    } else {
        [self.moviesTableView reloadData];
    }
}


#pragma collective Delegates
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movieArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieGridCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieGridCell" forIndexPath:indexPath];
    MovieItem* movieItem = [self.movieArray objectAtIndex:indexPath.row];
    NSURL* url = [movieItem getURLForImage:POSTER withResolution:HIGH];
    [cell.gridPosterView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Icon-60@2x.png"]];
    
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath;
{
    self.selectedPath = indexPath;
//    [self performSegueWithIdentifier:@"Details" sender:self];
    return;
}
@end
