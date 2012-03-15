//
//  KJGridLayout.m
//  KJGridLayoutDemo
//
//  Created by Kristopher Johnson on 3/14/12.
//  Copyright (c) 2012 Kristopher Johnson 
//

#import "KJGridLayout.h"

// Class used internally by KJGridLayout

@interface KJGridLayoutConstraint : NSObject

@property (nonatomic, retain) UIView *view;

@property (nonatomic) NSUInteger rowIndex;
@property (nonatomic) NSUInteger rowSpan;
@property (nonatomic) NSUInteger columnIndex;
@property (nonatomic) NSUInteger columnSpan;
@property (nonatomic) NSUInteger options;

@end

@implementation KJGridLayoutConstraint

@synthesize view;
@synthesize rowIndex;
@synthesize rowSpan;
@synthesize columnIndex;
@synthesize columnSpan;
@synthesize options;

- (id)init {
    self = [super init];
    if (self) {
        rowSpan = 1;
        columnSpan = 1;
        options = KJGridLayoutDefaultOptions;
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
    [self addView:view
              row:rowIndex
          rowSpan:1
           column:columnIndex
       columnSpan:1
          options:KJGridLayoutDefaultOptions];
}

- (void)addView:(UIView *)view row:(NSUInteger)rowIndex column:(NSUInteger)columnIndex options:(NSUInteger)options {
    [self addView:view
              row:rowIndex
          rowSpan:1
           column:columnIndex
       columnSpan:1
          options:options];
}

- (void)addView:(UIView *)view row:(NSUInteger)rowIndex rowSpan:(NSUInteger)rowSpan column:(NSUInteger)columnIndex  {
    [self addView:view
              row:rowIndex
          rowSpan:rowSpan
           column:columnIndex
       columnSpan:1
          options:KJGridLayoutDefaultOptions];
}

- (void)addView:(UIView *)view row:(NSUInteger)rowIndex column:(NSUInteger)columnIndex columnSpan:(NSUInteger)columnSpan {
    [self addView:view
              row:rowIndex
          rowSpan:1
           column:columnIndex
       columnSpan:columnSpan
          options:KJGridLayoutDefaultOptions];  
}

- (void)addView:(UIView *)view
            row:(NSUInteger)rowIndex
        rowSpan:(NSUInteger)rowSpan
         column:(NSUInteger)columnIndex
     columnSpan:(NSUInteger)columnSpan
{
    [self addView:view
              row:rowIndex
          rowSpan:rowSpan
           column:columnIndex
       columnSpan:columnSpan
          options:KJGridLayoutDefaultOptions];  
}

- (void)addView:(UIView *)view
            row:(NSUInteger)rowIndex
        rowSpan:(NSUInteger)rowSpan
         column:(NSUInteger)columnIndex
     columnSpan:(NSUInteger)columnSpan
        options:(NSUInteger)options
{
    KJGridLayoutConstraint *constraint = [[KJGridLayoutConstraint alloc] init];
    constraint.view = view;
    constraint.rowIndex = rowIndex;
    constraint.rowSpan = rowSpan;
    constraint.columnIndex = columnIndex;
    constraint.columnSpan = columnSpan;
    constraint.options = options;
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
        UIView *view = constraint.view;
        
        // Determine rectangle for this view within grid
        CGFloat originX = bounds.origin.x + constraint.columnIndex * columnWidth;
        CGFloat originY = bounds.origin.y + constraint.rowIndex * rowHeight;
        CGFloat width = columnWidth * constraint.columnSpan;
        CGFloat height = rowHeight * constraint.rowSpan;
        
        // Determine how to fit the view within the rectangle
        
        NSUInteger options = constraint.options;
        CGRect oldFrame = view.frame;
        CGRect newFrame;
                
        if ((options & KJGridLayoutFixedWidth) != 0) {
            // Center horizontally, maintaining the original width
            CGFloat centerX = (originX + width) / 2;
            newFrame.origin.x = centerX - oldFrame.size.width / 2;
            newFrame.size.width = oldFrame.size.width;
        }
        else {
            newFrame.origin.x = originX;
            newFrame.size.width = width;
        }
        
        if ((options & KJGridLayoutFixedHeight) != 0) {
            // Center vertically, maintaining the original height
            CGFloat centerY = (originY + height) / 2;
            newFrame.origin.y = centerY - oldFrame.size.height / 2;
            newFrame.size.height = oldFrame.size.height;
        }
        else {
            newFrame.origin.y = originY;
            newFrame.size.height = height;
        }
        
        [view setFrame:newFrame];
    }
}

@end
