#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"

@interface SingingScene : GameScene

@property(nonatomic, weak) UITouch *lastTouch;
@end