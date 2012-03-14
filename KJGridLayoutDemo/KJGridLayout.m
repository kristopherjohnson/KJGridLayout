//
//  KJGridLayout.m
//  KJGridLayoutDemo
//
//  Created by Kristopher Johnson on 3/14/12.
//  Copyright (c) 2012 Kristopher Johnson 
//

#import "KJGridLayout.h"

@interface KJGridLayoutConstraint : NSObject

@property (nonatomic, retain) UIView *view;
@property (nonatomic) NSUInteger rowIndex;
@property (nonatomic) NSUInteger rowSpan;
@property (nonatomic) NSUInteger columnIndex;
@property (nonatomic) NSUInteger columnSpan;

@end

@implementation KJGridLayoutConstraint

@synthesize view;
@synthesize rowIndex;
@synthesize rowSpan;
@synthesize columnIndex;
@synthesize columnSpan;

- (id)init
{
    self = [super init];
    if (self) {
        rowSpan = 1;
        columnSpan = 1;
    }
    return self;
}

- (void)dealloc {
    [view release];
    [super dealloc];
}

@end


@implementation KJGridLayout

@synthesize bounds;

- (id)init {
    self = [super init];
    if (self) {
        constraints = [[NSMutableArray alloc] init];
        bounds = CGRectZero;
    }
    return self;
}

- (void)dealloc {
    [constraints release];
    [super dealloc];
}

- (void)addView:(UIView *)view row:(NSUInteger)rowIndex column:(NSUInteger)columnIndex {
    [self addView:view row:rowIndex column:columnIndex columnSpan:1];
}

- (void)addView:(UIView *)view row:(NSUInteger)rowIndex rowSpan:(NSUInteger)rowSpan column:(NSUInteger)columnIndex  {
    [self addView:view row:rowIndex rowSpan:rowSpan column:columnIndex columnSpan:1];
}

- (void)addView:(UIView *)view row:(NSUInteger)rowIndex column:(NSUInteger)columnIndex columnSpan:(NSUInteger)columnSpan {
    [self addView:view row:rowIndex rowSpan:1 column:columnIndex columnSpan:columnSpan];  
}

- (void)addView:(UIView *)view
            row:(NSUInteger)rowIndex
        rowSpan:(NSUInteger)rowSpan
         column:(NSUInteger)columnIndex
     columnSpan:(NSUInteger)columnSpan
{
    KJGridLayoutConstraint *constraint = [[KJGridLayoutConstraint alloc] init];
    constraint.view = view;
    constraint.rowIndex = rowIndex;
    constraint.rowSpan = rowSpan;
    constraint.columnIndex = columnIndex;
    constraint.columnSpan = columnSpan;
    [constraints addObject:constraint];
    [constraint release];    
}

- (NSArray *)views {
    NSMutableArray *result = [NSMutableArray array];
    
    for (KJGridLayoutConstraint *constraint in constraints) {
        [result addObject:constraint.view];
    }
    
    return result;
}

- (void)removeView:(UIView *)view {
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    NSUInteger index = 0;
    for (KJGridLayoutConstraint *constraint in constraints) {
        if (constraint.view == view) {
            [indexSet addIndex:index];
        }
        ++index;
    }
    [constraints removeObjectsAtIndexes:indexSet];
    [indexSet release];
}

- (void)removeAllViews {
    [constraints removeAllObjects];
}

- (void)countRows:(NSUInteger *)rowCount columns:(NSUInteger *)columnCount {
    NSUInteger maxRowIndex = 0;
    NSUInteger maxColumnIndex = 0;
    for (KJGridLayoutConstraint *constraint in constraints) {
        NSUInteger rowIndex = constraint.rowIndex + constraint.rowSpan - 1;
        NSUInteger columnIndex = constraint.columnIndex + constraint.columnSpan - 1;
        if (rowIndex > maxRowIndex)
            maxRowIndex = rowIndex;
        if (columnIndex > maxColumnIndex) {
            maxColumnIndex = columnIndex;
        }
    }
    *rowCount = maxRowIndex + 1;
    *columnCount = maxColumnIndex + 1;
}

- (void)layoutViews {
    // Determine numbers of rows and columns
    NSUInteger rowCount = 0;
    NSUInteger columnCount = 0;
    [self countRows:&rowCount columns:&columnCount];
    if (rowCount == 0 || columnCount == 0) {
        return;
    }
    
    // Determine sizes of rows and columns
    CGFloat rowHeight = bounds.size.height / rowCount;
    CGFloat columnWidth = bounds.size.width / columnCount;
    
    // Set frame of each view
    for (KJGridLayoutConstraint *constraint in constraints) {
        CGFloat originX = bounds.origin.x + constraint.columnIndex * columnWidth;
        CGFloat originY = bounds.origin.y + constraint.rowIndex * rowHeight;
        CGFloat width = columnWidth * constraint.columnSpan;
        CGFloat height = rowHeight * constraint.rowSpan;
        
        CGRect frame = CGRectMake(originX, originY, width, height);
        
        [constraint.view setFrame:frame];
    }
}

@end
