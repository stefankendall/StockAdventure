#import "GameScene.h"
#import "StitchTransitionProtocol.h"
#import "Stitch.h"

@implementation GameScene

- (instancetype)initWithSize:(CGSize)size stitch:(NSString *)stitch delegate:(NSObject <StitchTransitionProtocol> *)delegate {
    self = [super initWithSize:size];
    if (self) {
        self.pageStartStitch = stitch;
        self.nextStitch = [[Stitch alloc] initWithStitchId:stitch];
        self.lastStitchReached = NO;
        self.transitionDelegate = delegate;

        self.backgroundColor = [UIColor whiteColor];
    }

    return self;
}

@end