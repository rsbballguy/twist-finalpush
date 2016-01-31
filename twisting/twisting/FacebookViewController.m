//
//  FacebookViewController.m
//  twisting
//
//  Created by Rahul Sundararaman on 1/31/16.
//  Copyright © 2016 Rahul Sundararaman. All rights reserved.
//

#import "FacebookViewController.h"
#import <MessageUI/MessageUI.h>
@interface FacebookViewController ()

@end
UITextView *texty;
@implementation FacebookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIColor *color = [UIColor colorWithRed:63/255.0f green:86/255.0f blue:155/255.0f alpha:1.0f];
    self.view.backgroundColor = color;
    texty = [[UITextView alloc] initWithFrame:CGRectMake(85, 150, 200, 40)];
    
    //To make the border look very close to a UITextField
    [texty.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [texty.layer setBorderWidth:2.0];
    
    //The rounded corner part, where you specify your view's corner radius:
    texty.layer.cornerRadius = 5;
    texty.clipsToBounds = YES;
    [texty setFont:[UIFont systemFontOfSize:17]];
    texty.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:texty];
    
    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(80, 295, 100, 50)];
    
    [startButton setCenter:CGPointMake(180, 280)];
    [startButton setTitle:@"Post to Wall" forState:UIControlStateNormal]; // To set the title
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(post:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];

}

-(void)post:(UIButton*)sender{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = [@"post-to-wall " stringByAppendingString:texty.text];
        controller.recipients = [NSArray arrayWithObjects:@"3238920251", nil];
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    if(result == MessageComposeResultSent){
        texty.text = @"";
        UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Posted!"
                                                           message:@"Your status has been updated"
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
