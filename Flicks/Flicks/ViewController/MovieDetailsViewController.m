//
//  MovieDetailsViewController.m
//  Flicks
//
//  Created by Shruthi Ramesh on 1/13/17.
//  Copyright © 2017 Flurry. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+AFNetworking.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@implementation MovieDetailsViewController
@synthesize movie =_movie;

-(void)viewDidLoad
{
    NSURL* url = [self.movie getURLForImage:POSTER withResolution:HIGH];
    [self.backdropImageView setImageWithURL:url];

    self.tabBarController.tabBar.hidden = YES;
    
    [self buildScrollView];
}

-(void)buildScrollView
{
    self.titleLabel.text = self.movie.title;
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.titleLabel sizeToFit];

//    self.dateLabel.text = self.movie.release_date;
    self.summaryLabel.text = self.movie.overview;
    self.summaryLabel.numberOfLines = 20;
    [self.summaryLabel sizeToFit];
    self.summaryLabel.lineBreakMode = NSLineBreakByWordWrapping;
}


-(IBAction)done:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([self.delegate respondsToSelector:@selector(doneWithDetailsView)])      {
        [self.delegate performSelectorOnMainThread:@selector(doneWithDetailsView) withObject:nil waitUntilDone:NO];
    }
}


@end
