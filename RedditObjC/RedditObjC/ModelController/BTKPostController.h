//
//  BTKPostController.h
//  RedditObjC
//
//  Created by Blake kvarfordt on 8/21/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// This helps with build time. Not App Performance
@class BTKPost;
NS_ASSUME_NONNULL_BEGIN

@interface BTKPostController : NSObject

+ (instancetype)sharedController;

- (void) searchForPostWithSearchTerm:(NSString *)searchTerm completion: (void (^) (NSArray<BTKPost *> *posts, NSError *error))completion;

- (void) fetchThumbnailPost:(BTKPost *)post completion:(void(^)(UIImage *))completion;

@end

NS_ASSUME_NONNULL_END
