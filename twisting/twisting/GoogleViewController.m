//
//  GoogleViewController.m
//  twisting
//
//  Created by Rahul Sundararaman on 1/31/16.
//  Copyright © 2016 Rahul Sundararaman. All rights reserved.
//

#import "GoogleViewController.h"
#import <MessageUI/MessageUI.h>
@interface GoogleViewController ()

@end
UITextView *textv;
@implementation GoogleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIColor *color = [UIColor colorWithRed:212/255.0f green:64/255.0f blue:49/255.0f alpha:1.0f];
    self.view.backgroundColor = color;
    textv = [[UITextView alloc] initWithFrame:CGRectMake(90, 150, 200, 40)];
    
    //To make the border look very close to a UITextField
    [textv.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [textv.layer setBorderWidth:2.0];
    
    //The rounded corner part, where you specify your view's corner radius:
    textv.layer.cornerRadius = 5;
    textv.clipsToBounds = YES;
    [textv setFont:[UIFont systemFontOfSize:17]];
    textv.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textv];
    
    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(80, 295, 100, 50)];
    
    [startButton setCenter:CGPointMake(180, 280)];
    [startButton setTitle:@"Search" forState:UIControlStateNormal]; // To set the title
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];

}
-(void)search:(UIButton*)sender{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = [@"search " stringByAppendingString:textv.text];
        controller.recipients = [NSArray arrayWithObjects:@"3238920251", nil];
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    if(result == MessageComposeResultSent){
        UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Results found!"
                                                           message:@"Check your text messages!"
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
        [theAlert show];
        
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

@end
