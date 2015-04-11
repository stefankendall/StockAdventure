#import <SpriteKit/SpriteKit.h>

@class GameViewController;
@protocol StitchTransitionProtocol;

@interface GameScene : SKScene

@property(nonatomic, copy) NSString *nextStitch;

@property(nonatomic) BOOL lastStitchReached;

@property(nonatomic, weak) NSObject <StitchTransitionProtocol> *transitionDelegate;

@property(nonatomic, copy) NSString *pageStartStitch;

@property(nonatomic, weak) UITouch *lastTouch;

- (instancetype)initWithSize:(CGSize)size stitch:(NSString *)stitch delegate:(NSObject <StitchTransitionProtocol> *)delegate;
@end
