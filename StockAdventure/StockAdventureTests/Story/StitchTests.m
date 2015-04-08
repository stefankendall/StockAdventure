#import "StitchTests.h"
#import "Stitch.h"

@implementation StitchTests

- (void)setUp {
    [super setUp];
    self.stitch = [Stitch new];
}

- (void)testFindsDivertInData {
    NSString *divertId = @"test";
    NSString *foundId = [self.stitch divertIdFromData:@{
            @"content" : @[
                    @"data...",
                    @{@"image" : @""},
                    @{@"divert" : divertId},
                    @{@"pageNum" : @1}
            ]
    }];

    XCTAssertEqualObjects(divertId, foundId);
}

@end