#import "GameViewController.h"
#import "StitchScene.h"
#import "StoryReader.h"
#import "Stitch.h"
#import "MiniGameInfo.h"
#import "TheEndScene.h"
#import "IntroScene.h"

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SKView *skView = (SKView *) self.view;
    skView.ignoresSiblingOrder = YES;

    self.scene = [[IntroScene alloc] initWithSize:self.view.bounds.size delegate:self];
    self.scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:self.scene];
//    [self restartGame];
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)transitionTo:(Stitch *)stitch {
    SKView *view = (SKView *) self.view;
    SKTransition *crossfade = [SKTransition crossFadeWithDuration:1];

    Class gameSceneClass = [MiniGameInfo gameSceneForStitch:stitch];
    if (gameSceneClass) {
        self.scene = [(GameScene *) [gameSceneClass alloc] initWithSize:self.view.bounds.size
                                                                 stitch:stitch.stitchId
                                                               delegate:self];
    }
    else if ([stitch isTheEnd]) {
        self.scene = [[TheEndScene alloc] initWithSize:self.view.frame.size
                                                stitch:stitch.stitchId
                                              delegate:self];
    }
    else {
        self.scene = [[StitchScene alloc] initWithSize:self.view.frame.size
                                                stitch:stitch.stitchId
                                              delegate:self];
    }
    [view presentScene:self.scene transition:crossfade];
}

- (void)restartGame {
    [self transitionTo:[Stitch stitchWithStitchId:[[StoryReader instance] getStory][@"data"][@"initial"]]];
//    [self transitionTo:[Stitch stitchWithStitchId:[[StoryReader instance] getStory][@"data"][@"editorData"][@"playPoint"]]];
}

- (void)startGame {
    [self restartGame];
}

@end
