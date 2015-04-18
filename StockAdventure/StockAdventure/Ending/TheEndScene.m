#import "TheEndScene.h"
#import "OptionNode.h"
#import "StitchTransitionProtocol.h"

@implementation TheEndScene

const int THE_END_FONT_SIZE = 96;
const NSString *THE_END_FONT_NAME = @"Snell Roundhand";

- (instancetype)initWithSize:(CGSize)size stitch:(NSString *)stitch delegate:(NSObject <StitchTransitionProtocol> *)delegate {
    self = [super initWithSize:size stitch:stitch delegate:delegate];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"sunset-dreaming" ofType:@"mp3"];
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    }
    return self;
}

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];

    [self.audioPlayer play];

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
    int SEGMENTS = 10;
    CGFloat buttonWidth = self.size.width - 2 * self.size.width / SEGMENTS;
    int buttonHeight = 50;
    SKShapeNode *restartButton = [SKShapeNode shapeNodeWithRect:CGRectMake(0, 0, buttonWidth, buttonHeight)];
    [restartButton setFillColor:[UIColor redColor]];
    restartButton.position = CGPointMake(self.size.width / SEGMENTS, 20);
    restartButton.name = @"restart";

    SKLabelNode *restartLabel = [SKLabelNode labelNodeWithFontNamed:(NSString *) OPTION_FONT_NAME];
    [restartLabel setText:@"RESTART"];
    restartLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    restartLabel.position = CGPointMake(buttonWidth / 2, buttonHeight / 2);
    [restartButton addChild:restartLabel];
    [restartButton runAction:[SKAction repeatActionForever:[SKAction sequence:@[
            [SKAction fadeAlphaTo:0.5 duration:0.5],
            [SKAction fadeAlphaTo:1 duration:0.5]
    ]]]];

    [self addChild:restartButton];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray *touchedNodes = [self nodesAtPoint:[[touches anyObject] locationInNode:self]];
    for (SKNode *touchedNode in touchedNodes) {
        if ([touchedNode.name isEqualToString:@"restart"]) {
            [self.audioPlayer stop];
            [self.transitionDelegate restartGame];
        }
    }
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