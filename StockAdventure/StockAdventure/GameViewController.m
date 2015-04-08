#import "GameViewController.h"
#import "GameScene.h"
#import "StoryReader.h"

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SKView *skView = (SKView *) self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;

    skView.ignoresSiblingOrder = YES;

    GameScene *scene = [[GameScene alloc] initWithSize:self.view.frame.size
                                                stitch:[[StoryReader instance] getStory][@"data"][@"initial"]];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:scene];
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

@end
