#import "SingingScene.h"
#import "UpDownArrowNode.h"
#import "MusicNode.h"
#import "NotesNode.h"

@implementation SingingScene

- (instancetype)initWithSize:(CGSize)size stitch:(NSString *)stitch delegate:(NSObject <StitchTransitionProtocol> *)delegate {
    self = [super initWithSize:size stitch:stitch delegate:delegate];
    if (self) {
        [self addSingPrompt];
        [self addMusicElements];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        [self.physicsWorld setContactDelegate:self];
    }

    return self;
}

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    [self startMusic];
}

- (void)startMusic {
    [self runAction:[SKAction playSoundFileNamed:@"song.caf" waitForCompletion:NO]];
    NotesNode *notes = (NotesNode *) [self childNodeWithName:@"//notes"];
    [notes scroll];
}

- (void)addSingPrompt {
    SKSpriteNode *prompt = [SKSpriteNode spriteNodeWithImageNamed:@"sing"];
    prompt.position = CGPointMake(self.size.width / 2, self.size.height - prompt.size.height / 2);
    prompt.zPosition = -1;
    [prompt runAction:[SKAction repeatActionForever:[SKAction sequence:@[
            [SKAction fadeAlphaTo:0.1 duration:0.2],
            [SKAction fadeAlphaTo:1 duration:0.2]
    ]]]];
    [self addChild:prompt];
}

- (void)addMusicElements {
    UpDownArrowNode *sharpNode = [UpDownArrowNode upDownArrowNode:YES width:(int) (self.size.width / 2)];
    int yPosition = 100;
    [sharpNode setPosition:CGPointMake(self.size.width / 4, yPosition)];
    sharpNode.name = @"sharp";
    [self addChild:sharpNode];

    UpDownArrowNode *flatNode = [UpDownArrowNode upDownArrowNode:NO width:(int) (self.size.width / 2)];
    [flatNode setPosition:CGPointMake(3 * self.size.width / 4, yPosition)];
    flatNode.name = @"flat";
    [self addChild:flatNode];

    MusicNode *musicNode = [MusicNode musicNodeForSize:self.size];
    musicNode.name = @"music";
    musicNode.position = CGPointMake(0, 200);
    [self addChild:musicNode];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.lastTouch = [touches anyObject];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    self.lastTouch = [touches anyObject];
}

- (void)handleSharpFlatTouch:(NSTimeInterval)delta {
    UpDownArrowNode *sharp = (UpDownArrowNode *) [self childNodeWithName:@"sharp"];
    UpDownArrowNode *flat = (UpDownArrowNode *) [self childNodeWithName:@"flat"];
    NSArray *touchedNodes = [self nodesAtPoint:[self.lastTouch locationInNode:self]];
    BOOL sharpTouched = NO;
    BOOL flatTouched = NO;
    for (SKNode *touchedNode in touchedNodes) {
        sharpTouched |= sharp == touchedNode;
        flatTouched |= flat == touchedNode;
    }
    [sharp setAlpha:(CGFloat) (sharpTouched ? 0.5 : 1)];
    [flat setAlpha:(CGFloat) (flatTouched ? 0.5 : 1)];

    MusicNode *music = (MusicNode *) [self childNodeWithName:@"music"];
    if (sharpTouched) {
        [music move:YES timeInterval:delta];
    }
    if (flatTouched) {
        [music move:NO timeInterval:delta];
    }
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    if ([contact.bodyB.node.name isEqualToString:@"note"]) {
        [self noteHit:contact.bodyB.node];
    }
    else if ([contact.bodyA.node.name isEqualToString:@"note"]) {
        [self noteHit:contact.bodyA.node];
    }
}

- (void)noteHit:(SKNode *)note {
    [note runAction:[SKAction removeFromParent]];
}

- (void)update:(NSTimeInterval)currentTime {
    if (self.lastTime) {
        [self handleSharpFlatTouch:currentTime - self.lastTime];
    }

    self.lastTime = currentTime;
}

@end