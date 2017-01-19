//
//  BaseViewController.h
//  Flicks
//
//  Created by Shruthi Ramesh on 1/18/17.
//  Copyright © 2017 Flurry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MovieItem.h"
#import "MovieCell.h"
#import "MovieDetailsViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+AFNetworking.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface BaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) NSArray<MovieItem*>* movieArray;
@property (strong,nonatomic) UIRefreshControl* refreshControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *layoutControl;
@property (weak, nonatomic) IBOutlet UITableView *moviesTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end
