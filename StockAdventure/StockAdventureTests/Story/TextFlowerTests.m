#import <XCTest/XCTest.h>
#import "TextFlower.h"

@interface TextFlowerTests : XCTestCase
@end

@implementation TextFlowerTests

- (void)testFitsTextToScreenAndFontSize {
    NSArray *lines = [TextFlower linesFromText:@"A really long line should split into many lines" withWidth:375 fontSize:18];
    XCTAssertEqualObjects(lines[0], @"A really long line");
    XCTAssertEqualObjects(lines[1], @"should split into");
    XCTAssertEqualObjects(lines[2], @"many lines");
}

- (void)testFindsWordsInSentence {
    NSArray *words = [TextFlower wordsFromSentence:@"A quick brown. Fox is nice."];
    XCTAssertEqualObjects(words[0], @"A");
    XCTAssertEqualObjects(words[1], @"quick");
    XCTAssertEqualObjects(words[2], @"brown.");
    XCTAssertEqualObjects(words[3], @"Fox");
    XCTAssertEqualObjects(words[4], @"is");
    XCTAssertEqualObjects(words[5], @"nice.");
}

@end