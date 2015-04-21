#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface NewGameButtonNode : SKNode

@property(nonatomic) CGSize size;

+ (NewGameButtonNode *)newGameButtonWithSize:(CGSize)size;
@end