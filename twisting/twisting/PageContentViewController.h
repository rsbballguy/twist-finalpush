//
//  PageContentViewController.h
//  twisting
//
//  Created by Rahul Sundararaman on 1/30/16.
//  Copyright © 2016 Rahul Sundararaman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIImageView *buttonImage;
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;
@property UIColor *backgroundcolor;
@property NSString *buttonimg;
@property NSString *app;
@end
