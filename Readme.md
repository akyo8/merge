#SHADESWARE | SHADES APP | https://shadesware.com

Uses CocoaPods | Sequence is HardCoded Right Now, No analysis of the BPM is being done right now, Consider this as a boilerplate code. 

- Pod init 

- Pods Used 

pod 'IQAudioRecorderController' : https://github.com/hackiftekhar/IQAudioRecorderController/
pod "HBRecorder" 				: https://github.com/hilalbaig/HBRecorder


Then Under Pods-> Go to HBRecorder: 

Make Modifications , Click on  Unlock Library in the Pop-up and do the following modifications at the specified locations


-In HBRecorder.h add the following LOC below line 36

	-  @property (strong, nonatomic) NSMutableArray *maxSegmentDurations;

	-  (void)setMaxSegmentDurations:(NSMutableArray *)maxSegmentDurations;


- In HBRecorder.m comment the else block in (IBAction)shutterButtonTapped:(UIButton *)sender

	- 	//    else {
	    //
	    //        [_recorder pause];
	    //        // change UI
	    //        [self.recBtn setImage:self.recStartImage
	    //                     forState:UIControlStateNormal];
    	//    }

- In HBRecorder.m Add the following lines of code After this function definition (void)recorder:(SCRecorder *)recorder 	  didAppendVideoSampleBufferInSession:(SCRecordSession *)	

		  - (void)setMaxSegmentDurations:(NSMutableArray *)maxSegmentDurations {
		    _maxSegmentDurations = [[NSMutableArray alloc] initWithArray:maxSegmentDurations];
		}

		-(void)checkMaxSegmentDuration:(SCRecorder *)recorder {
		    NSNumber* entry = (NSNumber*)[_maxSegmentDurations objectAtIndex:_currentRecord];
		    int currentSegmentDuration = [entry intValue];
		    if(currentSegmentDuration) {
		        CMTime suggestedMaxSegmentDuration = CMTimeMake(currentSegmentDuration, 1);
		        if (CMTIME_IS_VALID(suggestedMaxSegmentDuration)) {
		            if (CMTIME_COMPARE_INLINE(recorder.session.currentSegmentDuration, >=, suggestedMaxSegmentDuration)) {
		                [_recorder pause];
		                _currentRecord++;
		                NSLog(@"Current record id: %d", _currentRecord);
		                [self.recBtn setImage:self.recStartImage forState:UIControlStateNormal];
		            }
		        }
		    }
		}

- In HBTransition.m set _animationDuration = 0.0;

- Go to Pods > SCRecorder , In SCAudioConfiguration.m, set  AVSampleRateKey : [NSNumber numberWithInt: 0.1] 

- 	

- When Running Wait Until you have "Completed Exporting in Console" Then Click on Crop, Trim 30 seconds.

- Then click on Record, the video recording will start, It will programmatically pause at various segments, the sequence that is being followed right now is this [ 3,3,3,3,3,3,2,2,2,2,2,1,1 ] adding upto 30 seconds. The video basically will automatically pause at interval of 3 seconds for 6 times, then it will pause at interval of 2 seconds 5 times and then pauses at interval of 1 second.

- Then finally click on MERGE, in the console you will see it prints Failed to Merge ( !!! PROBLEM )



---Problems---

Using the Crop, we export the trimmed 30 second file into .m4a format, the video is recorded in .mov format 

We are stuck at MERGE Part, as explained above.

Workarounds: We are trying to convert the formats of the .m4a file to mp3 and .mov file to m4v 
in order to merge as given here, https://github.com/tejas123/iOS-Audio-Video-Merge/tree/master/AudioVideoMerge


The merge failure could also be beacuse of the modification done in "SCAudioConfiguration.m" but I am not sure.






















