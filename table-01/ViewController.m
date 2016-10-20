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
int count = 0;

typedef enum:NSUInteger {
    WebCellType,
    SimpleCellType
} CellType;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    count++;
    [self setTitle:[NSString stringWithFormat:NSLocalizedString(@"Page #%d", nil) , count]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated {
    if (![self.navigationController.viewControllers containsObject:self]) {
        count--;
    }
}
/*
- (IBAction)nextBtnPressed:(UIButton *)sender {
    NSLog(@"Button pressed");
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellType type = [self cellTypeForIndexPath:indexPath];
    
    if (type == WebCellType) {
        CellType01 *cell = (CellType01 *)[tableView dequeueReusableCellWithIdentifier:@"CellType01" forIndexPath:indexPath];
        cell.nameLabel.text = NSLocalizedString(@"First name", nil);
        cell.subNameLabel.text = NSLocalizedString(@"Subname", nil);
        cell.cellImageView.image = [UIImage imageNamed:@"img-pok.jpg"];
        cell.cellImageView.layer.cornerRadius = cell.cellImageView.frame.size.width / 2;
        cell.cellImageView.clipsToBounds = YES;
        cell.cellImageView.layer.borderWidth = 1.0f;
        cell.cellImageView.layer.borderColor = [UIColor colorWithRed:30/255 green:144/255 blue:1 alpha:1.0].CGColor;
        return cell;
    } else {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CellType02" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Some cell %ld", nil) , (long)indexPath.row];
        return cell;
    }
    
}

- (CellType)cellTypeForIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return WebCellType;
    } else {
        return SimpleCellType;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CellType type = [self cellTypeForIndexPath:indexPath];
    
    if (type == SimpleCellType) {
        [self openTheSameViewController];
    } else {
        [self openWebViewController];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)openTheSameViewController {
    ViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"MyVC"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)openWebViewController {
    UIViewController *controllerForWeb = [UIViewController new];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    NSString *urlString = @"https://www.google.com.ua";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [controllerForWeb.view addSubview:webView];
    [self.navigationController pushViewController:controllerForWeb animated:YES];
}

@end
