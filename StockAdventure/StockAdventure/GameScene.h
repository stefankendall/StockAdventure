
#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene

@property(nonatomic) int padBetweenParagraphs;
@property(nonatomic) int horizontalPad;
@property(nonatomic) int topViewVerticalPad;
@property(nonatomic, copy) NSString *pageStartStitch;
@property(nonatomic, copy) NSString *nextStitch;

@property(nonatomic) int currentPosition;

@property(nonatomic) BOOL lastStitchReached;

- (instancetype)initWithSize:(CGSize)size stitch:(NSString *)stitch;
@end
