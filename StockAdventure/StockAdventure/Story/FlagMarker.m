#import "FlagMarker.h"

@implementation FlagMarker

+ (FlagMarker *)instance {
    static FlagMarker *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.seenMarkers = [@[] mutableCopy];
    }
    return self;
}

- (void)markSeen:(NSString *)marker {
    if (![self hasSeen:marker]) {
        [self.seenMarkers addObject:marker];
    }
}

- (BOOL)hasSeen:(NSString *)marker {
    return [self.seenMarkers containsObject:marker];
}


@end