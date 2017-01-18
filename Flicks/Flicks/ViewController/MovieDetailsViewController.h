//
//  MovieDetailsViewController.h
//  Flicks
//
//  Created by Shruthi Ramesh on 1/13/17.
//  Copyright © 2017 Flurry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MovieItem.h"

@interface MovieDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;
@property (weak, nonatomic) IBOutlet UIScrollView *infoScrollView;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backdropImageView;
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong) MovieItem* movie;
@end
