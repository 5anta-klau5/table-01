//
//  StopwatchVC.m
//  table-01
//
//  Created by Serhii Serhiienko on 8/25/16.
//  Copyright © 2016 Serhii Serhiienko. All rights reserved.
//

#import "StopwatchVC.h"
#import "CircleCell.h"
#import "stopWatchVC+StringsFormat.h"

@implementation StopwatchVC
{
    NSMutableArray *circleList;
}

typedef enum: NSUInteger {
    StopwatchStateReady,
    StopwatchStateStart,
    StopwatchStateStarted,
    StopwatchStatePause,
    StopwatchStatePaused,
    StopwatchStateCircle,
    StopwatchStateReset
} StopwatchStateType;

//BOOL started = FALSE;
StopwatchStateType currentWatchState = StopwatchStateReady;
double startTime;
double beforeStopTime = 0.0;
double beforeStopCircleTime = 0.0;
double lastCircleTime = 0.0;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    circleList = [[NSMutableArray alloc] init];
//    circleList = [NSMutableArray arrayWithCapacity:50];
}


- (IBAction)pushStartStopBtn:(id)sender {
//    [self startStopCount];
    if (currentWatchState == StopwatchStateReady || currentWatchState == StopwatchStatePaused) {
        [self setStopwatchState:StopwatchStateStart];
    } else if (currentWatchState == StopwatchStateStarted) {
        [self setStopwatchState:StopwatchStatePause];
    }
}

- (IBAction)pushResetBtn:(id)sender {
//    [self resetCount];
    if (currentWatchState == StopwatchStateStarted) {
        [self setStopwatchState:StopwatchStateCircle];
    } else if (currentWatchState == StopwatchStatePaused) {
        [self setStopwatchState:StopwatchStateReset];
    }
}

- (void)setStopwatchState:(StopwatchStateType)state {
    if (state == StopwatchStateStart) {
        currentWatchState = StopwatchStateStarted;
        [self startTimer];
    } else if (state == StopwatchStatePause) {
        double stopTime = [NSDate timeIntervalSinceReferenceDate];
        beforeStopTime += stopTime - startTime;
        beforeStopCircleTime += stopTime - lastCircleTime;
        [self stopTimer];
        currentWatchState = StopwatchStatePaused;
    } else if (state == StopwatchStateCircle) {
        [circleList addObject:self.circleTimeText.text];
        lastCircleTime = [NSDate timeIntervalSinceReferenceDate];
        beforeStopCircleTime = 0.0;
        [self.circleTable reloadData];
    } else if (state == StopwatchStateReset) {
        [self stopTimer];
        startTime = 0.0;
        beforeStopTime = 0.0;
        beforeStopCircleTime = 0.0;
        lastCircleTime = 0.0;
        [circleList removeAllObjects];
        currentWatchState = StopwatchStateReady;
        [self.watchText setText:@"00:00.00"];
        [self.circleTimeText setText:@"00:00.00"];
        [self.circleTable reloadData];
    }
    [self changeButtonsForState:state];
}

//- (void)startStopCount {
//    if (currentWatchState == StopwatchStateReady || currentWatchState == StopwatchStatePaused) {
//        currentWatchState = StopwatchStateStarted;
//        [self startTimer];
////        [self.startStopBtn setTitle:@"Pause" forState:UIControlStateNormal];
////        [self.startStopBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
////        
////        self.resetBtn.enabled = YES;
////        [self.resetBtn setTitle:@"Circle" forState:UIControlStateNormal];
////        [self.resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self changeButtons];
//        return;
//    }
//
//    if (currentWatchState == StopwatchStateStarted) {
//        double stopTime = [NSDate timeIntervalSinceReferenceDate];
//        beforeStopTime += stopTime - startTime;
//        beforeStopCircleTime += stopTime - lastCircleTime;
//        [self stopTimer];
//        
////        [self.startStopBtn setTitle:@"Resume" forState:UIControlStateNormal];
////        [self.startStopBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
////        
////        [self.resetBtn setTitle:@"Reset" forState:UIControlStateNormal];
////        [self.resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        currentWatchState = StopwatchStatePaused;
//        [self changeButtons];
//        return;
//    }
//}

//- (void)resetCount {
//    if (currentWatchState == StopwatchStateStarted) {
////        NSLog(@"%@", self.circleTimeText.text);
//        [circleList addObject:self.circleTimeText.text];
////        NSLog(@"%@", circleList);
//        
//        lastCircleTime = [NSDate timeIntervalSinceReferenceDate];
//        beforeStopCircleTime = 0.0;
//    }
//    
//    if (currentWatchState == StopwatchStatePaused) {
//    
//        [self stopTimer];
//        startTime = 0.0;
//        beforeStopTime = 0.0;
//        beforeStopCircleTime = 0.0;
//        lastCircleTime = 0.0;
//        [circleList removeAllObjects];
////        [self.startStopBtn setTitle:@"Start" forState:UIControlStateNormal];
////        [self.startStopBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
////        [self.resetBtn setTitle:@"Circle" forState:UIControlStateNormal];
////        [self.resetBtn setTitleColor:[UIColor colorWithRed:85/255.0
////                                                     green:85/255.0
////                                                      blue:85/255.0
////                                                     alpha:1.0] forState:UIControlStateNormal];
////        self.resetBtn.enabled = NO;
//        currentWatchState = StopwatchStateReady;
//        [self changeButtons];
//        [self.watchText setText:@"00:00.00"];
//        [self.circleTimeText setText:@"00:00.00"];
//    }
//    [self.circleTable reloadData];
//}

- (void)changeButtonsForState:(StopwatchStateType)state {
    if (state == StopwatchStateStart) {
        [self.startStopBtn setTitle:@"Pause" forState:UIControlStateNormal];
        [self.startStopBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        self.resetBtn.enabled = YES;
        [self.resetBtn setTitle:@"Circle" forState:UIControlStateNormal];
        [self.resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    if (state == StopwatchStatePause) {
        [self.startStopBtn setTitle:@"Resume" forState:UIControlStateNormal];
        [self.startStopBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        
        [self.resetBtn setTitle:@"Reset" forState:UIControlStateNormal];
        [self.resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    if (state == StopwatchStateReset) {
        [self.startStopBtn setTitle:@"Start" forState:UIControlStateNormal];
        [self.startStopBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        
        [self.resetBtn setTitle:@"Circle" forState:UIControlStateNormal];
        [self.resetBtn setTitleColor:[UIColor colorWithRed:85/255.0
                                                     green:85/255.0
                                                      blue:85/255.0
                                                     alpha:1.0] forState:UIControlStateNormal];
        self.resetBtn.enabled = NO;
    }

}

- (void)startTimer {
    startTime = [NSDate timeIntervalSinceReferenceDate];
    lastCircleTime = startTime;
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                    target:self
                                                  selector:@selector(ticTac)
                                                  userInfo:nil
                                                   repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.myTimer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    if ([self.myTimer isValid]) {
        [self.myTimer invalidate];
    }
//    self.myTimer = nil;
}

- (void)ticTac {
    if (currentWatchState == StopwatchStateStarted) {
        double currentTime = [NSDate timeIntervalSinceReferenceDate];
        double totalSeconds = currentTime - startTime + beforeStopTime;
//        double seconds = fmod(totalSeconds, 60.0);
//        int minutes = (int)totalSeconds / 60;
        
        double circleTime = currentTime - lastCircleTime + beforeStopCircleTime;
//        double circleSeconds = fmod(circleTime, 60.0);
//        int circleMinutes = (int)circleTime / 60;
        
//        NSString *sec = [NSString stringWithFormat:@"%.2f", seconds];
//        if (seconds < 10) {
//            sec = [NSString stringWithFormat:@"0%.2f", seconds];
//        }
//        
//        NSString *min = [NSString stringWithFormat:@"%i", minutes];
//        if (minutes < 10) {
//            min = [NSString stringWithFormat:@"0%i", minutes];
//        }
//        
//        NSString *timeText = [NSString stringWithFormat:@"%@:%@", min, sec];
        
        NSString *timeText = [self createTimeFromSeconds:totalSeconds];
        [self.watchText setText:timeText];
        
        
//        NSString *circleSec = [NSString stringWithFormat:@"%.2f", circleSeconds];
//        if (circleSeconds < 10) {
//            circleSec = [NSString stringWithFormat:@"0%.2f", circleSeconds];
//        }
//        
//        NSString *circleMin = [NSString stringWithFormat:@"%i", circleMinutes];
//        if (circleMinutes < 10) {
//            circleMin = [NSString stringWithFormat:@"0%i", circleMinutes];
//        }
//        
//        NSString *circleTimeText = [NSString stringWithFormat:@"%@:%@", circleMin, circleSec];
        
        NSString *circleTimeText = [self createTimeFromSeconds:circleTime];
        [self.circleTimeText setText:circleTimeText];
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [circleList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    long itemsCount = [circleList count];
    long currentRow = indexPath.row;
    CircleCell *cell = (CircleCell *)[tableView dequeueReusableCellWithIdentifier:@"circleTimeCell"];

    cell.circleNmbrTxt.text = [NSString stringWithFormat:@"Circle %ld", itemsCount - currentRow];
    cell.circleTimeTxt.text = [circleList objectAtIndex:itemsCount - currentRow - 1];
    return cell;
}

@end
