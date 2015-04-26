#import "StitchMusic.h"

@implementation StitchMusic

+ (NSString *)pathForMusicForStitch:(NSString *)stitchId {
    NSDictionary *fileNames = @{
            @"allAroundYouIsWa" : @"now-in-the-office_fycanW4O",
            @"coffeeshopSounds" : @"water-pour-liquid-into-coffee-mug_zkqmj3V_",
            @"tooScaredToSpeak" : @"the-tragedy-of-loss_zJNwxXr_",
            @"youContinueWorki" : @"keyboard-fast-typing_fyZ9ZBVu",
            @"yourVoiceLiftsTh" : @"bayou-trans-1_MJJ4pLHu",
            @"itsHerBIRTHDAYHe" : @"cartoon-voice-clip-male-adult-shout-angry-ah-fiddle-faddle_GksC6LN_",
            @"jenniferAlwaysEa" : @"eating-chips_fkLZDMEu",
            @"youSighHeavilyTh" : @"male-50-sigh_GJD5z_Ed",
            @"yourLifeIsFairly" : @"laugh-track-2_z1lpz64O"
    };
    if (fileNames[stitchId]) {
        return [[NSBundle mainBundle] pathForResource:fileNames[stitchId] ofType:@"mp3"];
    }
    return nil;
}

@end