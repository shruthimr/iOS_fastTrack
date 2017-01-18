//
//  MovieItem.m
//  Flicks
//
//  Created by Shruthi Ramesh on 1/12/17.
//  Copyright © 2017 Flurry. All rights reserved.
//

#import "MovieItem.h"

@implementation MovieItem
- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.poster_path         = dictionary[@"poster_path"];
        self.adult               = [dictionary[@"adult"] boolValue];
        self.overview            = dictionary[@"overview"];
        self.release_date        = dictionary[@"release_date"];
        self.genre_ids           = dictionary[@"genre_ids"];
        self.movieId             = [dictionary[@"id"] intValue];
        self.original_title      = dictionary[@"original_title"];
        self.original_language   = dictionary[@"original_language"];
        self.title               = dictionary[@"title"];
        self.backdrop_path       = dictionary[@"backdrop_path"];
        self.popularity          = [dictionary[@"popularity"] intValue];
        self.vote_count          = [dictionary[@"vote_count"] intValue];
        self.video               = [dictionary[@"video"] boolValue];
        self.vote_average        = [dictionary[@"vote_average"] intValue];
        
    }
    return self;
}

- (NSURL*) getURLForImage:(movieImage)image withResolution:(movieResolution)resolution
{
    switch (image) {
        case BACKDROP:
            return [NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w%d%@",resolution, self.backdrop_path]];
        case POSTER:
        default:
            return [NSURL URLWithString:[NSString stringWithFormat:@"https://image.tmdb.org/t/p/w%d%@",resolution, self.poster_path]];
    }
}

@end
