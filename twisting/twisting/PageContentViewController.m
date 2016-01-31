//
//  PageContentViewController.m
//  twisting
//
//  Created by Rahul Sundararaman on 1/30/16.
//  Copyright © 2016 Rahul Sundararaman. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = self.backgroundcolor;
    self.backgroundImageView.backgroundColor = self.backgroundcolor;
    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    self.titleLabel.text = self.titleText;
    self.buttonImage.image = [UIImage imageNamed:self.buttonimg];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked:)];
    self.buttonImage.userInteractionEnabled = YES;
    [self.buttonImage addGestureRecognizer:tapGesture];
}

- (void)imageClicked:(UITapGestureRecognizer *) gestureRecognizer
{
    
    if([self.app  isEqual: @"facebook"]){
        [self performSegueWithIdentifier:@"facebooksegue" sender:self];
    }
    else if([self.app  isEqual: @"twitter"]){
        [self performSegueWithIdentifier:@"twittersegue" sender:self];
    }
    else if([self.app  isEqual: @"mapbox"]){
        [self performSegueWithIdentifier:@"mapboxsegue" sender:self];
    }
    else if([self.app  isEqual: @"google"]){
        [self performSegueWithIdentifier:@"googlesegue" sender:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginClicked:(id)sender {
}
@end
