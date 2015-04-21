
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "StitchTransitionProtocol.h"
#import "IntroProtocol.h"

@interface GameViewController : UIViewController <StitchTransitionProtocol, IntroProtocol>

@property(nonatomic, strong) SKScene *scene;
@end
