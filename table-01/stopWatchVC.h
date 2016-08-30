//
//  stopWatchVC.h
//  table-01
//
//  Created by Serhii Serhiienko on 8/25/16.
//  Copyright © 2016 Serhii Serhiienko. All rights reserved.
//

#import "ViewController.h"
#import <Math.h>

@interface stopWatchVC : ViewController {
    NSTimer *myTimer;
}

@property (retain, nonatomic) NSTimer *myTimer;
@property (weak, nonatomic) IBOutlet UILabel *watchText;
@property (weak, nonatomic) IBOutlet UIButton *startStopBtn;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;

- (IBAction)pushStartStopBtn:(id)sender;
- (IBAction)pushResetBtn:(id)sender;

@end
