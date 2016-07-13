//
//  ViewController.h
//  QRCodeReader
//
//  Created by BBITSDev on 7/13/16.
//  Copyright © 2016 BBITSDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QRCodeReaderFramework/QRCodeReaderFramework.h>

@interface ViewController : UIViewController <QRCodeReaderDelegate> {
    // QRCodeView ---------------------------------------------------------
    IBOutlet    QRCodeReader    *qrCodeView;
    // QRCodeView ---------------------------------------------------------
}
@end

