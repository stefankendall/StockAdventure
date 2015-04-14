#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface MusicNode : SKNode
@property(nonatomic) int heightOfMusic;

@property(nonatomic) int barWidth;

+ (MusicNode *)musicNodeForSize:(CGSize)size;

- (void)move:(BOOL)up timeInterval:(NSTimeInterval)interval;

@end