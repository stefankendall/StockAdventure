#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FlagMarker : NSObject

@property(nonatomic, strong) NSMutableArray *seenMarkers;

+ (FlagMarker *) instance;

- (void)markSeen:(NSString *)marker;

- (BOOL)hasSeen:(NSString *)marker;
@end