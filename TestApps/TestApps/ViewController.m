//
//  ViewController.m
//  TestApps
//
//  Created by я on 08.09.17.
//  Copyright © 2017 VolkovIS. All rights reserved.
//

#import "ViewController.h"
#import "TableDataDelegate.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSString* host;
    NSString* apiKey;
    NSString* searchEngineID;
    NSString* fullString;
    NSString* bundleID;
    NSString* firstImageUrl;
}
@synthesize itemNameField;
@synthesize itemImageView;
@synthesize itemDescriptionView;
@synthesize searchField;
@synthesize requestText;
@synthesize itemImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    host = @"https://www.googleapis.com/customsearch/v1?q=";
    bundleID = @"com.VolkovIS.TestApps";
    apiKey = @"AIzaSyAUtILGhrW0pLqpuROI9jLsAo6a9H8K9hA";
    searchEngineID = @"015442153918896918168:rqwfyitfm9w";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextView/Field Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    requestText = searchField.text;
    fullString = [NSString stringWithFormat:@"https://www.googleapis.com/customsearch/v1?q=%@&cx=%@&key=%@", requestText, searchEngineID, apiKey];
    
    NSURL* url = [NSURL URLWithString:[fullString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    [request setValue:bundleID forHTTPHeaderField:@"X-Ios-Bundle-Identifier"];
    
    NSError* requestError;
    NSData* d = [NSData dataWithContentsOfURL:url];
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:d options:kNilOptions error:&requestError];
    NSArray* items = [json objectForKey:@"items"];

    if (json != nil)
    {
        if (json.allValues.count > 0)
        {
            NSArray* array = [json valueForKeyPath:@"items.pagemap.imageobject.url"];
            if (array)
            {
                NSArray* array2 = [array objectAtIndex:0];
                if (array2)
                {
                    firstImageUrl = [array2 objectAtIndex:0];
                }
            }
        }
    }

    [self loadImage:[NSURL URLWithString:firstImageUrl]];
    [self.view endEditing:YES];
    
    return YES;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return false;
    }
    return true;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([textView.text  isEqualToString: @"Введите описание"])
    {
        textView.text = @"";
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if ([textView.text  isEqualToString: @""])
    {
        textView.text = @"Введите описание";
    }
    [textView resignFirstResponder];
}

#pragma mark - IBActions

- (IBAction)buttonSaveClick:(id)sender {
    
    TableDataDelegate *tdd = [[TableDataDelegate alloc] init];
    
    NSManagedObject* item = [NSEntityDescription insertNewObjectForEntityForName:@"Items" inManagedObjectContext:tdd.persistentContainer.viewContext];
    
    [item setValue:itemNameField.text forKey:@"itemName"];
    [item setValue:itemDescriptionView.text forKey:@"itemDescription"];
    
    NSData* dataImage = UIImageJPEGRepresentation(itemImageView.image, 1.0); //0.0
    [item setValue:dataImage forKey:@"itemImage"];

    NSError *error = nil;
    if (![tdd.persistentContainer.viewContext save:&error])
    {
        NSLog(@"%@", [error localizedDescription]);
    }
}

#pragma mark - Images

- (void)loadImage:(NSURL *)imageURL
{
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                        initWithTarget:self
                                        selector:@selector(requestRemoteImage:)
                                        object:imageURL];
    [queue addOperation:operation];
}

- (void)requestRemoteImage:(NSURL *)imageURL
{
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    
    [self performSelectorOnMainThread:@selector(placeImageInUI:) withObject:image waitUntilDone:YES];
}

- (void)placeImageInUI:(UIImage *)image
{
    [itemImageView setImage:image];
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
