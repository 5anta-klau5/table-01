//
//  stopWatchVC.m
//  table-01
//
//  Created by Serhii Serhiienko on 8/25/16.
//  Copyright © 2016 Serhii Serhiienko. All rights reserved.
//

#import "stopWatchVC.h"

@implementation stopWatchVC

BOOL started = FALSE;
double startTime;
double beforeStopTime = 0.0;

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
        double stopTime = [NSDate timeIntervalSinceReferenceDate];
        beforeStopTime += stopTime - startTime;
        [self stopTimer];
        
        [self.startStopBtn setTitle:@"Start" forState:UIControlStateNormal];
        [self.startStopBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        started = FALSE;
    }
}

- (void)resetCount {
    [self stopTimer];
    beforeStopTime = 0.0;
    startTime = 0.0;
    [self.startStopBtn setTitle:@"Start" forState:UIControlStateNormal];
    [self.startStopBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    started = FALSE;
    [self.watchText setText:@"00:00.00"];
}

- (void)startTimer {
    startTime = [NSDate timeIntervalSinceReferenceDate];
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                    target:self
                                                  selector:@selector(ticTac)
                                                  userInfo:nil
                                                   repeats:YES];
}

- (void)stopTimer {
    if ([self.myTimer isValid]) {
        [self.myTimer invalidate];
    }
//    self.myTimer = nil;
}

- (void)ticTac {
    if (started) {
        double currentTime = [NSDate timeIntervalSinceReferenceDate];
        double totalSeconds = currentTime - startTime + beforeStopTime;
        double seconds = fmod(totalSeconds, 60.0);
        int minutes = (int)totalSeconds / 60;
        
        NSString *sec = [NSString stringWithFormat:@"%.2f", seconds];
        if (seconds < 10) {
            sec = [NSString stringWithFormat:@"0%.2f", seconds];
        }
        
        NSString *min = [NSString stringWithFormat:@"%i", minutes];
        if (minutes < 10) {
            min = [NSString stringWithFormat:@"0%i", minutes];
        }
        
        NSString *time = [NSString stringWithFormat:@"%@:%@", min, sec];
        [self.watchText setText:time];
        
    }
}

@end
