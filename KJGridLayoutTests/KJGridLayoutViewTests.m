//
//  KJGridLayoutViewTests.m
//  KJGridLayoutDemo
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

#import "KJGridLayoutViewTests.h"

@implementation KJGridLayoutViewTests

- (void)setUp {
    [super setUp];
    gridLayoutView = [[KJGridLayoutView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
}

- (void)tearDown {
    [gridLayoutView release]; gridLayoutView = nil;
    [super tearDown];
}

- (void)testSingleCell {
    UIView *testView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayoutView addSubview:testView row:0 column:0];
    
    [gridLayoutView layoutIfNeeded];
    
    // testView should now have same frame as gridLayoutView
    STAssertEquals(gridLayoutView.frame.origin.x, testView.frame.origin.x, nil);
    STAssertEquals(gridLayoutView.frame.origin.y, testView.frame.origin.y, nil);
    STAssertEquals(gridLayoutView.frame.size.width, testView.frame.size.width, nil);
    STAssertEquals(gridLayoutView.frame.size.height, testView.frame.size.height, nil);
}
           
- (void)testTwoByTwo {
    UIView *view1 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayoutView addSubview:view1 row:0 column:0];
    
    UIView *view2 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayoutView addSubview:view2 row:0 column:1];
    
    UIView *view3 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayoutView addSubview:view3 row:1 column:0];
    
    UIView *view4 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayoutView addSubview:view4 row:1 column:1];
    
    [gridLayoutView layoutIfNeeded];
    
    STAssertEquals(gridLayoutView.frame.origin.x, view1.frame.origin.x, nil);
    STAssertEquals(gridLayoutView.frame.origin.y, view1.frame.origin.y, nil);
    STAssertEquals(gridLayoutView.frame.size.width / 2, view1.frame.size.width, nil);
    STAssertEquals(gridLayoutView.frame.size.height / 2, view1.frame.size.height, nil);
    
    STAssertEquals(gridLayoutView.frame.origin.x + gridLayoutView.frame.size.width / 2, view2.frame.origin.x, nil);
    STAssertEquals(gridLayoutView.frame.origin.y, view2.frame.origin.y, nil);
    STAssertEquals(gridLayoutView.frame.size.width / 2, view2.frame.size.width, nil);
    STAssertEquals(gridLayoutView.frame.size.height / 2, view2.frame.size.height, nil);
    
    STAssertEquals(gridLayoutView.frame.origin.x, view3.frame.origin.x, nil);
    STAssertEquals(gridLayoutView.frame.origin.y + gridLayoutView.frame.size.height / 2, view3.frame.origin.y, nil);
    STAssertEquals(gridLayoutView.frame.size.width / 2, view3.frame.size.width, nil);
    STAssertEquals(gridLayoutView.frame.size.height / 2, view3.frame.size.height, nil);
    
    STAssertEquals(gridLayoutView.frame.origin.x + gridLayoutView.frame.size.width / 2, view4.frame.origin.x, nil);
    STAssertEquals(gridLayoutView.frame.origin.y + gridLayoutView.frame.size.height / 2, view4.frame.origin.y, nil);
    STAssertEquals(gridLayoutView.frame.size.width / 2, view4.frame.size.width, nil);
    STAssertEquals(gridLayoutView.frame.size.height / 2, view4.frame.size.height, nil);
}

- (void)testColumnSpan {

    [gridLayoutView setFrame:CGRectMake(0, 0, 300, 250)];
    
    UIView *view1 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayoutView addSubview:view1 row:0 column:0 columnSpan:2];
    
    UIView *view2 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayoutView addSubview:view2 row:0 column:2 columnSpan:1];
    
    [gridLayoutView layoutIfNeeded];
    
    STAssertEquals(0.f, view1.frame.origin.x, nil);
    STAssertEquals(0.f, view1.frame.origin.y, nil);
    STAssertEquals(200.f, view1.frame.size.width, nil);
    STAssertEquals(250.f, view1.frame.size.height, nil);
    
    STAssertEquals(200.f, view2.frame.origin.x, nil);
    STAssertEquals(0.f, view2.frame.origin.y, nil);
    STAssertEquals(100.f, view2.frame.size.width, nil);
    STAssertEquals(250.f, view2.frame.size.height, nil);
}

- (void)testRowSpan {
    
    [gridLayoutView setFrame:CGRectMake(0, 0, 250, 300)];
    
    UIView *view1 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayoutView addSubview:view1 row:0 rowSpan:1 column:0];
    
    UIView *view2 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayoutView addSubview:view2 row:1 rowSpan:2 column:0];
    
    [gridLayoutView layoutIfNeeded];
    
    STAssertEquals(0.f, view1.frame.origin.x, nil);
    STAssertEquals(0.f, view1.frame.origin.y, nil);
    STAssertEquals(250.f, view1.frame.size.width, nil);
    STAssertEquals(100.f, view1.frame.size.height, nil);
    
    STAssertEquals(0.f, view2.frame.origin.x, nil);
    STAssertEquals(100.f, view2.frame.origin.y, nil);
    STAssertEquals(250.f, view2.frame.size.width, nil);
    STAssertEquals(200.f, view2.frame.size.height, nil);
}

- (void)testRowAndColumnSpacing {
    
    [gridLayoutView setFrame:CGRectMake(0, 0, 210, 320)];
    
    [gridLayoutView setColumnSpacing:10.f];
    [gridLayoutView setRowSpacing:20.f];
    
    UIView *view1 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayoutView addSubview:view1 row:0 column:0];
    
    UIView *view2 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayoutView addSubview:view2 row:0 column:1];
    
    UIView *view3 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayoutView addSubview:view3 row:1 column:0];
    
    UIView *view4 = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    [gridLayoutView addSubview:view4 row:1 column:1];
    
    [gridLayoutView layoutIfNeeded];
    
    STAssertEquals(0.f, view1.frame.origin.x, nil);
    STAssertEquals(0.f, view1.frame.origin.y, nil);
    STAssertEquals(100.f, view1.frame.size.width, nil);
    STAssertEquals(150.f, view1.frame.size.height, nil);
    
    STAssertEquals(110.f, view2.frame.origin.x, nil);
    STAssertEquals(0.f, view2.frame.origin.y, nil);
    STAssertEquals(100.f, view2.frame.size.width, nil);
    STAssertEquals(150.f, view2.frame.size.height, nil);
    
    STAssertEquals(0.f, view3.frame.origin.x, nil);
    STAssertEquals(170.f, view3.frame.origin.y, nil);
    STAssertEquals(100.f, view3.frame.size.width, nil);
    STAssertEquals(150.f, view3.frame.size.height, nil);
    
    STAssertEquals(110.f, view4.frame.origin.x, nil);
    STAssertEquals(170.f, view4.frame.origin.y, nil);
    STAssertEquals(100.f, view4.frame.size.width, nil);
    STAssertEquals(150.f, view4.frame.size.height, nil);
}

@end
