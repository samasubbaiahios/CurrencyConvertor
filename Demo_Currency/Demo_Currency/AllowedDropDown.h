//
//  AllowedDropDown.h
//  FIApp
//
//  Created by subbu on 18/08/15.
//  Copyright (c) 2015 Xenvoice. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AllowedDropDown;
@protocol AllowedDropDownDelegate
- (void) AllowedDropDownDelegateMethod: (AllowedDropDown *) sender;
@end

@interface AllowedDropDown : UIView <UITableViewDelegate, UITableViewDataSource>
{
    NSString *animationDirection;
    UIImageView *imgView;
}
@property (nonatomic, retain) id <AllowedDropDownDelegate> delegate;
@property (nonatomic, retain) NSString *animationDirection;
-(void)hideDropDown:(UIButton *)b;
- (id)showDropDown:(UIButton *)b:(CGFloat *)height:(NSArray *)arr:(NSString *)direction;

@end
