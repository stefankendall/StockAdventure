#import "Stitch.h"
#import "StoryReader.h"

@implementation Stitch

- (instancetype)initWithStitchId:(NSString *)stitchId {
    self = [super init];
    if (self) {
        self.stitchId = stitchId;
        self.stitchDictionary = [[StoryReader instance] getStory][@"data"][@"stitches"][self.stitchId];
    }

    return self;
}

+ (instancetype)stitchWithStitchId:(NSString *)stitchId {
    return [[self alloc] initWithStitchId:stitchId];
}

- (NSString *)divert {
    return [self divertIdFromData:self.stitchDictionary];
}

- (NSString *)content {
    return self.stitchDictionary[@"content"][0];
}

- (NSArray *)options {
    NSMutableArray *options = [@[] mutableCopy];
    NSArray *content = self.stitchDictionary[@"content"];
    for (int i = 1; i < [content count]; i++) {
        NSDictionary *contentDict = content[(NSUInteger) i];
        if (contentDict[@"option"]) {
            [options addObject:contentDict];
        }
    }
    return options;
}

- (NSString *)divertIdFromData:(NSDictionary *)data {
    NSArray *content = data[@"content"];
    for (NSUInteger i = 1; i < [content count]; i++) {
        NSDictionary *contentDict = content[i];
        if (contentDict[@"divert"]) {
            return contentDict[@"divert"];
        }
    }

    return nil;
}

@end