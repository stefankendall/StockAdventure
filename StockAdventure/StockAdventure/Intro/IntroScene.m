#import "IntroScene.h"
#import "GameViewController.h"
#import "NewGameButtonNode.h"

@implementation IntroScene

- (id)initWithSize:(CGSize)size delegate:(NSObject <IntroProtocol> *)delegate {
    self = [super initWithSize:size];
    if (self) {
        self.introDelegate = delegate;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"lovers-dream_f1UEULrO" ofType:@"mp3"];
        self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
//    [self.backgroundMusic play];

    CGFloat verticalCenter = self.size.height / 2 + 75;

    SKLabelNode *stock = [SKLabelNode labelNodeWithFontNamed:@"Zapfino"];
    int fontSize = 52;
    [stock setFontSize:fontSize];
    [stock setFontColor:[UIColor blackColor]];
    stock.alpha = 0;
    [stock setText:@"Stock"];
    stock.position = CGPointMake(self.size.width / 2, verticalCenter);
    stock.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
    [self addChild:stock];

    SKLabelNode *adventure = [SKLabelNode labelNodeWithFontNamed:@"Zapfino"];
    [adventure setFontSize:fontSize];
    [adventure setFontColor:[UIColor blackColor]];
    adventure.alpha = 0;
    [adventure setText:@"Adventure"];
    adventure.position = CGPointMake(self.size.width / 2, verticalCenter);
    adventure.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
    [self addChild:adventure];

    [stock runAction:[SKAction fadeAlphaTo:1 duration:4]];
    [adventure runAction:[SKAction fadeAlphaTo:1 duration:4]];

    NewGameButtonNode *newGame = [NewGameButtonNode newGameButtonWithSize:self.size];
    newGame.position = CGPointMake(self.size.width / 2, 75);
    newGame.name = @"newGame";
    [self addChild:newGame];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    SKNode *touch = [self nodeAtPoint:[[touches anyObject] locationInNode:self]];
    if ([[touch name] isEqualToString:@"newGame"]) {
        [self.backgroundMusic stop];
        [self.introDelegate startGame];
    }
}

@end