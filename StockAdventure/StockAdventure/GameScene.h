#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@protocol StitchTransitionProtocol;
@class Stitch;

@interface GameScene : SKScene

@property(nonatomic, copy) NSString *pageStartStitch;

@property(nonatomic, strong) Stitch *nextStitch;

@property(nonatomic) BOOL lastStitchReached;

@property(nonatomic, weak) NSObject <StitchTransitionProtocol> *transitionDelegate;

- (instancetype)initWithSize:(CGSize)size stitch:(NSString *)stitch delegate:(NSObject <StitchTransitionProtocol> *)delegate;

@end