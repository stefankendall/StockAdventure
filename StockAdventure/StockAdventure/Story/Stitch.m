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

@end