#import <SpriteKit/SpriteKit.h>

@class GameViewController;
@protocol StitchTransitionProtocol;

@interface GameScene : SKScene

@property(nonatomic) int padBetweenParagraphs;
@property(nonatomic) int horizontalPad;
@property(nonatomic) int topViewVerticalPad;
@property(nonatomic, copy) NSString *pageStartStitch;
@property(nonatomic, copy) NSString *nextStitch;

@property(nonatomic) BOOL lastStitchReached;

@property(nonatomic, weak) NSObject <StitchTransitionProtocol> *transitionDelegate;

- (instancetype)initWithSize:(CGSize)size stitch:(NSString *)stitch delegate:(NSObject <StitchTransitionProtocol> *)delegate;
@end
