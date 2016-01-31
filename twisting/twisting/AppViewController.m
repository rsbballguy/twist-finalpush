//
//  AppViewController.m
//  twisting
//
//  Created by Rahul Sundararaman on 1/30/16.
//  Copyright © 2016 Rahul Sundararaman. All rights reserved.
//

#import "AppViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>
@interface AppViewController () <UITextFieldDelegate, MFMailComposeViewControllerDelegate>
@end

@implementation AppViewController
int count = 0;
UITextView *textView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0/255.0f green:172/255.0f blue:237/255.0f alpha:1.0f];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter-rsbballguy.c9users.io/"]];
    textView = [[UITextView alloc] initWithFrame:CGRectMake(30, 220, 200, 75)];
    
    //To make the border look very close to a UITextField
    [textView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [textView.layer setBorderWidth:2.0];
    
    //The rounded corner part, where you specify your view's corner radius:
    textView.layer.cornerRadius = 5;
    textView.clipsToBounds = YES;
    [self.view addSubview:textView];
    
    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(240, 225, 100, 50)];
    [startButton setBackgroundImage:[[UIImage imageNamed:@"tweet.png"] stretchableImageWithLeftCapWidth:110.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [startButton setCenter:CGPointMake(300, 255)];
    [startButton addTarget:self action:@selector(sendTweet:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
}
-(void)sendTweet:(UIButton*)sender{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = [@"tweet " stringByAppendingString:textView.text];
        controller.recipients = [NSArray arrayWithObjects:@"3238920251", nil];
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    if(result == MessageComposeResultSent){
        UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Tweeted"
                                                           message:@"Your tweet was sent successfully"
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
        textView.text = @"";
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

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.placeholder = nil;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.placeholder = @"Tweet this text";
}

@end
