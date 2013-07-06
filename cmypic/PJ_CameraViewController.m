//
//  PJ_CameraViewController.m
//  cmypic
//
//  Created by Poojan Jhaveri on 7/1/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import "PJ_CameraViewController.h"
#import "PJ_RetakeCameraViewController.h"



@interface PJ_CameraViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *cameraView;
@property (nonatomic) UIImagePickerController *imagePickerController;
@property (weak, nonatomic) IBOutlet UIView *vImagePreview;
@property(strong,nonatomic) UIImagePickerController *picker;
@property(strong,nonatomic) UIImagePickerController *photoalbumpicker;
@property(strong,nonatomic) UIImage *imagetosend;
@end

@implementation PJ_CameraViewController

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
    _imagetosend=[[UIImage alloc] init];
    self.navigationController.navigationBarHidden=YES;
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    _imagePickerController.delegate = self;
    _imagePickerController.showsCameraControls=NO;
    

    

    [self.vImagePreview addSubview:_imagePickerController.view];
    [ _imagePickerController viewWillAppear:YES];
    [ _imagePickerController viewDidAppear:YES];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [_imagePickerController setDelegate:self];
}


- (IBAction)cameraButtonPressed:(id)sender {
    
     _imagePickerController.delegate = self;
    [_imagePickerController takePicture];
  

   
    
    //[self performSegueWithIdentifier:@"CameraToEdit" sender:self];
    
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)photoAlbumPressed:(id)sender {
    
    _photoalbumpicker = [[UIImagePickerController alloc] init];
    _photoalbumpicker.modalPresentationStyle = UIModalPresentationNone;
    _photoalbumpicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
   // _photoalbumpicker.allowsEditing=YES;
    _photoalbumpicker.delegate = self;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self presentViewController:_photoalbumpicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
     _imagetosend = [info valueForKey:UIImagePickerControllerOriginalImage];
    if(picker == _imagePickerController)
    {
        PJ_RetakeCameraViewController *imageEditor=[[PJ_RetakeCameraViewController alloc] initWithNibName:@"Scale" bundle:nil];
       

        
        imageEditor.sourceImage = _imagetosend;
        [self.navigationController pushViewController:imageEditor animated:YES];
    }
    else
    {
    [self dismissViewControllerAnimated:YES completion:^{
        PJ_RetakeCameraViewController *imageEditor=[[PJ_RetakeCameraViewController alloc] initWithNibName:@"Scale" bundle:nil];
               
        imageEditor.sourceImage = _imagetosend;
        [self.navigationController pushViewController:imageEditor animated:YES];
    }];
    }
}




- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
