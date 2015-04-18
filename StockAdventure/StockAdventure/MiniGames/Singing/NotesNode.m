#import "NotesNode.h"
#import "SingingCategories.h"

@implementation NotesNode

+ (NotesNode *)notesNodeForHeight:(int)height {
    NotesNode *node = [self node];

    int widthBetweenNotes = 116;
    int emptyLead = 4 * widthBetweenNotes + 20;
    node.allNotes = @[
            @0, @0, @1, @1, @-1, @-1, @1, @1, @-1, @-1,
            @1, @1, @-1, @-1, @1, @1, @-1, @-1, @-2, @-2,
            @-2, @-2, @-1, @-1, @0, @0, @1, @1, @1, @1,
            @1, @1, @1, @1, @-2, @-2, @-2, @-2, @-1, @-1, @0,
            @0, @1, @1, @1, @1, @1, @1, @1, @1, @2, @-2, @2, @-2
    ];

    for (NSUInteger i = 0; i < [node.allNotes count]; i++) {
        SKSpriteNode *note = [SKSpriteNode spriteNodeWithImageNamed:@"823-birthday-cake"];
        note.size = CGSizeMake(18, 19);
        note.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(18, 19)];
        note.physicsBody.linearDamping = 0;
        note.physicsBody.categoryBitMask = CategoryNote;
        note.physicsBody.contactTestBitMask = CategoryIndicator;
        note.physicsBody.collisionBitMask = ~CategoryIndicator;
        note.name = @"note";
        int yOffset = [node.allNotes[i] intValue] * height / 6;
        note.position = CGPointMake(emptyLead + widthBetweenNotes * i, height / 2 + yOffset);
        [node addChild:note];
    }

    return node;
}

- (void) scroll {
    [self enumerateChildNodesWithName:@"note" usingBlock:^(SKNode *node, BOOL *stop) {
        node.physicsBody.velocity = CGVectorMake(-300, 0);
    }];
}

@end