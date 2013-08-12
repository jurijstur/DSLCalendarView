/*
 DSLCalendarDayView.h
 
 Copyright (c) 2012 Dative Studios. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors may be used
 to endorse or promote products derived from this software without specific
 prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


#import "DSLCalendarDayView.h"
#import "NSDate+DSLCalendarView.h"


@interface DSLCalendarDayView ()

@end


@implementation DSLCalendarDayView {
    __strong NSCalendar *_calendar;
    __strong NSDate *_dayAsDate;
    __strong NSDateComponents *_day;
    __strong NSString *_labelText;
}


#pragma mark - Initialisation

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.backgroundColor = [UIColor whiteColor];
        _positionInWeek = DSLCalendarDayViewMidWeek;

        _borderColor = [UIColor colorWithWhite:255.0/255.0 alpha:1.0];
        
        _bevelColor = [UIColor colorWithWhite:205.0/255.0 alpha:1.0f];
        _bevelColorNotCurrentMonth = [UIColor colorWithWhite:185.0/255.0 alpha:1.0f];
        
        _fillColor = [UIColor colorWithWhite:245.0/255.0 alpha:1.0];
        _fillColorNotCurrentMonth = [UIColor colorWithWhite:225.0/255.0 alpha:1.0];
        
        _selectedTextColor = [UIColor colorWithWhite:66.0/255.0 alpha:1.0];
        _textColor = [UIColor whiteColor];
        
        _textFont = [UIFont boldSystemFontOfSize:17.0];
        _selectedTextFont = _textFont;
        
        _selectedLeftBackgroundImage = [[UIImage imageNamed:@"DSLCalendarDaySelection-left"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
        _selectedRightBackgroundImage = [[UIImage imageNamed:@"DSLCalendarDaySelection-right"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
        _selectedMiddleBackgroundImage = [[UIImage imageNamed:@"DSLCalendarDaySelection-middle"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
        _selectedWholeBackgroundImage = [[UIImage imageNamed:@"DSLCalendarDaySelection"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    }
    
    return self;
}

#pragma mark Properties

- (void)setSelectionState:(DSLCalendarDayViewSelectionState)selectionState {
    if(_selectionState != selectionState) {
        _selectionState = selectionState;
        [self setNeedsDisplay];
    }
}

- (void)setDay:(NSDateComponents *)day {
    _calendar = [day calendar];
    _dayAsDate = [day date];
    _day = nil;
    _labelText = [NSString stringWithFormat:@"%d", day.day];
}

- (NSDateComponents*)day {
    if (_day == nil) {
        _day = [_dayAsDate dslCalendarView_dayWithCalendar:_calendar];
    }
    
    return _day;
}

- (NSDate*)dayAsDate {
    return _dayAsDate;
}

- (void)setInCurrentMonth:(BOOL)inCurrentMonth {
    _inCurrentMonth = inCurrentMonth;
    [self setNeedsDisplay];
}


#pragma mark UIView methods

- (void)drawRect:(CGRect)rect {
    if ([self isKindOfClass:[DSLCalendarDayView class]]) {
        // If this isn't a subclass of DSLCalendarDayView, use the default drawing
        [self drawBackground];
        [self drawBorders];
        [self drawDayNumber];
    }
}


#pragma mark Drawing

- (void)drawBackground {    
    if (self.isInCurrentMonth) {
        [self.fillColor setFill];
    }
    else {
        [self.fillColorNotCurrentMonth setFill];
    }
    UIRectFill(self.bounds);
    
    if(self.selectionState != DSLCalendarDayViewNotSelected) {
        UIImage *backgroundImage;
        switch (self.selectionState) {
            case DSLCalendarDayViewNotSelected:
                backgroundImage = nil;
                break;
                
            case DSLCalendarDayViewStartOfSelection:
                backgroundImage = [self selectedLeftBackgroundImage];
                break;
                
            case DSLCalendarDayViewEndOfSelection:
                backgroundImage = [self selectedRightBackgroundImage];
                break;
                
            case DSLCalendarDayViewWithinSelection:
                backgroundImage = [self selectedMiddleBackgroundImage];
                break;
                
            case DSLCalendarDayViewWholeSelection:
                backgroundImage = [self selectedWholeBackgroundImage];
                break;
        }
        if(backgroundImage) {
            [backgroundImage drawInRect:self.bounds];
        }
    }
}

- (void)drawBorders {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1.0);
    
    CGContextSaveGState(context);    
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    CGContextMoveToPoint(context, 0.5, self.bounds.size.height - 0.5);
    CGContextAddLineToPoint(context, 0.5, 0.5);
    CGContextAddLineToPoint(context, self.bounds.size.width - 0.5, 0.5);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    if (self.isInCurrentMonth) {
        CGContextSetStrokeColorWithColor(context, self.bevelColor.CGColor);
    }
    else {
        CGContextSetStrokeColorWithColor(context, self.bevelColorNotCurrentMonth.CGColor);
    }
    CGContextMoveToPoint(context, self.bounds.size.width - 0.5, 0.0);
    CGContextAddLineToPoint(context, self.bounds.size.width - 0.5, self.bounds.size.height - 0.5);
    CGContextAddLineToPoint(context, 0.0, self.bounds.size.height - 0.5);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

- (void)drawDayNumber {
    UIFont *font;
    if (self.selectionState == DSLCalendarDayViewNotSelected) {
        if (self.isInCurrentMonth) {
            [self.textColor set];
            font = [self textFont];
        }
        else {
            [self.textColorNotInMonth set];
            font = [self textFontNotInMonth];
        }
    }
    else {
        [self.selectedTextColor set];
        font = [self selectedTextFont];
    }
    
    CGSize textSize = [_labelText sizeWithFont:font];
    
    CGRect textRect = CGRectMake(ceilf(CGRectGetMidX(self.bounds) - (textSize.width / 2.0)), ceilf(CGRectGetMidY(self.bounds) - (textSize.height / 2.0)), textSize.width, textSize.height);
    [_labelText drawInRect:textRect withFont:font];
}

@end
