#import "StitchMusic.h"

@implementation StitchMusic

+ (NSString *)pathForMusicForStitch:(NSString *)stitchId {
    NSDictionary *fileNames = @{@"allAroundYouIsWa" : @"now-in-the-office_fycanW4O"};
    if (fileNames[stitchId]) {
        return [[NSBundle mainBundle] pathForResource:fileNames[stitchId] ofType:@"mp3"];
    }
    return nil;
}

@end