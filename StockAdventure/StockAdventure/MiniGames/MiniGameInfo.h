#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@class Stitch;

@interface MiniGameInfo : NSObject

+ (Class) gameSceneForStitch: (Stitch *)stitch;

@end