//
//  CG_NewPostViewController.m
//  cmypic
//
//  Created by Chitvan Gupta on 28/06/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import "CG_NewPostViewController.h"

@interface CG_NewPostViewController ()
@property (nonatomic, strong) PFObject *photoObject;
//@property (nonatomic, strong) SMMPhotoDataModel *photoDataModel;
@property(nonatomic) NSString *imagePath;
@property(nonatomic) UIImage *smallImage;
@end

@implementation CG_NewPostViewController
@synthesize imagePath,photoObject;
@synthesize postImageView, postTextView, postSwitch, postSegmentControl;
@synthesize postMsg,postIsTitle, photoName;
@synthesize smallImage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self showCamera];
    UITapGestureRecognizer * singleTapRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapRecognized:)];
    [self.view addGestureRecognizer:singleTapRecogniser];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) singleTapRecognized:  (UITapGestureRecognizer *) singleTap{
    [self.postTextView resignFirstResponder];
}


-(IBAction)saveNewPost:(id)sender{
    
    NSNumber *shareMode;
    postMsg = postTextView.text;
    if(postSwitch.tag==0)
        self.postIsTitle = [NSNumber numberWithBool:NO];
    else
        self.postIsTitle = [NSNumber numberWithBool:YES];
    
    if([postSegmentControl selectedSegmentIndex]==0)
        shareMode= [NSNumber numberWithBool:YES];
    else
        shareMode= [NSNumber numberWithBool:NO];
    
    PFUser *user = [PFUser currentUser];
    
    
    [photoName saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (!error) {
            photoObject = [PFObject objectWithClassName:@"Photo"];
            
            [photoObject setObject:photoName forKey:@"image"];
            [photoObject setObject:postMsg forKey:@"imageTitle"];
            [photoObject setObject:shareMode forKey:@"publicOrPrivate"];
            [photoObject setObject:postIsTitle forKey:@"titleOrTag"];
            [photoObject setObject:user forKey:@"user"];
           // [photoObject setObject:smallImage forKey:@"thumbnail"];
            [photoObject save];
            
            UIAlertView *photoUploadStatus = [[UIAlertView alloc] initWithTitle:@"Post Status" message:@"Your image is posted" delegate:self.view cancelButtonTitle:@"Okay" otherButtonTitles: nil];
            [photoUploadStatus show];
            
        }
        else
        {
            UIAlertView *photoUploadStatus = [[UIAlertView alloc] initWithTitle:@"Post Status" message:@"Some error while publishing post. Please try later." delegate:self.view cancelButtonTitle:@"" otherButtonTitles: nil];
            [photoUploadStatus show];
        }
    }];
    
    
}

- (void)showCamera {
    [self openCamerafromMainController: self
                         usingDelegate: self];
}



-(BOOL) openCamerafromMainController: (UIViewController *) controller usingDelegate: (id <UIImagePickerControllerDelegate, UINavigationControllerDelegate>) delegate{
    
    if([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera] == NO || (delegate==nil) || (controller ==Nil)){
        return NO;
    }
    
    
    
    UIImagePickerController *cameraView = [[UIImagePickerController alloc] init];
    [cameraView setSourceType: UIImagePickerControllerSourceTypeCamera];
    
    cameraView.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    
    cameraView.delegate = delegate;
    
    [controller presentViewController:cameraView animated:YES completion:nil];
    
    return YES;
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
    //UIViewController *controller = [[UIViewController alloc] init];
    //[self presentViewController:self. animated:YES completion:nil];
    //[self loadView ];
    NSLog(@"dismiss");
    //[picker release];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *mediaType =[info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage;
    if(CFStringCompare((CFStringRef) mediaType, kUTTypeImage, 0) ==kCFCompareEqualTo)
    {
        editedImage= [info objectForKey:@"UIImagePickerControllerEditedImage"];
        originalImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        if(editedImage)
        {
            postImageView.image = editedImage;
        }
        else
        {
            postImageView.image = originalImage;
        }
        
        UIImageWriteToSavedPhotosAlbum(postImageView.image, nil, nil, nil);
        
    }
    
    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [originalImage drawInRect: CGRectMake(0, 0, 640, 960)];
    smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Upload image
    NSData *imageData = UIImageJPEGRepresentation(originalImage, 0.05f);
    
    photoName = [PFFile fileWithName:@"Image.jpg" data:imageData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
