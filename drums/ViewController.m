//
//  ViewController.m
//  drums
//
//  Created by Monisha Elumalai on 11/23/16.
//  Copyright © 2016 Monisha Elumalai. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController () {
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
    NSURL *temporaryRecFile;
}



@end


@implementation ViewController
@synthesize stopButton, playButton, recordPauseButton;

-(IBAction)Button1Sound:(id)sender{
    
    AudioServicesPlaySystemSound(button1);
}
-(IBAction)Button2Sound:(id)sender{
    
    AudioServicesPlaySystemSound(button2);
}
-(IBAction)Button3Sound:(id)sender{
    
    AudioServicesPlaySystemSound(buttonKickDrum);
}
-(IBAction)Button4Sound:(id)sender{
    
    AudioServicesPlaySystemSound(buttonClap);
}
-(IBAction)Button5Sound:(id)sender{
    
    AudioServicesPlaySystemSound(buttonTomsDrums);
}

-(IBAction)sliderVolumeAction:(id)sender{
    UISlider *mySlider = sender;
    [player setVolume:mySlider.value];
    
}

- (void)viewDidLoad {
    
    
   // AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation = 1;
    
    
    NSURL *Button1Sound = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Snare_Drum" ofType:@"mp3"]]; AudioServicesCreateSystemSoundID((__bridge CFURLRef)Button1Sound, & button1);
    
    NSURL *Button2Sound = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Hi-Hats_Drums" ofType:@"mp3"]]; AudioServicesCreateSystemSoundID((__bridge CFURLRef)Button2Sound, & button2);

    NSURL *Button3Sound = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Kick_Drum" ofType:@"mp3"]]; AudioServicesCreateSystemSoundID((__bridge CFURLRef)Button3Sound, & buttonKickDrum);
    
    NSURL *Button4Sound = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Toms_Drums" ofType:@"mp3"]]; AudioServicesCreateSystemSoundID((__bridge CFURLRef)Button4Sound, & buttonClap);
    
    NSURL *Button5Sound = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Toms_Drums" ofType:@"mp3"]]; AudioServicesCreateSystemSoundID((__bridge CFURLRef)Button5Sound, & buttonTomsDrums);
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    [audioSession setActive:YES error:nil];
    
    [recorder setDelegate:self];
    
    //
    // Log out where the file is being written to within the app's documents directory
    //
    NSLog(@"File written to application sandbox's documents directory: %@",[self testFilePathURL]);

    
    [super viewDidLoad];

//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//    // Disable Stop/Play button when application launches
//    
    [self.stopButton setImage:[UIImage imageNamed:@"ButtonStop.png"] forState:UIControlStateNormal];
////    [self.stopButton setImage:[UIImage imageNamed:@"DisabledStop.png"] forState:userInteractionEnabled];
//    
//    [stopButton setEnabled:NO];
//    self.stopButton.alpha = 0.5;
//
//   
    [self.playButton setImage:[UIImage imageNamed:@"DisabledPlay.png"]forState:UIControlStateNormal];
//    [playButton setEnabled:NO];
//    playButton.userInteractionEnabled = NO;
//    self.playButton.alpha = 0.5;
//    
//    // Set the audio file
//    NSArray *pathComponents = [NSArray arrayWithObjects:
//                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
//                               @"MyRecording.m4a",
//                               nil];
//    
//    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
//    
//    // Setup audio session
//    AVAudioSession *session = [AVAudioSession sharedInstance];
//    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
// 
//    // Define the recorder setting
//    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
//    
//    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
//    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
//    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
//    
//    // Initiate and prepare the recorder
//    recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSetting error:NULL];
//    recorder.delegate = self;
//    recorder.meteringEnabled = YES;
//    [recorder prepareToRecord];
//
    [player setVolume:self.myVolumeSlider.value];

    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateMyProgress) userInfo:nil repeats:YES];
    
    

}

-(void) updateMyProgress{
    
    float progress=[player currentTime]/[player duration];
    self.myRecProg.progress = progress;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)recordPauseTapped:(id)sender{NSError *error;
    
    // Recording settings
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    
    [settings setValue: [NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [settings setValue: [NSNumber numberWithFloat:8000.0] forKey:AVSampleRateKey];
    [settings setValue: [NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
    [settings setValue: [NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [settings setValue: [NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    [settings setValue: [NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    [settings setValue:  [NSNumber numberWithInt: AVAudioQualityMax] forKey:AVEncoderAudioQualityKey];
    
    
    NSArray *searchPaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath_ = [searchPaths objectAtIndex: 0];
    
    NSString *pathToSave = [documentPath_ stringByAppendingPathComponent:[self dateString]];
    
    // File URL
    NSURL *url = [NSURL fileURLWithPath:pathToSave];//FILEPATH];
    
    
    //Save recording path to preferences
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    
    [prefs setURL:url forKey:@"Test1"];
    [prefs synchronize];
    
    
    // Create recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    
    [recorder prepareToRecord];
    
    [recorder record];
    
}
-(IBAction)stopTapped:(id)sender{
    [recorder stop];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
    [player setCurrentTime:0];
    
    
}

-(IBAction)playTapped:(id)sender{
    if (!recorder.recording){
//        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
//        [player setDelegate:self];
//        [player play];
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        [audioSession setActive:YES error:nil];
        
        
        //Load recording path from preferences
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        
        temporaryRecFile = [prefs URLForKey:@"Test1"];
        
        
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:temporaryRecFile error:nil];
        
        
        
        player.delegate = self;
        
        
        [player setNumberOfLoops:0];
        player.volume = 1;
        
        
        [player prepareToPlay];
        
        [player play];

    }
    
}
#pragma mark - AVAudioRecorderDelegate

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{
    [recordPauseButton setTitle:@"Record" forState:UIControlStateNormal];
    [stopButton setEnabled:NO];
    [playButton setEnabled:YES];
}

#pragma mark - AVAudioPlayerDelegate

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Done"
                                                    message: @"Finish playing the recording!"
                                                   delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];

    [alert show];
}

- (NSString *) dateString
{
    // return a formatted string for a file name
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"ddMMMYY_hhmmssa";
    return [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@".aif"];
}

- (NSArray *)applicationDocuments
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
}

//------------------------------------------------------------------------------

- (NSString *)applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

//------------------------------------------------------------------------------

- (NSURL *)testFilePathURL
{
    return [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",
                                   [self applicationDocumentsDirectory],
                                   kAudioFilePath]];
}

@end
