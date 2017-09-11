//
//  ViewController.h
//  TestApps
//
//  Created by я on 08.09.17.
//  Copyright © 2017 VolkovIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *searchField;
@property (strong, nonatomic) NSString* requestText;
@property (strong, nonatomic) IBOutlet UITextField *itemNameField;
@property (strong, nonatomic) IBOutlet UITextView *itemDescriptionView;
@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
@property (strong, nonatomic) UIImage* itemImage;

- (IBAction)buttonSaveClick:(id)sender;

@end

