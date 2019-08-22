//
//  BTKPostController.m
//  RedditObjC
//
//  Created by Blake kvarfordt on 8/21/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

#import "BTKPostController.h"
#import "BTKPost.h"
#import <UIKit/UIKit.h>


@implementation BTKPostController


// Shared Instance
+ (BTKPostController *) sharedController {
    static BTKPostController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [BTKPostController new];
    });
    return shared;
}

// Reddits URL is built with /components and .extensions
+ (NSURL *)baseURL;
{
    return [NSURL URLWithString:@"https://www.reddit.com/r"];
}

- (void)searchForPostWithSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray<BTKPost *> *, NSError *))completion
{
    // Build URL
    NSURL *url = [[BTKPostController baseURL]URLByAppendingPathComponent:searchTerm];
    
    NSURL *finalURL = [url URLByAppendingPathExtension:@"json"];
    
    // NSURLSession
    [[NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // You could show the error to the user if you wanted
        if (error) {
            NSLog(@"ERROR: %@", error);
            return completion(nil, [NSError errorWithDomain:@"Error Fetching json" code:(NSInteger)-1 userInfo:nil]);
        }
        
        // This is just for the developer
        if (!data) {
            NSLog(@"ERROR no data returned from the dataTask");
            return completion(nil, [NSError errorWithDomain:@"no data returned" code:(NSInteger)-1 userInfo:nil]);
        }
        
        
        
        // Parse the data that comes beck from data task
        NSDictionary *topLevelDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &error];
        NSDictionary *dataDict = topLevelDict[@"data"];
        NSArray *childrenArray = dataDict[@"children"];
        
        // Array Placeholder
        NSMutableArray *postArray = [NSMutableArray new];
        
        for (NSDictionary *postDataDict in childrenArray)
        {
            // initialize our object
            BTKPost *post = [[BTKPost alloc] initWithDictionary:postDataDict];
            
            [postArray addObject:post];
            
            // Call completion
            completion(postArray, nil);
            
        }
    }]resume];
}


- (void) fetchThumbnailPost:(BTKPost *)post completion:(void(^)(UIImage *))completion
{
    // Allocat the string version of the thumbnail
    NSString *thumbnailString = [[NSString alloc] initWithFormat: @"%@", post.thumbnail];
    
    // Turn the image string to a NSURL
    NSURL *thumbnailURL = [[NSURL alloc] initWithString:thumbnailString];
    
    
    [[NSURLSession.sharedSession dataTaskWithURL:thumbnailURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"ERROR handling image %@", error);
            completion(nil); return;
        }
        
        
        if (!data) {
            NSLog(@"ERROR no data returned from image %@", error);
            completion(nil); return;
        }
        
        UIImage *thumbnail = [[UIImage alloc] initWithData:data];
 
        completion(thumbnail);
        
        
        
    }]resume];
}


@end
