//
//  MovieItem.h
//  Flicks
//
//  Created by Shruthi Ramesh on 1/12/17.
//  Copyright © 2017 Flurry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    LOW = 45,
    HIGH = 342
}movieResolution;

typedef enum
{
    POSTER = 1,
    BACKDROP = 2
}movieImage;

@interface MovieItem : NSObject

@property (nonatomic, strong) NSString *poster_path;
@property (nonatomic, assign) BOOL adult;
@property (nonatomic, strong) NSString *overview;
@property (nonatomic, strong) NSString *release_date;
@property (nonatomic, strong) NSArray<NSNumber*> *genre_ids;
@property (nonatomic, assign) int movieId;
@property (nonatomic, strong) NSString *original_title;
@property (nonatomic, strong) NSString *original_language;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *backdrop_path;
@property (nonatomic, assign) int popularity;
@property (nonatomic, assign) int vote_count;
@property (nonatomic, assign) BOOL video;
@property (nonatomic, assign) int vote_average;

- (NSURL*) getURLForImage:(movieImage)image withResolution:(movieResolution)resolution;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
