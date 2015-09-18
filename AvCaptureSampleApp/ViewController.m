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
    
    AVCaptureDeviceInput *frontCameraInput;
    AVCaptureDeviceInput *backCameraInput;
    
    AVCaptureMovieFileOutput *movieOutput;
    
    AVCaptureDevicePosition currentPos;
}

@property (weak, nonatomic) IBOutlet PreviewView *previewView;


- (IBAction)didTapChangeButton:(id)sender;

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // セッション作成
    session = [[AVCaptureSession alloc] init];
    session.sessionPreset = AVCaptureSessionPresetLow;
    
    
    // デバイス取得
    AVCaptureDevice *frontCamera;
    AVCaptureDevice *backCamera;
    id devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *d in devices) {
        if (d.position == AVCaptureDevicePositionFront) {
            frontCamera = d;
        }
        else if (d.position == AVCaptureDevicePositionBack) {
            backCamera = d;
        }
    }
    
    // インプットの初期化
    frontCameraInput = [AVCaptureDeviceInput deviceInputWithDevice:frontCamera error:NULL];
    backCameraInput = [AVCaptureDeviceInput deviceInputWithDevice:backCamera error:NULL];
    
    [session addInput:frontCameraInput];
    currentPos = AVCaptureDevicePositionFront;
    
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

- (void)changeToFrontCamera
{
    [session removeInput:backCameraInput];
    [session addInput:frontCameraInput];
    currentPos = AVCaptureDevicePositionFront;
}

- (void)changeToBackCamera
{
    [session removeInput:frontCameraInput];
    [session addInput:backCameraInput];
    currentPos = AVCaptureDevicePositionBack;
}

// 前面カメラと背面カメラの切り替え
- (void)toggleCameraPosition
{
    [session beginConfiguration];
    if (currentPos == AVCaptureDevicePositionFront) {
        [self changeToBackCamera];
    }
    else if (currentPos == AVCaptureDevicePositionBack) {
        [self changeToFrontCamera];
    }
    [session commitConfiguration];
}


- (IBAction)didTapChangeButton:(id)sender {
    [self toggleCameraPosition];
}


@end
