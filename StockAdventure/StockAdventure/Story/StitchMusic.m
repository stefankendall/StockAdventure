#import "StitchMusic.h"

@implementation StitchMusic

+ (NSString *)pathForMusicForStitch:(NSString *)stitchId {
    NSDictionary *fileNames = @{
            @"allAroundYouIsWa" : @"now-in-the-office_fycanW4O",
            @"coffeeshopSounds" : @"water-pour-liquid-into-coffee-mug_zkqmj3V_",
            @"tooScaredToSpeak" : @"the-tragedy-of-loss_zJNwxXr_",
            @"youContinueWorki" : @"keyboard-fast-typing_fyZ9ZBVu"
    };
    if (fileNames[stitchId]) {
        return [[NSBundle mainBundle] pathForResource:fileNames[stitchId] ofType:@"mp3"];
    }
    return nil;
}

@end