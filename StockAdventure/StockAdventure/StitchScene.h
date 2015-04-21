#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import "GameScene.h"

@class GameViewController;
@protocol StitchTransitionProtocol;

@interface StitchScene : GameScene

@property(nonatomic, weak) UITouch *lastTouch;

@property(nonatomic, strong) AVAudioPlayer *music;
@end
