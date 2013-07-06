//
//  CG_NewPostViewController.m
//  cmypic
//
//  Created by Chitvan Gupta on 28/06/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import "CG_NewPostViewController.h"
#import "PJ_ChecklistModel.h"

// for uipicker in actionsheet
//http://stackoverflow.com/questions/1262574/add-uipickerview-a-button-in-action-sheet-how


@interface CG_NewPostViewController ()
@property (nonatomic, strong) PFObject *photoObject;
//@property (nonatomic, strong) SMMPhotoDataModel *photoDataModel;

@property(nonatomic) NSString *imagePath;
@property(nonatomic) UIImage *smallImage;
@property(strong,nonatomic) PJ_ChecklistModel *model;
@property(nonatomic,strong)UIToolbar *pickerToolbar;
@property(nonatomic,strong)UIPickerView *thePicker;
@property(nonatomic,strong)UIActionSheet *aac;

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
    self.model=[PJ_ChecklistModel sharedModel];
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPickerView) name:@"RefreshPickerView" object:nil];
    
    
    self.navigationController.navigationBarHidden=false;
    self.navigationItem.title=@"Share";
    [self.navigationController.navigationItem.rightBarButtonItem setAction:@selector(saveNewPost:)];
    
    
	// Do any additional setup after loading the view.
     self.postImageView.image=self.imagerecieved;
    UITapGestureRecognizer * singleTapRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapRecognized:)];
    [self.view addGestureRecognizer:singleTapRecogniser];
    //[self showCamera];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    self.postImageView.image=self.imagerecieved;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) singleTapRecognized:  (UITapGestureRecognizer *) singleTap{
    [self.postTextView resignFirstResponder];
}

- (IBAction)switchChanged:(id)sender {
    if(self.postSwitch.isOn==true)
    {
        self.postTextView.text=@"Select the Tag you wish to complete";
    }
    else
    {
         self.postTextView.text=@"Please Enter the description";
    }
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)aTextView
{
    if(self.postSwitch.isOn==true)
    {
        
        
        _aac = [[UIActionSheet alloc] initWithTitle:@"Choose a Tag"
                                                         delegate:self
                                                cancelButtonTitle:nil
                                           destructiveButtonTitle:nil
                                                otherButtonTitles:nil];
        
        
        _thePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0, 44.0, 0.0, 0.0)];
        _thePicker.dataSource=self;
        _thePicker.delegate=self;
        _thePicker.showsSelectionIndicator=YES;
        
        
        self.pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        self.pickerToolbar.barStyle = UIBarStyleBlackOpaque;
        [self.pickerToolbar sizeToFit];

        
        NSMutableArray *barItems = [[NSMutableArray alloc] init];
        
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(pickerCancel)];
        [barItems addObject:cancelBtn];
        
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        [barItems addObject:flexSpace];
        
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDone)];
        [barItems addObject:doneBtn];
        
        [_pickerToolbar setItems:barItems animated:YES];
        
        [_aac addSubview:_pickerToolbar];
        [_aac addSubview:_thePicker];
        [_aac showInView:self.view];
        [_aac setBounds:CGRectMake(0,0,320, 464)];
        
        return NO;
    }
    else
    {
        self.postTextView.text=@"";
       return YES; 
    }
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self.postTextView resignFirstResponder];
    return YES;
}


-(void)pickerCancel
{
    [_aac dismissWithClickedButtonIndex:0 animated:1];
}

-(void)pickerDone
{
    self.postTextView.text=[self.model.thingstodo objectAtIndex:[_thePicker selectedRowInComponent:0]];
    [_aac dismissWithClickedButtonIndex:1 animated:1];
}

-(void)refreshPickerView
{
    [_thePicker reloadAllComponents];
}

-(IBAction)saveNewPost:(id)sender{
    
    NSLog(@"Posting");
    
    
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
    
    NSData *imageData = UIImageJPEGRepresentation(_imagerecieved, 0.05f);
    photoName = [PFFile fileWithName:@"Image.jpg" data:imageData];
    
    [photoName saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"I am in");
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
            NSLog(@"Whats the error");
            UIAlertView *photoUploadStatus = [[UIAlertView alloc] initWithTitle:@"Post Status" message:@"Some error while publishing post. Please try again later." delegate:self.view cancelButtonTitle:@"" otherButtonTitles: nil];
            [photoUploadStatus show];
        }
        [self dismissViewControllerAnimated:YES completion:^{
            self.tabBarController.selectedIndex=0;
        }];
        
    }];
   
    
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

#pragma mark - PICKER FOR CHECKLIST

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //One column
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.model.thingstodo count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.model.thingstodo objectAtIndex:row];
}



@end
