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

StopwatchStateType currentWatchState = StopwatchStateReady;
double startTime;
double beforeStopTime = 0.0;
double beforeStopCircleTime = 0.0;
double lastCircleTime = 0.0;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    circleList = [[NSMutableArray alloc] init];
}


- (IBAction)pushStartStopBtn:(id)sender {
    if (currentWatchState == StopwatchStateReady || currentWatchState == StopwatchStatePaused) {
        [self setStopwatchState:StopwatchStateStart];
    } else if (currentWatchState == StopwatchStateStarted) {
        [self setStopwatchState:StopwatchStatePause];
    }
}

- (IBAction)pushResetBtn:(id)sender {
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

- (void)changeButtonsForState:(StopwatchStateType)state {
    if (state == StopwatchStateStart) {
        [self.startStopBtn setTitle:NSLocalizedString(@"Pause", nil) forState:UIControlStateNormal];
        [self.startStopBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        self.resetBtn.enabled = YES;
        [self.resetBtn setTitle:NSLocalizedString(@"Circle", nil) forState:UIControlStateNormal];
        [self.resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    if (state == StopwatchStatePause) {
        [self.startStopBtn setTitle:NSLocalizedString(@"Resume", nil) forState:UIControlStateNormal];
        [self.startStopBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        
        [self.resetBtn setTitle:NSLocalizedString(@"Reset", nil) forState:UIControlStateNormal];
        [self.resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    if (state == StopwatchStateReset) {
        [self.startStopBtn setTitle:NSLocalizedString(@"Start", nil) forState:UIControlStateNormal];
        [self.startStopBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        
        [self.resetBtn setTitle:NSLocalizedString(@"Circle", nil)  forState:UIControlStateNormal];
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
        
        double circleTime = currentTime - lastCircleTime + beforeStopCircleTime;
        
        NSString *timeText = [self createTimeFromSeconds:totalSeconds];
        [self.watchText setText:timeText];
        
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

    cell.circleNmbrTxt.text = [NSString stringWithFormat:NSLocalizedString(@"Circle %ld", nil), itemsCount - currentRow];
    cell.circleTimeTxt.text = [circleList objectAtIndex:itemsCount - currentRow - 1];
    return cell;
}

@end
