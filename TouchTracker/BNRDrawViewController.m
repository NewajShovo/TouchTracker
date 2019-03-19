//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by Shafiq Shovo on 19/3/19.
//  Copyright © 2019 Shafiq Shovo. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@implementation BNRDrawViewController

- (void) loadView
{
    self.view = [ [ BNRDrawView alloc] initWithFrame: CGRectZero];
}

@end
