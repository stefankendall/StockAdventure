#import "StoryReader.h"

@implementation StoryReader

+ (instancetype)instance {
    static StoryReader *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSDictionary *)getStory {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"story" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *e = nil;
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
}

@end