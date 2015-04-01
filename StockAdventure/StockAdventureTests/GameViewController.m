#import "GameViewController.h"
#import "GameScene.h"
#import "GameScene2.h"

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SKView *skView = (SKView *) self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;

    skView.ignoresSiblingOrder = YES;

    GameScene *scene = [[GameScene alloc] initWithSize:self.view.frame.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:scene];

    [skView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
}

- (void)tap {
    SKTransition *testTransition = [SKTransition fadeWithColor:[UIColor greenColor] duration:3];
    GameScene2 *newScene = [[GameScene2 alloc] initWithSize:self.view.frame.size];
    SKView *skView = (SKView *) self.view;
    [skView presentScene:newScene transition:testTransition];
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
