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

- (void)testFindsImageInUrl {
    UIImage *foundImage = [self.stitch imageFromData:@{
            @"content" : @[
                    @"1234",
                    @{@"image" : @"https://dl.dropboxusercontent.com/u/5142994/stockadventure/office.png"}
            ]
    }];

    XCTAssertNotNil(foundImage);
}

- (void)testFindsLastPartOfUrl {
    NSString *last = [self.stitch lastPartOfImageFromUrl:@"https://dl.dropboxusercontent.com/u/5142994/stockadventure/office.png"];
    XCTAssertEqualObjects(last, @"office.png");
}

@end