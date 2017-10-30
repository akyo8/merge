//
//  SCRecordSessionManager.h
//  SCRecorderExamples
//
//  Created by Simon CORSIN on 15/08/14.
//
//

#import <Foundation/Foundation.h>
#import <SCRecorder/SCRecorder.h>

@interface SCRecordSessionManager : NSObject

- (void)saveRecordSession:(SCRecordSession *)recordSession;

- (void)removeRecordSession:(SCRecordSession *)recordSession;

- (BOOL)isSaved:(SCRecordSession *)recordSession;

- (void)removeRecordSessionAtIndex:(NSInteger)index;

- (NSArray *)savedRecordSessions;

+ (SCRecordSessionManager *)sharedInstance;

@end

// HBMovieMaker
