V3QRCodeReader
===========
## Screenshot
[![ScreenShot](https://github.com/VivekVithlani/QRCodeReader/blob/master/Screenshot.png)](https://youtu.be/HEnNMDQ58HU)

## How to use
##### 1. Embeded Binaries
https://youtu.be/A7KhnHdOs6A

##### 2. Drag and drop UIView in your view controller.
##### 3. Change Class of UIVIew.
##### 4. Bind your UIView.
https://youtu.be/_iWtz7nWIaM

##### 5. Camera Permission.
Key: `Privacy - Camera Usage Description`
Value : `$(PRODUCT_NAME) camera use`
for more details please visit : https://ioshelloworld.blogspot.com/2016/10/ios-10-infoplist-changes-required.html



#### *Paste "M1, M2" methods in your view controller* (i.e. "ViewController.m")

#### "M1" *viewDidLoad, viewWillAppear, viewWillDisappear*
```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [qrCodeView setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    if (!qrCodeView.isRunning) {
        [qrCodeView startReading];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    // stop reading
    [qrCodeView stopReading];
}
```

##### And here the delegate methods:
### "M2" V3QRCodeReaderDelegate
```objective-c
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
```

## Supported BarCodeType
##### √ PDF417
##### √ QRCode
##### √ UPCECode
##### √ 39Code
##### √ Code39Mod43Code
##### √ EAN13Code
##### √ EAN8Code
##### √ Code93Code
##### √ Code128Code
##### √ AztecCode
##### √ Interleaved2of5Code
##### √ ITF14Code
##### √ DataMatrixCode

 
