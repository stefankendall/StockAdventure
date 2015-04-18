#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "GameScene.h"

@interface TheEndScene : GameScene
@property(nonatomic, strong) SKAction *playEndingMusic;
@property(nonatomic, strong) AVAudioPlayer *audioPlayer;
@end