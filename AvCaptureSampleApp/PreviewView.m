//
//  PreviewView.m
//  AvCaptureSampleApp
//
//  Created by 加藤直人 on 9/18/15.
//  Copyright © 2015 加藤直人. All rights reserved.
//

#import "PreviewView.h"

@implementation PreviewView
{
    AVCaptureVideoPreviewLayer* videoLayer;
}

- (void)setSession:(AVCaptureSession*)session
{
    [videoLayer setSession:session];
}

- (void)layoutSubviews
{
    // プレビュー表示用レイヤーを作成し、サブレイヤーとしてadd
    videoLayer = [[AVCaptureVideoPreviewLayer alloc] init];
    videoLayer.frame = self.bounds;
    videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [videoLayer setBackgroundColor:[UIColor redColor].CGColor];
    [self.layer addSublayer:videoLayer];
}

@end
