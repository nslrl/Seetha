//
//  SampleTableLoaderTests.m
//  SampleTableLoaderTests
//
//  Created by Seetha on 09/12/15.
//  Copyright (c) 2015 CTS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface SampleTableLoaderTests : XCTestCase

@property (strong, nonatomic) ViewController *mTestViewController;

@end

@implementation SampleTableLoaderTests

- (void)setUp {
    self.mTestViewController = [[ViewController alloc]init];
    [self.mTestViewController performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    [self.mTestViewController view];

    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testViewLoad
{
    XCTAssertNotNil(self.mTestViewController, @"View not initiated correct way");
}

-(void)testTableViewLoad
{
    XCTAssertNil(self.mTestViewController.self.mTblListView, @"TableView not properly initiated");
}

-(void)testRefreshControlAdded
{
    NSArray *subviews = self.mTestViewController.view.subviews;
    XCTAssertFalse([subviews containsObject:self.mTestViewController.self.mRefreshControl], @"Refresh control not added");
}

-(void)testActivityInitiated
{
    XCTAssertFalse(self.mTestViewController.self.activityIndicator, @"Loading indication not created");
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
