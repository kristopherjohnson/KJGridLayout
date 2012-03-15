# KJGridLayout

KJGridLayout is a class that acts as a simple grid layout manager for views in an iOS application.

It can be used in a UIViewController subclass to arrange views, or can be used in the implementation of `-layoutSubviews` in a UIView subclass.

## Basic Usage

To use it in your application, simply copy `KJGridLayout.h` and `KJGridLayout.m` into your project.

Create an instance of `KJGridLayout` by calling `[[KJGridLayout alloc] init]`.

Then, add views to the layout by invoking `-addView:rowIndex:columnIndex:`.  There are variants of that method that allow specification of `columnSpan` and/or `rowSpan` arguments for elements that span multiple grid cells.

Before performing the layout, call `-setBounds:` to set the boundary rectangle for the layout.  You may want to use the view's bounds, or may want a smaller boundary rectangle if the grid only takes up part of the view.

Call `-setColumnSpacing` and `-setRowSpacing` if you want some empty space between the columns and rows.

Finally, call `-layoutViews` to perform the layout operation.  This will set the frames of the views.

Use `-removeView` or `-removeAllViews` if you want to remove views from the layout.  If you want to change the layout for an element (for example, moving an element from one column to another), you must remove it and then add it back.

## Simple Example

    - (void)viewDidLoad {
        [super viewDidLoad];
    
        // Initialize the layout manager
        KJGridLayout *gridLayout = [[KJGridLayout alloc] init] autorelease];
        [gridLayout setColumnSpacing:4];
        [gridLayout setRowSpacing:4];
    
        // Create 1-9 keypad buttons in 3x3 grid
        for (NSUInteger i = 0; i < 9; ++i) {
            NSString *title = [NSString stringWithFormat:@"%u", (unsigned) i + 1];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setTitle:title forState:UIControlStateNormal];
            [self.view addSubview:button];

            NSUInteger rowIndex = i / 3;
            NSUInteger columnIndex = i % 3;
            [gridLayout addView:button row:rowIndex column:columnIndex];
        }

        // Set the layout bounds to match the view's bounds.
        [gridLayout setBounds:[self.view bounds]];
    
        // Call -layoutViews
        [gridLayout layoutViews];
    }

See the included `KJGridLayoutDemo` application for a more involved example.

## LICENSE

Copyright &copy; 2012 Kristopher Johnson
 
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
