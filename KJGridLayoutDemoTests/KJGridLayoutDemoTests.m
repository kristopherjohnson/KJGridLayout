//
//  KJGridLayoutDemoTests.m
//  KJGridLayoutDemoTests
//
//  Created by Kristopher Johnson on 3/13/12.
//  Copyright (c) 2012 Kristopher Johnson 
//

#import "KJGridLayoutDemoTests.h"

@implementation KJGridLayoutDemoTests

- (void)setUp {
    [super setUp];
    gridLayout = [[KJGridLayout alloc] init];
}

- (void)tearDown {
    [gridLayout release]; gridLayout = nil;
    [super tearDown];
}

- (void)testSingleCell {
    gridLayout.bounds = CGRectMake(10, 20, 320, 300);
    
    UIView *view = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayout addView:view row:0 column:0];
    
    [gridLayout layoutViews];
    
    STAssertEquals(10.f, view.frame.origin.x, nil);
    STAssertEquals(20.f, view.frame.origin.y, nil);
    STAssertEquals(320.f, view.frame.size.width, nil);
    STAssertEquals(300.f, view.frame.size.height, nil);
}

- (void)testTwoCellsInTwoColumns {
    gridLayout.bounds = CGRectMake(0, 0, 320, 300);
    
    UIView *view1 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayout addView:view1 row:0 column:0];
    
    UIView *view2 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayout addView:view2 row:0 column:1];
    
    [gridLayout layoutViews];
    
    STAssertEquals(0.f, view1.frame.origin.x, nil);
    STAssertEquals(0.f, view1.frame.origin.y, nil);
    STAssertEquals(160.f, view1.frame.size.width, nil);
    STAssertEquals(300.f, view1.frame.size.height, nil);
    
    STAssertEquals(160.f, view2.frame.origin.x, nil);
    STAssertEquals(0.f, view2.frame.origin.y, nil);
    STAssertEquals(160.f, view2.frame.size.width, nil);
    STAssertEquals(300.f, view2.frame.size.height, nil);
}

- (void)testThreeByThree {
    gridLayout.bounds = CGRectMake(100, 200, 300, 600);
    
    UIView *view1 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayout addView:view1 row:0 column:0];
    
    UIView *view2 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayout addView:view2 row:1 column:1];
    
    UIView *view3 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayout addView:view3 row:2 column:2];
    
    [gridLayout layoutViews];
    
    STAssertEquals(100.f, view1.frame.origin.x, nil);
    STAssertEquals(200.f, view1.frame.origin.y, nil);
    STAssertEquals(100.f, view1.frame.size.width, nil);
    STAssertEquals(200.f, view1.frame.size.height, nil);
    
    STAssertEquals(200.f, view2.frame.origin.x, nil);
    STAssertEquals(400.f, view2.frame.origin.y, nil);
    STAssertEquals(100.f, view2.frame.size.width, nil);
    STAssertEquals(200.f, view2.frame.size.height, nil);
    
    STAssertEquals(300.f, view3.frame.origin.x, nil);
    STAssertEquals(600.f, view3.frame.origin.y, nil);
    STAssertEquals(100.f, view3.frame.size.width, nil);
    STAssertEquals(200.f, view3.frame.size.height, nil);
}

- (void)testRemove {
    UIView *view1 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayout addView:view1 row:0 column:0];
    
    UIView *view2 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayout addView:view2 row:1 column:1];
    
    STAssertEquals(2U, gridLayout.views.count, nil);
    
    [gridLayout removeView:view1];
    
    STAssertEquals(1U, gridLayout.views.count, nil);
    STAssertEquals(view2, [gridLayout.views objectAtIndex:0], nil);
}

- (void)testRemoveAllViews {
    UIView *view1 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayout addView:view1 row:0 column:0];
    
    UIView *view2 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayout addView:view2 row:1 column:1];
    
    STAssertEquals(2U, gridLayout.views.count, nil);
    
    [gridLayout removeAllViews];
    
    STAssertEquals(0U, gridLayout.views.count, nil);
}

- (void)testColumnSpan {
    [gridLayout setBounds:CGRectMake(100, 200, 400, 250)];
    
    UIView *view1 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayout addView:view1 row:0 column:0];
    
    UIView *view2 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayout addView:view2 row:1 column:0 columnSpan:2];
    
    [gridLayout layoutViews];
    
    STAssertEquals(100.f, view1.frame.origin.x, nil);
    STAssertEquals(200.f, view1.frame.origin.y, nil);
    STAssertEquals(200.f, view1.frame.size.width, nil);
    STAssertEquals(125.f, view1.frame.size.height, nil);
    
    STAssertEquals(100.f, view2.frame.origin.x, nil);
    STAssertEquals(325.f, view2.frame.origin.y, nil);
    STAssertEquals(400.f, view2.frame.size.width, nil);
    STAssertEquals(125.f, view2.frame.size.height, nil);    
}

- (void)testRowSpan {
    [gridLayout setBounds:CGRectMake(-100, -200, 200, 300)];
    
    UIView *view1 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayout addView:view1 row:0 column:1];
    
    UIView *view2 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayout addView:view2 row:0 rowSpan:3 column:0];
    
    [gridLayout layoutViews];
    
    STAssertEquals(0.f, view1.frame.origin.x, nil);
    STAssertEquals(-200.f, view1.frame.origin.y, nil);
    STAssertEquals(100.f, view1.frame.size.width, nil);
    STAssertEquals(100.f, view1.frame.size.height, nil);
    
    STAssertEquals(-100.f, view2.frame.origin.x, nil);
    STAssertEquals(-200.f, view2.frame.origin.y, nil);
    STAssertEquals(100.f, view2.frame.size.width, nil);
    STAssertEquals(300.f, view2.frame.size.height, nil);
}

- (void)testFixedSize {
    [gridLayout setBounds:CGRectMake(0, 0, 300, 400)];
    
    UIView *view1 = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)] autorelease];
    [gridLayout addView:view1 row:0 rowSpan:2 column:0 columnSpan:1 options:KJGridLayoutFixedSize];
    
    [gridLayout layoutViews];
    
    STAssertEquals(150.f, view1.center.x, nil);
    STAssertEquals(200.f, view1.center.y, nil);
    STAssertEquals(10.f, view1.frame.size.width, nil);
    STAssertEquals(20.f, view1.frame.size.height, nil);
}

@end
