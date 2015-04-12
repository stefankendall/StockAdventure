#import "GameViewController.h"
#import "StitchScene.h"
#import "StoryReader.h"
#import "Stitch.h"
#import "MiniGameInfo.h"

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SKView *skView = (SKView *) self.view;

    skView.ignoresSiblingOrder = YES;

    [self transitionTo:[Stitch stitchWithStitchId:[[StoryReader instance] getStory][@"data"][@"editorData"][@"playPoint"]]];
//    [self transitionTo:[Stitch stitchWithStitchId:[[StoryReader instance] getStory][@"data"][@"initial"]]];
    self.scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:self.scene];
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
    if(gameSceneClass){
        self.scene = [(GameScene *) [gameSceneClass alloc] initWithSize:self.view.frame.size
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

@end
