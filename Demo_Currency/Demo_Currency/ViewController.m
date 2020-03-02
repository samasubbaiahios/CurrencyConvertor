//
//  ViewController.m
//  Demo_Currency
//
//  Created by Ajr on 9/23/15.
//  Copyright (c) 2015 Subbu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIActivityIndicatorView *activityView;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.conversionsArray = [[NSMutableArray alloc] init];
    [self ConverterDataMethod];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) AllowedDropDownDelegateMethod: (AllowedDropDown *) sender
{
    [self releaseDropDown];
}

-(void)releaseDropDown
{
    dropDown = nil;
}

- (IBAction)convertCurrencyBtnActn:(id)sender
{
    for(int i =0; i< self.conversionsArray.count;i++)
    {
        if([self.fromBtn.titleLabel.text isEqualToString:[self.conversionsArray[i] valueForKey:@"from"]]&& [self.toConvertBtn.titleLabel.text isEqualToString:[self.conversionsArray[i] valueForKey:@"to"]])
        {
            float intval = [[self.conversionsArray[i] valueForKey:@"rate"] floatValue];
            
            float result = [self.numberTxtFld.text floatValue] * intval;
            NSLog(@"%f",intval);
            NSLog(@"%f",result);
            self.numberTxtFld.text = [NSString stringWithFormat:@"%f",result];
        }
    }
}

- (IBAction)fromCurrencyBtnActn:(id)sender
{
    if(dropDown == nil)
    {
        CGFloat f = 200;
        NSMutableArray *selectFromArray = [[NSMutableArray alloc] init];
        selectFromArray =[self.conversionsArray valueForKey:@"from"];
        NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:selectFromArray];
        NSArray *arrayWithoutDuplicates = [orderedSet array];
        NSLog(@"%@",arrayWithoutDuplicates);
        dropDown = [[AllowedDropDown alloc] showDropDown:sender :&f :arrayWithoutDuplicates :@"down"];
        dropDown.delegate = self;
    }
    else
    {
        [dropDown hideDropDown:sender];
        [self releaseDropDown];
    }
    
}

- (IBAction)toConvertCurrencyBtnActn:(id)sender
{
    if(dropDown == nil)
    {
        CGFloat f = 200;
        NSMutableArray *selectFromArray = [[NSMutableArray alloc] init];
        selectFromArray =[self.conversionsArray valueForKey:@"to"];
        NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:selectFromArray];
        NSArray *arrayWithoutDuplicates = [orderedSet array];
        NSLog(@"%@",arrayWithoutDuplicates);
        dropDown = [[AllowedDropDown alloc] showDropDown:sender :&f :arrayWithoutDuplicates :@"down"];
        dropDown.delegate = self;
    }
    else
    {
        [dropDown hideDropDown:sender];
        [self releaseDropDown];
    }
    
}
-(void)ConverterDataMethod
{
    activityView = [[UIActivityIndicatorView alloc]
                    initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.center=self.view.center;
    [activityView startAnimating];
    [self.view addSubview:activityView];
    self.view.userInteractionEnabled = NO;
    
    NSString *finalUrlStr = @"https://raw.githubusercontent.com/mydrive/code-tests/master/iOS-currency-exchange-rates/rates.json";
    NSURL *serverURL = [NSURL URLWithString:finalUrlStr];
    NSMutableURLRequest *requestURL = [NSMutableURLRequest requestWithURL:serverURL];
    [requestURL setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    NSLog(@"token%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"TokenValue"]);
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    defaultConfigObject.URLCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
    //    defaultConfigObject.HTTPAdditionalHeaders = @{ };
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask =[defaultSession dataTaskWithRequest:requestURL
                                                      completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                     {
                                         self.view.userInteractionEnabled = YES;
                                         if (error)
                                         {
                                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"The Internet connection appears to be offline" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                             [alert show];
                                         }
                                         else
                                         {
                                             NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                             NSLog(@"Data: %@ %lu", dataString, (unsigned long)[dataString length]);
                                             if ([dataString isEqualToString:@""])
                                             {
                                                 //            NSString *errormsg = [error localizedDescription];
                                                 //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:errormsg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                                 //            [alert show];
                                             }
                                             else
                                             {
                                                 NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                 self.conversionsArray = [jsonDict objectForKey:@"conversions"];
                                                 NSLog(@"conversions---%@",self.conversionsArray);
                                                 // 1 euro to jpy -- 136
                                                 // text field text multiplies with rate from conversions data
                                                 // textfld(i/p) * rate = textfld(o/p), after converiosn click.
                                             }
                                             //        [self.voicemailTable reloadData];
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 self.view.userInteractionEnabled = YES;
                                                 [activityView removeFromSuperview];
                                             });
                                         }
                                     }];
    [dataTask resume];
    
}


@end
