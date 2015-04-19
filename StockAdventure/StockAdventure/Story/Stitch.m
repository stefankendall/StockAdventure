#import "Stitch.h"
#import "StoryReader.h"
#import "FlagMarker.h"

@implementation Stitch

- (instancetype)initWithStitchId:(NSString *)stitchId {
    self = [super init];
    if (self) {
        self.stitchId = stitchId;
        self.stitchDictionary = [[StoryReader instance] getStory][@"data"][@"stitches"][self.stitchId];
    }
    return self;
}

- (instancetype)initWithStitchDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.stitchDictionary = dictionary;
    }
    return self;
}

+ (instancetype)stitchWithStitchId:(NSString *)stitchId {
    return [[self alloc] initWithStitchId:stitchId];
}

- (Stitch *)divert {
    NSString *divertId = [self divertIdFromData:self.stitchDictionary];
    return divertId ? [[Stitch alloc] initWithStitchId:divertId] : nil;
}

- (NSString *)content {
    return self.stitchDictionary[@"content"][0];
}

- (void)markFlagIfExists {
    NSString *marker = [self findSingleProperty:@"flagName" inData:self.stitchDictionary];
    if (marker) {
        [[FlagMarker instance] markSeen:marker];
    }
}

- (NSArray *)options {
    NSMutableArray *options = [@[] mutableCopy];
    NSArray *content = self.stitchDictionary[@"content"];
    for (int i = 1; i < [content count]; i++) {
        NSDictionary *contentDict = content[(NSUInteger) i];
        if (contentDict[@"option"]) {
            NSArray *notIfConditions = contentDict[@"notIfConditions"];
            if (notIfConditions && ![notIfConditions isEqual:[NSNull null]]) {
                for (NSDictionary *condition in contentDict[@"notIfConditions"]) {
                    NSString *marker = condition[@"notIfCondition"];
                    if (![[FlagMarker instance] hasSeen:marker]) {
                        [options addObject:contentDict];
                    }
                }
            }
            else {
                [options addObject:contentDict];
            }
        }
    }
    return options;
}

- (NSString *)image {
    return [self imageFromData:self.stitchDictionary];
}

- (NSString *)imageFromData:(NSDictionary *)data {
    NSString *imageUrl = [self findSingleProperty:@"image" inData:data];
    if (!imageUrl) {
        return nil;
    }

    return [self lastPartOfImageFromUrl:imageUrl];
}

- (NSString *)lastPartOfImageFromUrl:(NSString *)url {
    NSArray *parts = [url componentsSeparatedByString:@"/"];
    return [parts lastObject];
}

- (NSString *)divertIdFromData:(NSDictionary *)data {
    return [self findSingleProperty:@"divert" inData:data];
}

- (NSString *)findSingleProperty:(NSString *)key inData:(NSDictionary *)data {
    NSArray *content = data[@"content"];
    for (NSUInteger i = 1; i < [content count]; i++) {
        NSDictionary *contentDict = content[i];
        if (contentDict[key]) {
            return contentDict[key];
        }
    }
    return nil;
}

- (BOOL)isTheEnd {
    return [[self content] isEqualToString:@"THE END"];
}
@end