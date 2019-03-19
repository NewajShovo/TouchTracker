//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by Shafiq Shovo on 19/3/19.
//  Copyright © 2019 Shafiq Shovo. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"
#import "BNRDrawViewController.h"



@interface BNRDrawView()

//@property (nonatomic,strong) BNRLine *currentLine;
@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic,strong) NSMutableArray *finishedLines;

@end


@implementation BNRDrawView

-(instancetype) initWithFrame: (CGRect) r
{
    self = [ super initWithFrame:r];
    
    if(self)
    {
        self.linesInProgress = [ [ NSMutableDictionary alloc] init];
        self.finishedLines = [ [ NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled= YES;
    }
    return self;
}
- (void) strokeLine: (BNRLine *) line
{
    UIBezierPath *bp = [ UIBezierPath bezierPath];
    bp.lineWidth =10;
    bp.lineCapStyle = kCGLineCapRound;
    [bp moveToPoint:line.begin];
    [bp addLineToPoint: line.end];
    [bp stroke];
}

- (void) drawRect:(CGRect)rect
{
    
    [ [ UIColor redColor] set];
    for (BNRLine *line in self.finishedLines)
    {
        [self strokeLine:line];
    }
    [ [ UIColor blackColor] set];
    
    for (NSValue *key in self.linesInProgress)
    {
        [ self strokeLine:self.linesInProgress[key]];
    }
   /*
    if(self.currentLine)
    {
        [ [ UIColor redColor] set];
        [ self strokeLine:self.currentLine];
    }
    */
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    /*
    UITouch *t = [touches anyObject];
    CGPoint location = [ t locationInView:self];
    
    self.currentLine = [ [ BNRLine alloc] init];
    self.currentLine.begin = location;
    self.currentLine.end = location;
    [self setNeedsDisplay];
     */
    NSLog(@"%@", NSStringFromSelector(_cmd));
    for (UITouch *t in touches)
    {
        CGPoint location = [ t locationInView:self];
        BNRLine *line = [ [ BNRLine alloc] init];
        line.begin = location;
        line.end = location;
        NSValue *key = [ NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
    }
    [self setNeedsDisplay];
}
- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    /*UITouch *t = [touches anyObject];
    CGPoint location = [ t locationInView:self];
    self.currentLine.end = location;
    [self setNeedsDisplay];
     */
    NSLog (@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches)
    {
        NSValue *key = [ NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        line.end = [t locationInView:self];
    }
    [self setNeedsDisplay];
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    /*[self.finishedLines addObject:self.currentLine];
    self.currentLine = nil;
    [self setNeedsDisplay];
     */
    NSLog (@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches)
    {
        NSValue *key = [ NSValue valueWithNonretainedObject:t];
        NSLog(@"%@",key);
        BNRLine *line = self.linesInProgress[key];
        //line.end = [t locationInView:self];
        ///NSArray *xx= key;
        //NSLog(@"%@",xx);
       
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectsForKeys:@[key]];
         NSLog(@"I am here");
    }
    [self setNeedsDisplay];
}

- (void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog (@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches)
    {
        NSValue *key = [ NSValue valueWithNonretainedObject:t];
        [self.linesInProgress removeObjectsForKeys:@[key]];
    }
    [self setNeedsDisplay];
    
    
    
}



@end
