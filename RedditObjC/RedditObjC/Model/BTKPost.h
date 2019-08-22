//
//  BTKPost.h
//  RedditObjC
//
//  Created by Blake kvarfordt on 8/21/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTKPost : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, readonly) NSNumber *ups;
@property (nonatomic, readonly) NSNumber *commentCount;
@property (nonatomic, readonly, copy) NSString *thumbnail;

// This will initialize our object BTKPost
- (instancetype) initWithTitle:(NSString *)title ups:(NSNumber *)ups commentCount:(NSNumber *)commentCount thumbnail:(NSString *)thumbnail;


@end

@interface BTKPost (jsonConvertible)

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
