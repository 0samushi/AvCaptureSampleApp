//
//  PreviewView.h
//  AvCaptureSampleApp
//
//  Created by 加藤直人 on 9/18/15.
//  Copyright © 2015 加藤直人. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PreviewView : UIView

- (void)setSession:(AVCaptureSession *)session;

@end
