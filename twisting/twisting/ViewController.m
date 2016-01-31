//
//  ViewController.m
//  twisting
//
//  Created by Rahul Sundararaman on 1/30/16.
//  Copyright © 2016 Rahul Sundararaman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.hidden = YES;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = (screenRect.size.width/2)-10;
    CGFloat screenHeight = (screenRect.size.height/2)-20;
    UIImageView *imageHolder = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth, screenHeight, 400, 400)];
    imageHolder.center = self.view.center;
    UIImage *image = [UIImage imageNamed:@"twistLogo.png"];
    imageHolder.image = image;
    [self.view addSubview:imageHolder];
    UISwipeGestureRecognizer * swipeup=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeup:)];
    swipeup.direction=UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeup];
    UILabel *label =  [[UILabel alloc] initWithFrame: CGRectMake(screenWidth, (screenHeight*2)-30, 50, 50)];
    label.text = @"^"; //etc...
    label.font = [UIFont fontWithName:@"Times New Roman" size:50.0];
    UIColor *color = [UIColor orangeColor];
    [label setTextColor:color];
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)swipeup:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self performSegueWithIdentifier:@"truesegue" sender:self];

}
@end
