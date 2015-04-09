#import "GameViewController.h"
#import "GameScene.h"
#import "StoryReader.h"
#import "Stitch.h"

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SKView *skView = (SKView *) self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;

    skView.ignoresSiblingOrder = YES;

    self.scene = [[GameScene alloc] initWithSize:self.view.frame.size
                                          stitch:[[StoryReader instance] getStory][@"data"][@"initial"]
                                        delegate:self];
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
    NSLog(@"%@", stitch.stitchId);
    SKView *view = (SKView *) self.view;
    SKTransition *crossfade = [SKTransition crossFadeWithDuration:1];
    self.scene = [[GameScene alloc] initWithSize:self.view.frame.size
                                          stitch:stitch.stitchId
                                        delegate:self];
    [view presentScene:self.scene transition:crossfade];
}

@end
