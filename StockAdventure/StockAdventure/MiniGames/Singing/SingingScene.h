#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import "GameScene.h"

@interface SingingScene : GameScene <SKPhysicsContactDelegate>

@property(nonatomic, weak) UITouch *lastTouch;
@property(nonatomic) NSTimeInterval lastTime;
@property(nonatomic) int notesHit;
@property(nonatomic) NSUInteger notesCount;
@property(nonatomic, strong) AVAudioPlayer *song;
@end