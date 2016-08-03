//
//  ViewController.m
//  table-01
//
//  Created by Serhii Serhiienko on 7/27/16.
//  Copyright © 2016 Serhii Serhiienko. All rights reserved.
//

#import "ViewController.h"
#import "CellType01.h"

@interface ViewController ()

@end

@implementation ViewController
int count = 1;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setTitle:[NSString stringWithFormat:@"Page #%d", count]];
    count++;
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated {
    if (![self.navigationController.viewControllers containsObject:self]) {
        count--;
    }
}

- (IBAction)nextBtnPressed:(UIButton *)sender {
    NSLog(@"Button pressed");
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CellType01 *cell = (CellType01 *)[tableView dequeueReusableCellWithIdentifier:@"CellType01" forIndexPath:indexPath];
        cell.nameLabel.text = @"First name";
        cell.subNameLabel.text = @"Subname 1st";
        cell.cellImageView.image = [UIImage imageNamed:@"img-pok.jpg"];
        //    NSLog(@"row:%ld",(long)indexPath.row);
        return cell;
    } else {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CellType02" forIndexPath:indexPath];
        cell.textLabel.text = @"Some title";
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!(indexPath.row == 0)) {
        ViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"MyVC"];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
