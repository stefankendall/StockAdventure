#import "SingingScene.h"
#import "UpDownArrowNode.h"
#import "MusicNode.h"
#import "NotesNode.h"
#import "SingingScoreNode.h"
#import "Stitch.h"
#import "StitchTransitionProtocol.h"

@implementation SingingScene

- (instancetype)initWithSize:(CGSize)size stitch:(NSString *)stitch delegate:(NSObject <StitchTransitionProtocol> *)delegate {
    self = [super initWithSize:size stitch:stitch delegate:delegate];
    if (self) {
        [self addSingPrompt];
        [self addMusicElements];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        [self.physicsWorld setContactDelegate:self];
        self.notesHit = 0;

        NSString *path = [[NSBundle mainBundle] pathForResource:@"song" ofType:@"caf"];
        self.song = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    }

    return self;
}

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    [self startMusic];
    [self runAction:[SKAction sequence:@[
            [SKAction waitForDuration:24],
            [SKAction performSelector:@selector(songOver) onTarget:self]
    ]]];
}

- (void)songOver {
    SKAction *fadeAndRemove = [SKAction sequence:@[
            [SKAction fadeAlphaTo:0 duration:1],
            [SKAction removeFromParent]
    ]];
    for (SKNode *node in [self children]) {
        [node runAction:fadeAndRemove];
    }
    [self runAction:[SKAction sequence:@[
            [SKAction waitForDuration:1],
            [SKAction performSelector:@selector(showScore) onTarget:self]
    ]]];
}

- (void)showScore {
    SingingScoreNode *score = [SingingScoreNode nodeWithScore:self.notesHit outOf:self.notesCount];
    score.position = CGPointMake(self.size.width / 2, self.size.height / 2);
    [self addChild:score];

    double zoomDelay = 0.3;
    [score runAction:[SKAction repeatActionForever:[SKAction sequence:@[
            [SKAction scaleTo:0.7 duration:zoomDelay],
            [SKAction scaleTo:1 duration:zoomDelay]
    ]]]];

    [self runAction:[SKAction sequence:@[
            [SKAction waitForDuration:3],
            [SKAction performSelector:@selector(transition) onTarget:self]
    ]]];
}

- (void)transition {
    Stitch *stitch = [[Stitch alloc] initWithStitchId:self.pageStartStitch];
    NSArray *options = [stitch options];

    NSString *performance = [self performancePathFromScore];
    NSString *nextStitchId = @"";
    for (NSDictionary *option in options) {
        if ([performance isEqualToString:option[@"option"]]) {
            nextStitchId = option[@"linkPath"];
        }
    }

    [self.transitionDelegate transitionTo:[Stitch stitchWithStitchId:nextStitchId]];
}

- (NSString *)performancePathFromScore {
    if(self.notesHit < self.notesCount - 6){
        return @"bad";
    }
    else if (self.notesHit < self.notesCount - 2){
        return @"good";
    }
    return @"perfect";
}

- (void)startMusic {
    NotesNode *notes = (NotesNode *) [self childNodeWithName:@"//notes"];
    [notes scroll];
    [self.song play];
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

    NotesNode *notes = (NotesNode *) [self childNodeWithName:@"//notes"];
    self.notesCount = [[notes allNotes] count];
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
    self.notesHit++;
}

- (void)update:(NSTimeInterval)currentTime {
    if (self.lastTime) {
        [self handleSharpFlatTouch:currentTime - self.lastTime];
    }

    self.lastTime = currentTime;
}

@end