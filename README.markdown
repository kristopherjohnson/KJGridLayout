# KJGridLayout and KJGridLayoutView

`KJGridLayout` is a simple grid layout manager for views in an iOS application.

It can be used in a UIViewController subclass to arrange views, or can be used in the implementation of `-[UIView layoutSubviews]` in a UIView subclass.

`KJGridLayoutView` is a UIView subclass which uses a `KJGridLayout` in its `-layoutSubviews` implementation. It allows one to add a subview at a particular grid position, and the grid's layout will automatically be updated whenever the view is resized or when a new subview is added.

## Contents

The Xcode project contains the following targets:

- **KJGridLayout** - a static library containing the `KJGridLayout` and `KJGridLayoutView` classes. You can copy this library into your own projects, or just copy the `.h` and `.m` files into your project.
- **KJGridLayoutTests** - unit tests for the `KJGridLayout` library. To run the tests, select the *KJGridLayout* scheme in Xcode and run the *Product > Test* command
- **KJGridLayoutDemo** - a simple app that demonstrates usage of the `KJGridLayout` class
- **KJGridLayoutViewDemo** - a simple app that demonstrates usage of the `KJGridLayoutView` class

## Basic Usage of KJGridLayout

To use `KJGridLayout` in your application, copy [`KJGridLayout.h`](http://github.com/kristopherjohnson/KJGridLayout/blob/master/KJGridLayout/KJGridLayout.h) and [`KJGridLayout.m`](http://github.com/kristopherjohnson/KJGridLayout/blob/master/KJGridLayout/KJGridLayout.m) into your project (or copy the entire KJGridLayout library target).

Create an instance of `KJGridLayout` by calling `[[KJGridLayout alloc] init]`.

Then, add views to the layout by calling `-addView:rowIndex:columnIndex:`.  There are variants of that method that allow specification of `columnSpan` and/or `rowSpan` arguments for elements that span multiple grid cells.

Before performing the layout, call `-setBounds:` to set the boundary rectangle for the layout.  You may want to use the view's bounds, or you may want a smaller boundary rectangle if the grid only takes up part of the view.

Call `-setColumnSpacing` and `-setRowSpacing` if you want some empty space between the columns and rows.

Finally, call `-layoutViews` to perform the layout operation.  This will call `-[UIView setFrame:]` for each view that has been added to the grid layout.  Whenever the size of the superview changes (for example, as the result of an autorotation), you should set the layout's new bounds and then call `-layoutViews` again.

Use `-removeView:` or `-removeAllViews` if you want to remove views from the layout.  If you want to change the layout for an element (for example, moving an element from one column to another), you must remove it and then call one of the `-addView:...` methods to put it in the new place.

## Simple Example of KJGridLayout

    // @property (nonatomic, retain) KJGridLayout *gridLayout;
    @synthesize gridLayout;
    
    - (void)viewDidLoad {
        [super viewDidLoad];
    
        // Initialize the layout manager
        gridLayout = [[KJGridLayout alloc] init] autorelease];
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

    - (void)viewDidUnload {
        // Release the grid layout to release the retained views
        self.gridLayout = nil;
        [super viewDidUnload];
    }
    
    - (void)dealloc {
        [gridLayout release];
        [super dealloc];
    }
    
    - (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)orientation
                                             duration:(NSTimeInterval)duration {
        [super willAnimateRotationToInterfaceOrientation:orientation duration:duration];
        
        // Redo layout during autorotation
        [UIView animateWithDuration:duration animations:^{
            [gridLayout setBounds:[self.view bounds]];
            [gridLayout layoutViews];        
        }];    
    }

See the included [`KJGridLayoutDemo`](http://github.com/kristopherjohnson/KJGridLayout/blob/master/KJGridLayoutDemo/KJViewController.m) application for a more complete example.

## Usage of KJGridLayoutView

To use `KJGridLayoutView` in your application, copy [`KJGridLayout.h`](http://github.com/kristopherjohnson/KJGridLayout/blob/master/KJGridLayout/KJGridLayout.h), [`KJGridLayout.m`](http://github.com/kristopherjohnson/KJGridLayout/blob/master/KJGridLayout/KJGridLayout.m), [`KJGridLayoutView.h`](http://github.com/kristopherjohnson/KJGridLayout/blob/master/KJGridLayout/KJGridLayoutView.h) and [`KJGridLayoutView.m`](http://github.com/kristopherjohnson/KJGridLayout/blob/master/KJGridLayout/KJGridLayoutView.m) into your project (or copy the entire KJGridLayout library target).

Using `KJGridLayoutView` is similar to using `KJGridLayout`, but instead of calling `-addView:row:rowSpan:column:columnSpan:options:`, you call `-addSubview:row:rowSpan:column:columnSpan:options:`, which both adds the view as a subview and sets its grid-layout parameters.

You can also use `-[UIView addSubview:]` with `KJGridLayoutView`. Subviews added with that method will not participate in grid layout.

If you set the views `autoresizingMask` appropriately, then the view's grid-layout code will be called automatically during autorotation or any other events that cause the view's size to change.

See [`KJGridLayoutViewDemo`](http://github.com/kristopherjohnson/KJGridLayout/blob/master/KJGridLayoutViewDemo/KJViewController.m) for a complete example.

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
