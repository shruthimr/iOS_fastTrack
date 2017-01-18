//
//  MovieCell.h
//  Flicks
//
//  Created by Shruthi Ramesh on 1/12/17.
//  Copyright © 2017 Flurry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *movieSummary;
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;

//- (void)setupWithMovieItem:(MovieItem *)movieItem atIndexPath:(NSIndexPath*)indexPath ;
@end
