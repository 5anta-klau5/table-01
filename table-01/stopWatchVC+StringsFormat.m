//
//  StopwatchVC+StringsFormat.m
//  table-01
//
//  Created by Serhii Serhiienko on 9/26/16.
//  Copyright © 2016 Serhii Serhiienko. All rights reserved.
//

#import "StopwatchVC+StringsFormat.h"

@implementation StopwatchVC (StringsFormat)

- (NSString *)createTimeFromSeconds:(double)seconds {
    double extraSeconds = fmod(seconds, 60.0);
    int minutes = (int)seconds / 60;
    
    NSString *sec = [NSString stringWithFormat:@"%.2f", extraSeconds];
    if (extraSeconds < 10) {
        sec = [NSString stringWithFormat:@"0%.2f", extraSeconds];
    }
    
    NSString *min = [NSString stringWithFormat:@"%i", minutes];
    if (minutes < 10) {
        min = [NSString stringWithFormat:@"0%i", minutes];
    }
    
    NSString *timeText = [NSString stringWithFormat:@"%@:%@", min, sec];
    
    return timeText;
}

@end
