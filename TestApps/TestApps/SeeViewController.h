//
//  SeeViewController.h
//  TestApps
//
//  Created by я on 08.09.17.
//  Copyright © 2017 VolkovIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeeViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic, readonly) IBOutlet UITextField *itemNameLabel;
@property (strong, nonatomic) NSString *itemName;
@property (strong, nonatomic) IBOutlet UITextView *itemDescriptionField;
@property (strong, nonatomic) NSString *itemDescription;
@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
@property (strong, nonatomic) UIImage *itemImage;

@end
