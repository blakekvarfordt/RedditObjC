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
@property (nonatomic, readonly) NSInteger ups;
@property (nonatomic, readonly) NSInteger commentCount;

// This will initialize our object BTKPost
- (instancetype) initWithTitle:(NSString *)title ups:(NSInteger)ups commentCount:(NSInteger)commentCount;


@end

@interface BTKPost (jsonConvertible)

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
