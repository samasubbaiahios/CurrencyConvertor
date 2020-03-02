//
//  ViewController.h
//  Demo_Currency
//
//  Created by Ajr on 9/23/15.
//  Copyright (c) 2015 Subbu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AllowedDropDown.h"

@interface ViewController : UIViewController <AllowedDropDownDelegate>
{
    AllowedDropDown *dropDown;
}
@property (strong, nonatomic) IBOutlet UIButton *fromBtn;
@property (strong, nonatomic) IBOutlet UIButton *toConvertBtn;
@property (strong, nonatomic) IBOutlet UITextField *numberTxtFld;
@property (strong, nonatomic) IBOutlet UIButton *convertCurrencyBtn;
@property (strong, nonatomic) NSMutableArray *conversionsArray;

-(void)releaseDropDown;
- (IBAction)convertCurrencyBtnActn:(id)sender;
- (IBAction)fromCurrencyBtnActn:(id)sender;
- (IBAction)toConvertCurrencyBtnActn:(id)sender;

@end

