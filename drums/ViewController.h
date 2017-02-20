//
//  ViewController.h
//  drums
//
//  Created by Monisha Elumalai on 11/23/16.
//  Copyright © 2016 Monisha Elumalai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>


@interface ViewController : UIViewController<AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
    
    SystemSoundID button1;
    SystemSoundID button2;
    SystemSoundID buttonKickDrum;
    SystemSoundID buttonClap;
    SystemSoundID buttonTomsDrums;
    
    UIImage *myImage;    
}

-(IBAction)Button1Sound:(id)sender;
-(IBAction)Button2Sound:(id)sender;
-(IBAction)Button3Sound:(id)sender;
-(IBAction)Button4Sound:(id)sender;
-(IBAction)Button5Sound:(id)sender;
-(IBAction)sliderVolumeAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *recordPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UISlider *myVolumeSlider;
@property (weak,nonatomic) IBOutlet UIProgressView *myRecProg;

-(IBAction)recordPauseTapped:(id)sender;
-(IBAction)stopTapped:(id)sender;
-(IBAction)playTapped:(id)sender;

#define kAudioFilePath @"test.m4a"

@end

