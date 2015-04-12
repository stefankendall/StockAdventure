#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"

@class GameViewController;
@protocol StitchTransitionProtocol;

@interface StitchScene : GameScene

@property(nonatomic, weak) UITouch *lastTouch;

@end
