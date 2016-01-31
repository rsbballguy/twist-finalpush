//
//  MapboxViewController.m
//  twisting
//
//  Created by Rahul Sundararaman on 1/31/16.
//  Copyright © 2016 Rahul Sundararaman. All rights reserved.
//

#import "MapboxViewController.h"
#import <MessageUI/MessageUI.h>

@interface MapboxViewController () <MFMailComposeViewControllerDelegate>

@end
UITextView *startView, *endView;

@implementation MapboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    startView = [[UITextView alloc] initWithFrame:CGRectMake(80, 140, 200, 50)];
    
    //To make the border look very close to a UITextField
    [startView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [startView.layer setBorderWidth:2.0];
    
    //The rounded corner part, where you specify your view's corner radius:
    startView.layer.cornerRadius = 5;
    startView.clipsToBounds = YES;
    [self.view addSubview:startView];
    
    endView = [[UITextView alloc] initWithFrame:CGRectMake(80, 240, 200, 50)];
    
    //To make the border look very close to a UITextField
    [endView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [endView.layer setBorderWidth:2.0];
    
    //The rounded corner part, where you specify your view's corner radius:
    endView.layer.cornerRadius = 5;
    endView.clipsToBounds = YES;
    [self.view addSubview:endView];
    
    UILabel *to =  [[UILabel alloc] initWithFrame: CGRectMake(80, 190, 200, 50)];
    to.text = @"to"; //etc...
    to.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:to];
    
    UILabel *from =  [[UILabel alloc] initWithFrame: CGRectMake(20, 140, 50, 50)];
    from.text = @"Start: "; //etc...
    from.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:from];
    
    UILabel *dest =  [[UILabel alloc] initWithFrame: CGRectMake(20, 240, 50, 50)];
    dest.text = @"End: "; //etc...
    dest.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:dest];
    
    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(80, 295, 100, 50)];

    [startButton setCenter:CGPointMake(180, 350)];
    [startButton setTitle:@"Directions" forState:UIControlStateNormal]; // To set the title
    [startButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(directions:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
}
-(void)directions:(UIButton*)sender{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = [[[@"get-route " stringByAppendingString:startView.text] stringByAppendingString:@" + "] stringByAppendingString:endView.text];
        controller.recipients = [NSArray arrayWithObjects:@"3238920251", nil];
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    if(result == MessageComposeResultSent){
        UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Sent"
                                                           message:@"You will soon recieve a text with directions"
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
       // startView.text = @"";
       // endView.text = @"";
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
