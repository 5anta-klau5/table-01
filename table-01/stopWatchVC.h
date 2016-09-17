//
//  stopWatchVC.h
//  table-01
//
//  Created by Serhii Serhiienko on 8/25/16.
//  Copyright © 2016 Serhii Serhiienko. All rights reserved.
//

#import "UIKit/UIKit.h"
#import <Math.h>

@interface stopWatchVC : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    NSTimer *myTimer;
}

@property (retain, nonatomic) NSTimer *myTimer;
@property (weak, nonatomic) IBOutlet UILabel *watchText;
@property (weak, nonatomic) IBOutlet UILabel *circleTimeText;
@property (weak, nonatomic) IBOutlet UIButton *startStopBtn;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
@property (weak, nonatomic) IBOutlet UITableView *circleTable;

- (IBAction)pushStartStopBtn:(id)sender;
- (IBAction)pushResetBtn:(id)sender;

@end
