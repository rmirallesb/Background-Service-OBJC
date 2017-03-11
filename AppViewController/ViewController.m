//
//  ViewController.m
//  Background-Service-OBJC
//
//  Created by Raúl on 11/3/17.
//

#import "ViewController.h"
#import "Service.h"
#import "HeritageService.h"

@interface ViewController ()
<ServiceDelegate>

@property (strong, nonatomic)        Service     *service;
@property (nonatomic)                int         counter;
@property (nonatomic)                NSInteger   seconds;

// IBOutlet
@property (weak, nonatomic) IBOutlet UILabel     *lblResult;
@property (weak, nonatomic) IBOutlet UITextField *tfRepeats;
@property (weak, nonatomic) IBOutlet UIButton    *btnStart;
@property (weak, nonatomic) IBOutlet UIButton    *btnStop;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tfRepeats  .text       = @"1";
    self.seconds                = [self.tfRepeats.text integerValue];
    self.service                = [[HeritageService alloc] initWithFrequency:self.seconds];
    self.service    .delegate   = self;
    
    self.btnStart   .enabled    = YES;
    self.btnStop    .enabled    = NO;
    self.tfRepeats  .enabled    = YES;
    self.tfRepeats  .keyboardType = UIKeyboardTypeNumberPad;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];
    self.lblResult  .text       = @"Waiting to start";
}

- (IBAction)btnStart:(id)sender {
    NSCharacterSet *notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([self.tfRepeats.text rangeOfCharacterFromSet:notDigits].location == NSNotFound) {
        self.lblResult  .text       = (self.counter >= 1) ? @"Service continues": @"Service started";
        self.btnStart   .enabled    = (sender == self.btnStop) ? YES : NO;
        self.btnStop    .enabled    = (sender != self.btnStop) ? YES : NO;
        self.tfRepeats  .enabled    = NO;
        [self.service startService];
    } else {
        UIAlertController *view = [UIAlertController alertControllerWithTitle:@"Alert"
                                     message:@"Enter a number"
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction     *ok   = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                             }];
        
        [view addAction:ok];
        [self presentViewController:view animated:YES completion:nil];
    }
}

- (IBAction)btnStop:(id)sender {
    self.lblResult  .text       = @"Service stopped";
    self.btnStart   .enabled    = (sender != self.btnStart) ? YES : NO;
    self.btnStop    .enabled    = (sender == self.btnStart) ? YES : NO;
    [self.service stopService];
}

- (void)drawServiceRepeats {
    self.counter++;
    self.lblResult  .text       = [NSString stringWithFormat:@"%d",self.counter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
