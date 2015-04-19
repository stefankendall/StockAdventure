#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Stitch.h"

@interface StitchTests : XCTestCase
@property(nonatomic, strong) Stitch *stitch;
@end

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
    NSString *foundImage = [self.stitch imageFromData:@{
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

- (void)testMarksFlagsAndRemovesOptionsForIfNotCondition {
    NSDictionary *content = @{
            @"content" : @[
                    @"",
                    @{@"divert" : @"willYouComeWithM"},
                    @{@"flagName" : @"whathappenedtothem"},
                    @{
                            @"ifConditions" : [NSNull null],
                            @"option" : @"Life is weird. Go with the man.",
                            @"linkPath" : @"heWasntLyingYour",
                            @"notIfConditions" : @[@{@"notIfCondition" : @"notintest"}]
                    },
                    @{
                            @"ifConditions" : [NSNull null],
                            @"option" : @"\"What happened to them?\"",
                            @"linkPath" : @"itsTheStrangestT",
                            @"notIfConditions" : @[@{@"notIfCondition" : @"whathappenedtothem"}]
                    }
            ]
    };
    Stitch *stitch = [[Stitch alloc] initWithStitchDictionary:content];
    [stitch markFlagIfExists];
    XCTAssertEqual([[stitch options] count], 1);
}

@end