//
//  PJ_ProfieEditViewController.m
//  cmypic
//
//  Created by Poojan Jhaveri on 6/15/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import "PJ_ProfieEditViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIImage+ResizeAdditions.h"

@interface PJ_ProfieEditViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *emailAddress;
@property (weak, nonatomic) IBOutlet UITextField *University;
@property(nonatomic,weak)IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *ClassOf;
@property(nonatomic,strong)UIPickerView *thePicker;
@property(nonatomic,strong)UIActionSheet *aac;
@property(nonatomic,strong)UIActionSheet *imageActionSheet;
@property(nonatomic,strong)UIToolbar *pickerToolbar;
@property(nonatomic,strong)NSArray *array;
@end

@implementation PJ_ProfieEditViewController

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
    
    _array=[[NSArray alloc]initWithObjects:@"2013",@"2014",@"2015",@"2016",@"2017",@"2018",@"2019",@"2020",@"2021",@"2022",@"2023", nil ];
    _ClassOf.delegate=self;
    
    self.navigationItem.hidesBackButton=YES;
    _emailAddress.text=[[PFUser currentUser] valueForKey:@"email"];
    // Do any additional setup after loading the view.
}

- (IBAction)imageHandleTap:(id)sender {
    
    _imageActionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose Profile Picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo!",@"Choose from PhotoAlbum", nil];
    [_imageActionSheet showInView:self.view];
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        [self useCamera];
    }
    
    if(buttonIndex==1)
    {
        [self useCameraRoll];
    }
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)aTextView
{
    if(aTextView.tag==5)
    {
        _aac = [[UIActionSheet alloc] initWithTitle:@"Select Year"
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
        return YES;
    }
    
}


-(void)pickerCancel
{
    [_aac dismissWithClickedButtonIndex:0 animated:1];
}

-(void)pickerDone
{
   _ClassOf.text=[NSString stringWithFormat:@"Class of %@",[_array objectAtIndex:[_thePicker selectedRowInComponent:0]]];
    [_aac dismissWithClickedButtonIndex:1 animated:1];
}



#pragma mark - PICKER FOR CHECKLIST

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //One column
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_array objectAtIndex:row];
}



-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - IMAGE VIEW and camera

- (void) useCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
    
    }
}


- (void) useCameraRoll
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerEditedImage];
        
        _imageView.image = image;

}
}


- (IBAction)saveButtonPressed:(id)sender {
    [[PFUser currentUser] setValue:_firstName.text forKey:@"firstName"];
    [[PFUser currentUser] setValue:_lastName.text forKey:@"lastName"];
    [[PFUser currentUser] setValue:_University.text forKey:@"University"];
    [[PFUser currentUser] setValue:[_array objectAtIndex:[_thePicker selectedRowInComponent:0]]forKey:@"ClassOf"];

    
    UIImage *smallimage =[[_imageView image]thumbnailImage:64 transparentBorder:0 cornerRadius:0 interpolationQuality:kCGInterpolationMedium];

    NSData *imageData = UIImageJPEGRepresentation([_imageView image], 0.05f);
    NSData *smallimageData = UIImageJPEGRepresentation(smallimage, 0.05f);
    PFFile *photoName = [PFFile fileWithName:@"profilepicture.jpg" data:imageData];
    PFFile *smallphotoName = [PFFile fileWithName:@"thumbnail.jpg" data:smallimageData];

    [[PFUser currentUser] setObject:photoName forKey:@"profilePictureMedium"];
    [[PFUser currentUser] setObject:smallphotoName forKey:@"profilePictureSmall"];
    

    [[PFUser currentUser] saveInBackground];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"wasLaunchedBefore"];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logOutPressed:(id)sender {
    [PFUser logOut];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
