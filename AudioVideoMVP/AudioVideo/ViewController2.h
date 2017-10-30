//
//  ViewController2.h
//  AudioVideo
//
//  Created by Vipul Srivastav on 2017-09-27.
//  Copyright © 2017 Vipul Srivastav. All rights reserved.
//

#ifndef ViewController2_h
#define ViewController2_h


#endif /* ViewController2_h */

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController : UIViewController
{
//    MPMoviePlayerController *moviePlayer;
}

- (IBAction)btnMergeTapped:(id)sender;

- (void)exportDidFinish:(AVAssetExportSession*)session;

@property(nonatomic,retain)AVURLAsset* videoAsset;
@property(nonatomic,retain)AVURLAsset* audioAsset;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
//@property (weak, nonatomic) IBOutlet UIView *vwMoviePlayer;

@end
