#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface NotesNode : SKNode

@property(nonatomic, strong) NSArray *allNotes;

+ (NotesNode *)notesNodeForHeight:(int)height;

- (void)scroll;
@end