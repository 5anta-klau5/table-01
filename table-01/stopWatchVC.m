//
//  stopWatchVC.m
//  table-01
//
//  Created by Serhii Serhiienko on 8/25/16.
//  Copyright © 2016 Serhii Serhiienko. All rights reserved.
//

#import "stopWatchVC.h"

@implementation stopWatchVC
int seconds = 0;
int minutes = 0;
BOOL started = FALSE;

- (IBAction)pushStartStopBtn:(id)sender {
    [self startStopCount];
}

- (IBAction)pushResetBtn:(id)sender {
    [self resetCount];
}

- (void)startStopCount {
    if (!started) {
        [self startTimer];
        [self.startStopBtn setTitle:@"Stop" forState:UIControlStateNormal];
        [self.startStopBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        started = TRUE;

    } else {
        [self stopTimer];
        [self.startStopBtn setTitle:@"Start" forState:UIControlStateNormal];
        [self.startStopBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        started = FALSE;
    }
}

- (void)resetCount {
    seconds = 0;
    minutes = 0;
    [self stopTimer];
    [self.startStopBtn setTitle:@"Start" forState:UIControlStateNormal];
    [self.startStopBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    started = FALSE;
    [self.watchText setText:@"00 : 00"];
}

- (void)startTimer {
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                    target:self
                                                  selector:@selector(ticTac)
                                                  userInfo:nil
                                                   repeats:YES];
}

- (void)stopTimer {
    if (self.myTimer != nil) {
        [self.myTimer invalidate];
    }
    self.myTimer = nil;
}

- (void)ticTac {
    if (started) {
        NSString *sec = [NSString stringWithFormat:@"%i", seconds];
        if (seconds < 10) {
            sec = [NSString stringWithFormat:@"0%i", seconds];
        }
        
        NSString *min = [NSString stringWithFormat:@"%i", minutes];
        if (minutes < 10) {
            min = [NSString stringWithFormat:@"0%i", minutes];
        }
        
        NSString *time = [NSString stringWithFormat:@"%@ : %@", min, sec];
        [self.watchText setText:time];
        
        seconds++;
        if (seconds > 59) {
            seconds = 0;
            minutes++;
        }
    }
}

@end
