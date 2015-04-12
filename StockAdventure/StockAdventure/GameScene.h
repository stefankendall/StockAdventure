#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@protocol StitchTransitionProtocol;

@interface GameScene : SKScene

@property(nonatomic, copy) NSString *pageStartStitch;

@property(nonatomic, copy) NSString *nextStitch;

@property(nonatomic) BOOL lastStitchReached;

@property(nonatomic, weak) NSObject <StitchTransitionProtocol> *transitionDelegate;

- (instancetype)initWithSize:(CGSize)size stitch:(NSString *)stitch delegate:(NSObject <StitchTransitionProtocol> *)delegate;

@end