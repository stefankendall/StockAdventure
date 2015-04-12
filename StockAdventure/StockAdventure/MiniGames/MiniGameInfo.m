#import "MiniGameInfo.h"
#import "Stitch.h"
#import "SingingScene.h"

@implementation MiniGameInfo

+ (Class)gameSceneForStitch:(Stitch *)stitch {
    return @{
            @"SingingGame" : SingingScene.class
    }[stitch.content];
}

@end