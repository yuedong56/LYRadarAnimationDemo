//
//  AppDelegate.m
//  LYRadarAnimationDemo
//
//  Created by yuedongkui on 2016/12/22.
//  Copyright © 2016年 LY. All rights reserved.
//

#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "LYRadarIndicatorView.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (strong) LYRadarIndicatorView *indicatorView;
@end


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

    self.window.contentView.wantsLayer = YES;
    self.window.contentView.layer.backgroundColor = [[NSColor whiteColor] CGColor];
    
    self.indicatorView = [[LYRadarIndicatorView alloc] initWithFrame:NSMakeRect(0, 0, 1000, 1000)];
    NSRect frame = self.indicatorView.frame;
    frame.origin.x = -(self.indicatorView.bounds.size.width-self.window.contentView.frame.size.width)/2;
    frame.origin.y = -(self.indicatorView.bounds.size.height-self.window.contentView.frame.size.height)/2;
    self.indicatorView.frame = frame;
    
    self.indicatorView.wantsLayer = YES;
    self.indicatorView.layer.backgroundColor = [[NSColor clearColor] CGColor];
//    self.indicatorView.layer.backgroundColor = [[NSColor redColor] CGColor];

    [self.window.contentView addSubview:self.indicatorView];
    
    //
    self.indicatorView.layer.position = CGPointMake(self.window.contentView.bounds.size.width/2, self.window.contentView.bounds.size.height/2);
    self.indicatorView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    //
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    BOOL indicatorClockwise = NO;//顺时针
    rotationAnimation.toValue = [NSNumber numberWithFloat: (indicatorClockwise?1:-1) * M_PI * 2.0 ];
    rotationAnimation.duration = 360.f/60.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = INT_MAX;
    [_indicatorView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
