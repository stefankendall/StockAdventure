#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "FlagMarker.h"

@interface FlagMarkerTests : XCTestCase
@end

@implementation FlagMarkerTests

- (void)testMarksStrings {
    [[FlagMarker instance] markSeen:@"test"];
    XCTAssertTrue([[FlagMarker instance] hasSeen: @"test"]);
}

@end