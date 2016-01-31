//
//  HomeViewController.h
//  twisting
//
//  Created by Rahul Sundararaman on 1/30/16.
//  Copyright © 2016 Rahul Sundararaman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface HomeViewController : UIViewController<UIPageViewControllerDataSource>
- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;
@property (strong, nonatomic) NSArray *bgcolors;
@property (strong, nonatomic) NSArray *buttonImages;
@end
