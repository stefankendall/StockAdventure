#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import "GameScene.h"

@protocol IntroProtocol;

@interface IntroScene : SKScene

@property(nonatomic, weak) NSObject <IntroProtocol> *introDelegate;

@property(nonatomic, strong) AVAudioPlayer *backgroundMusic;

- (id)initWithSize:(CGSize)size delegate:(NSObject <IntroProtocol> *)delegate;
@end