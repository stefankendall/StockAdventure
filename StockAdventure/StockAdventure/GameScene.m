#import "GameScene.h"
#import "StitchTransitionProtocol.h"

@implementation GameScene

- (instancetype)initWithSize:(CGSize)size stitch:(NSString *)stitch delegate:(NSObject <StitchTransitionProtocol> *)delegate {
    self = [super initWithSize:size];
    if (self) {
        self.pageStartStitch = stitch;
        self.nextStitch = stitch;
        self.lastStitchReached = NO;
        self.transitionDelegate = delegate;

        self.backgroundColor = [UIColor whiteColor];
    }

    return self;
}

@end