//
//  QRCodeReader.h
//  BigMouth
//
//  Created by BBITSDev on 7/27/15.
//  Copyright (c) 2015 iOS Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QRCodeReaderDelegate <NSObject>
@required
- (void)getQRCodeData:(id)qRCodeData;
@end

@interface QRCodeReader : UIView
@property (nonatomic, retain) id delegate;
-(id)initWithFrame:(CGRect)frame viewController:(id)ViewController;
- (BOOL)startReading;
@end
