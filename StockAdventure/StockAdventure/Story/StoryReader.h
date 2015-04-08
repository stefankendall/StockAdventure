#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StoryReader : NSObject

+ (instancetype)instance;

- (NSDictionary *)getStory;

@end