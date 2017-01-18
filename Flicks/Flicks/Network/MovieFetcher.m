//
//  MovieFetcher.m
//  Flicks
//
//  Created by Shruthi Ramesh on 1/12/17.
//  Copyright © 2017 Flurry. All rights reserved.
//

#import "MovieFetcher.h"
#import "MovieItem.h"

@implementation MovieFetcher

+ (id)sharedInstance {
    static MovieFetcher *mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[self alloc] init];
    });
    return mgr;
}


- (id)init {
    if (self = [super init]) {

    }
    return self;
}

-(void) fetchTopRated:(MovieFetcherCallback)callback
{
    NSString *apiKey = @"f5408bb6365a69cb9fb8fadf33040c7a";
    NSString *urlString =
    [@"https://api.themoviedb.org/3/movie/top_rated?api_key=" stringByAppendingString:apiKey];
    [self fetchMoviesWithURL:urlString callback:callback];
}
-(void) fetchNowPlaying:(MovieFetcherCallback)callback
{
    NSString *apiKey = @"f5408bb6365a69cb9fb8fadf33040c7a";
    NSString *urlString =
    [@"https://api.themoviedb.org/3/movie/now_playing?api_key=" stringByAppendingString:apiKey];
    [self fetchMoviesWithURL:urlString callback:callback];
}

-(void) fetchMoviesWithURL:(NSString*)urlString callback:(MovieFetcherCallback)callback
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                if (!error) {
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    NSLog(@"Response: %@", responseDictionary);
                                                    NSArray* movies = [self parseResponse:responseDictionary];
                                                    callback(movies,jsonError);
                                                } else {
                                                    callback(nil,error);
                                                    NSLog(@"An error occurred: %@", error.description);
                                                }
                                            }];
    [task resume];

}

-(NSArray*)parseResponse:(NSDictionary*)responseDictionary
{
    NSMutableArray* movieArray = [NSMutableArray new];
    NSArray* results = [responseDictionary objectForKey:@"results"];
    for (NSDictionary* dict in results) {
        [movieArray addObject:[[MovieItem alloc] initWithDictionary:dict]];
    }
    return movieArray;
}


@end
