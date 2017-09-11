//
//  SeeViewController.m
//  TestApps
//
//  Created by я on 08.09.17.
//  Copyright © 2017 VolkovIS. All rights reserved.
//

#import "SeeViewController.h"

@interface SeeViewController ()

@end

@implementation SeeViewController
@synthesize itemNameLabel;
@synthesize itemName;
@synthesize itemDescriptionField;
@synthesize itemDescription;
@synthesize itemImageView;
@synthesize itemImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    itemNameLabel.text = itemName;
    itemDescriptionField.text = itemDescription;
    itemImageView.image = itemImage;
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
