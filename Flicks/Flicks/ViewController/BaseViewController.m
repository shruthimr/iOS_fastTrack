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
#import "MovieDetailsViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+AFNetworking.h"

@interface BaseViewController () 
@property (strong, nonatomic) NSIndexPath* selectedPath;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
}

@end
