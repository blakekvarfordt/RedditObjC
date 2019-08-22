//
//  BTKPost.m
//  RedditObjC
//
//  Created by Blake kvarfordt on 8/21/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

#import "BTKPost.h"

@implementation BTKPost

-(instancetype)initWithTitle:(NSString *)title ups:(NSNumber *)ups commentCount:(NSNumber *)commentCount thumbnail:(NSString *)thumbnail
{
    // All ObjC initializers are failable
    self = [super init];
    
    if (self) {
        _title = title;
        _ups = ups;
        _commentCount = commentCount;
        _thumbnail = thumbnail;
    }
    return self;
}

@end



@implementation BTKPost (jsonConvertible)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    // This is the data for the object properties we want
    NSDictionary *dataDictionary = dictionary[@"data"];
    
    // Next Level to initialize object. Get actual properties from JSON
    NSString *title = dataDictionary[[BTKPost titleKey]];
    NSNumber *upsCount = dataDictionary[[BTKPost upsKey]];
    NSNumber *commentCount = dataDictionary[[BTKPost commentCountKey]];
    NSString *thumbnail = dataDictionary[[BTKPost thumbnailKey]];
    
    return [self initWithTitle:title ups:upsCount commentCount:commentCount thumbnail:thumbnail];

}

+ (NSString *) titleKey
{
    return @"title";
}

+ (NSString *) commentCountKey
{
    return @"num_comments";
}

+ (NSString *) upsKey
{
    return @"ups";
}

+ (NSString *) thumbnailKey
{
    return @"thumbnail";
}

@end

