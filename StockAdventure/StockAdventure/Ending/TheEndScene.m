#import "TheEndScene.h"

@implementation TheEndScene

const int THE_END_FONT_SIZE = 96;
const NSString *THE_END_FONT_NAME = @"Snell Roundhand";

- (instancetype)initWithSize:(CGSize)size stitch:(NSString *)stitch delegate:(NSObject <StitchTransitionProtocol> *)delegate {
    self = [super initWithSize:size stitch:stitch delegate:delegate];
    if (self) {
        self.playEndingMusic = [SKAction playSoundFileNamed:@"sunset-dreaming.mp3" waitForCompletion:NO];
    }
    return self;
}

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];

    SKLabelNode *the = [SKLabelNode labelNodeWithFontNamed:(NSString *) THE_END_FONT_NAME];
    [the setFontSize:THE_END_FONT_SIZE];
    [the setFontColor:[UIColor blackColor]];
    the.position = CGPointMake(self.size.width / 2, self.size.height / 2 + THE_END_FONT_SIZE / 2);
    [the setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
    [self addChild:the];

    SKLabelNode *endLabel = [SKLabelNode labelNodeWithFontNamed:(NSString *) THE_END_FONT_NAME];
    [endLabel setFontSize:THE_END_FONT_SIZE];
    [endLabel setFontColor:[UIColor blackColor]];
    [endLabel setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
    endLabel.position = CGPointMake(self.size.width / 2, self.size.height / 2 - THE_END_FONT_SIZE / 2);
    [self addChild:endLabel];

    [self runAction:[SKAction sequence:@[
            self.playEndingMusic,
            [SKAction waitForDuration:0.5],
            [SKAction runBlock:^{
                [self reveal:the text:@"THE" done:^{
                    [self reveal:endLabel text:@"END" done:^{
                        [self showStartOverButton];
                    }];
                }];
            }]
    ]]];
}

- (void)showStartOverButton {

}

- (void)reveal:(SKLabelNode *)node text:(NSString *)text done:(void (^)())done {
    __block NSUInteger lengthToReveal = 1;
    SKAction *revealLetters = [SKAction sequence:@[
            [SKAction runBlock:^{
                [node setText:[text substringToIndex:lengthToReveal]];
                lengthToReveal++;
            }],
            [SKAction waitForDuration:0.1]
    ]];
    [node runAction:
            [SKAction sequence:@[
                    [SKAction repeatAction:revealLetters count:[text length]],
                    [SKAction runBlock:done]
            ]]
    ];

}

@end