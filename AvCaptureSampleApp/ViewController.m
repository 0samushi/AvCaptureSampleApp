//
//  ViewController.m
//  AvCaptureSampleApp
//
//  Created by 加藤直人 on 9/18/15.
//  Copyright © 2015 加藤直人. All rights reserved.
//

#import "ViewController.h"
#import "PreviewView.h"

@interface ViewController ()
{
    AVCaptureSession *session;
    AVCaptureDevice *device;
    AVCaptureMovieFileOutput *movieOutput;
}

@property (weak, nonatomic) IBOutlet PreviewView *previewView;

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // セッション作成
    session = [[AVCaptureSession alloc] init];
    
    // デバイス取得
    id devices = [AVCaptureDevice devices];
    for (AVCaptureDevice *d in devices) {
        if (d.position == AVCaptureDevicePositionFront) {
            device = d;
        }
    }
    
    // セッションに映像のインプット追加
    id movieInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:NULL];
    [session addInput:movieInput];
    
    // セッションに音声のインプット追加
    id audioCaptureDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio];
    id audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioCaptureDevices[0] error:NULL];
    [session addInput:audioInput];
    
    // 動画アウトプット追加
    movieOutput = [[AVCaptureMovieFileOutput alloc] init];
    [session addOutput:movieOutput];
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // セッション開始
    [self.previewView setSession:session];
    [session startRunning];
}

@end
