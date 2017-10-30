#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HBEditVideoViewController.h"
#import "HBRecorder.h"
#import "HBTransition.h"
#import "HBVideoPlayerViewController.h"
#import "SCImageDisplayerViewController.h"
#import "SCRecordSessionManager.h"
#import "SCSessionListViewController.h"
#import "SCSessionTableViewCell.h"
#import "SCTouchDetector.h"
#import "SCWatermarkOverlayView.h"

FOUNDATION_EXPORT double HBRecorderVersionNumber;
FOUNDATION_EXPORT const unsigned char HBRecorderVersionString[];

