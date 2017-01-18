//
//  MovieFetcher.h
//  Flicks
//
//  Created by Shruthi Ramesh on 1/12/17.
//  Copyright © 2017 Flurry. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^MovieFetcherCallback)(NSArray *movies, NSError* error);

@interface MovieFetcher : NSObject
+ (id)sharedInstance ;
-(void) fetchTopRated:(MovieFetcherCallback)callback;
-(void) fetchNowPlaying:(MovieFetcherCallback)callback;

@end
