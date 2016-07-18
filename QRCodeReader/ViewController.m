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
//- (void)getQRCodeData:(id)qRCodeData {
//    UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"QR Code" message:qRCodeData delegate:self cancelButtonTitle:@"Close" otherButtonTitles:@"Rescan", nil];
//    altView.tag = 991;
//    [altView show];
//}
- (void)getQRCodeData:(id)qRCodeData {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"QR Code" message:qRCodeData preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancel];
    
    UIAlertAction *reScan = [UIAlertAction actionWithTitle:@"Rescan" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [qrCodeView startReading];
    }];
    [alertController addAction:reScan];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
