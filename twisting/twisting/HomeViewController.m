//
//  HomeViewController.m
//  twisting
//
//  Created by Rahul Sundararaman on 1/30/16.
//  Copyright © 2016 Rahul Sundararaman. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _pageTitles = @[@"abcd (1).png", @"fbLogIn.png", @"searchButton (1).png", @"tbutt.png"];
    _pageImages = @[@"ff.png", @"facebook.png", @"googleLogo (1).png", @"twitter.png"];
    UIColor *color1 = [UIColor colorWithRed:63/255.0f green:86/255.0f blue:155/255.0f alpha:1.0f];
    UIColor *color2 = [UIColor colorWithRed:0/255.0f green:172/255.0f blue:237/255.0f alpha:1.0f];
    UIColor *color3 = [UIColor whiteColor];
    UIColor *color4 = [UIColor colorWithRed:212/255.0f green:64/255.0f blue:49/255.0f alpha:1.0f];
    _bgcolors = @[color3, color1, color4, color2];
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    if(index == 0){
        pageContentViewController.app = @"mapbox";
    }
    else if(index == 1){
        pageContentViewController.app = @"facebook";
    }
    else if(index == 2){
        pageContentViewController.app= @"google";
    }
    else if(index == 3){
        pageContentViewController.app = @"twitter";
    }
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.buttonimg = self.pageTitles[index];
    pageContentViewController.titleText = @"";
    pageContentViewController.backgroundcolor = self.bgcolors[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)startWalkthrough:(id)sender {
}
@end
