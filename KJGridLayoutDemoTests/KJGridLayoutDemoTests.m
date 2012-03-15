//
//  KJGridLayoutDemoTests.m
//  KJGridLayoutDemoTests
//
// Copyright (C) 2012 Kristopher Johnson
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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

- (void)testColumnSpacing {
    [gridLayout setBounds:CGRectMake(0, 0, 430, 400)];
    [gridLayout setColumnSpacing:10];
    
    UIView *view1 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayout addView:view1 row:0 column:0];
    
    UIView *view2 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayout addView:view2 row:0 column:1];
    
    UIView *view3 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayout addView:view3 row:0 column:2 columnSpan:2];
    
    [gridLayout layoutViews];
    
    STAssertEquals(0.f, view1.frame.origin.x, nil);
    STAssertEquals(100.f, view1.frame.size.width, nil);
    
    STAssertEquals(110.f, view2.frame.origin.x, nil);
    STAssertEquals(100.f, view2.frame.size.width, nil);
    
    STAssertEquals(220.f, view3.frame.origin.x, nil);
    STAssertEquals(210.f, view3.frame.size.width, nil);
}

- (void)testRowSpacing {
    [gridLayout setBounds:CGRectMake(0, 0, 430, 540)];
    [gridLayout setRowSpacing:10];
    
    UIView *view1 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayout addView:view1 row:0 column:0];
    
    UIView *view2 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayout addView:view2 row:1 rowSpan:3 column:0];
    
    UIView *view3 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayout addView:view3 row:4 column:0];
    
    [gridLayout layoutViews];
    
    STAssertEquals(0.f, view1.frame.origin.y, nil);
    STAssertEquals(100.f, view1.frame.size.height, nil);
    
    STAssertEquals(110.f, view2.frame.origin.y, nil);
    STAssertEquals(320.f, view2.frame.size.height, nil);
    
    STAssertEquals(440.f, view3.frame.origin.y, nil);
    STAssertEquals(100.f, view3.frame.size.height, nil);
}

@end
