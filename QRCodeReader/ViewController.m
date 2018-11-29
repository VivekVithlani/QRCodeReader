//
//  ViewController.m
//  QRCodeReader
//
//  Created by BBITSDev on 7/13/16.
//  Copyright © 2016 BBITSDev. All rights reserved.
//

#import "ViewController.h"
#import <V3QRCodeScanner/V3QRCodeReader.h>
#import <AVFoundation/AVFoundation.h>


@interface ViewController () {
    // QRCodeView ---------------------------------------------------------
    IBOutlet    V3QRCodeReader    *qrCodeView;
    // QRCodeView ---------------------------------------------------------
}

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [qrCodeView setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [self checkCameraPermission];
}

-(void)viewWillDisappear:(BOOL)animated {
    // stop reading
    [qrCodeView stopReading];
}

#pragma mark - Check Camera Permission
- (void) checkCameraPermission {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized) {
        if (!qrCodeView.isRunning) {
            [qrCodeView startReading];
        }
    }
    else if(authStatus == AVAuthorizationStatusNotDetermined) {
        NSLog(@"%@", @"Camera access not determined. Ask for permission.");
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
             if(granted) {
                 NSLog(@"Granted access to %@", AVMediaTypeVideo);
                 if (!qrCodeView.isRunning) {
                     [qrCodeView startReading];
                 }
             }
             else {
                 NSLog(@"Not granted access to %@", AVMediaTypeVideo);
                 [self camDenied];
             }
         }];
    }
    else if (authStatus == AVAuthorizationStatusRestricted) {
        // My own Helper class is used here to pop a dialog in one simple line.
        [self showAlertTitle:@"Error" withMessage:@"You've been restricted from using the camera on this device. Without camera access this feature won't work. Please contact the device owner so they can give you access." onView:self andCompletionHandler:nil];
    }
    else {
        [self camDenied];
    }
}

- (void)camDenied {
    NSLog(@"%@", @"Denied camera access");
    
    NSString *alertText;
    NSString *alertButton;
    
    BOOL canOpenSettings = (&UIApplicationOpenSettingsURLString != NULL);
    if (canOpenSettings)
    {
        alertText = @"It looks like your privacy settings are preventing us from accessing your camera to do barcode scanning. You can fix this by doing the following:\n\n1. Touch the Go button below to open the Settings app.\n\n2. Turn the Camera on.\n\n3. Open this app and try again.";
        
        alertButton = @"Go";
    }
    else
    {
        alertText = @"It looks like your privacy settings are preventing us from accessing your camera to do barcode scanning. You can fix this by doing the following:\n\n1. Close this app.\n\n2. Open the Settings app.\n\n3. Scroll to the bottom and select this app in the list.\n\n4. Turn the Camera on.\n\n5. Open this app and try again.";
        
        alertButton = @"OK";
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:alertText preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:alertButton style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // Open Setting
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    
    [alertController addAction:cancel];
    
    [self presentViewController:alertController animated:true completion:nil];
}

#pragma mark - V3QRCodeReaderDelegate
- (void)getBarCodeData:(NSDictionary *)scanDictonary {
    NSLog(@"scanDictonary : %@",scanDictonary);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[scanDictonary valueForKey:@"barCodeType"] message:[scanDictonary valueForKey:@"barCodeValue"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancel];
    
    // Get Screenshot of Barcode
    if ([scanDictonary valueForKey:@"image"]) {
        /* scan image
         UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
         */
    }
    
    UIAlertAction *reScan = [UIAlertAction actionWithTitle:@"Rescan" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self reScanBarCode];
    }];
    
    [alertController addAction:reScan];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)reScanBarCode {
    [qrCodeView startReading];
}

-(void)showAlertTitle:(NSString *)title withMessage:(NSString *)message onView:(UIViewController *)viewController andCompletionHandler:(void (^)(UIAlertAction *action)) completionHandler
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   //Handel your yes please button action here
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                   completionHandler(action);
                               }];
    
    [alert addAction:okButton];
    dispatch_async(dispatch_get_main_queue(), ^{
        [viewController presentViewController:alert animated:YES completion:nil];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
