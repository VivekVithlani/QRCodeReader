//
//  ViewController.m
//  QRCodeReader
//
//  Created by BBITSDev on 7/13/16.
//  Copyright © 2016 BBITSDev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [qrCodeView setDelegate:self];
    [qrCodeView startReading];
}

#pragma mark - QRCodeReaderDelegate
- (void)getQRCodeData:(id)qRCodeData {
    UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"QR Code" message:qRCodeData delegate:self cancelButtonTitle:@"Close" otherButtonTitles:@"Rescan", nil];
    altView.tag = 991;
    [altView show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [qrCodeView startReading];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
