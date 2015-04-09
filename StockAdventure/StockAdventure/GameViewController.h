
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "StitchTransitionProtocol.h"

@interface GameViewController : UIViewController <StitchTransitionProtocol>

@property(nonatomic, strong) SKScene *scene;
@end
