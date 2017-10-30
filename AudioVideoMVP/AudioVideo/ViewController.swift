//
//  ViewController.swift
//  AudioVideo
//
//  Created by Vipul Srivastav on 2017-08-19.
//  Copyright © 2017 Vipul Srivastav. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer
import IQAudioRecorderController
import HBRecorder
import Photos
import AssetsLibrary

class ViewController: UIViewController , IQAudioCropperViewControllerDelegate , HBRecorderProtocol{
    var data		: [MPMediaItem]	= []
    var data2		: MPMediaItem? = nil
    var asset: AVAsset? = nil
    var assetURL: URL?  = nil
    var avPlayer: AVPlayer!
    var videoPath: URL?
    var audioPath: URL?
    var finalPath: URL?
    var resourceaduioPath: URL?
    var process: String?
    var fileURL : URL?
    var exportPath: NSString? = nil
    
    var exportUrl: NSURL? = nil
    
    //    var outputFileUrl : URL? = nil

    override func viewWillAppear(_ animated: Bool) {
        
   	 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let dirPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let res = Bundle.main.url(forResource: "Asteroid_Sound", withExtension: "mp3")
        let path = NSURL.fileURL(withPath: NSTemporaryDirectory(), isDirectory: true)
        audioPath = res
        videoPath = path.appendingPathComponent("Asteroid_Video.m4v")
        resourceaduioPath = res
        finalPath = path.appendingPathComponent("Export.m4v")
        exportUrl = path as NSURL
        print("audioPaths UrL +\(String(describing: audioPath))")
        print("videoPaths UrL +\(String(describing: videoPath))")

        print("dirPaths URL +\(path)")
        let tempData = MPMediaQuery.songs().items ?? []
        self.data = []
        for mediaItem in tempData {
            if (mediaItem.isCloudItem == false && mediaItem.assetURL != nil) {
                print(mediaItem.assetURL?.path)
                // get title for bpm
                print(mediaItem.title)
                print(mediaItem.playbackDuration)
             	   self.data.append(mediaItem)
            }
        }
        
        self.data2  = self.data.first
        
        print(data2?.playbackDuration)
        print("BEATS PER MINUTE +\(String(describing: data2?.beatsPerMinute))")
        
//        assetURL  = self.data2?.value(forProperty: MPMediaItemPropertyAssetURL) as! URL
        
        print("Asset URL +\(String(describing: assetURL))")
        
        ///test
        
        if let val = data2?.value(forKey: MPMediaItemPropertyAssetURL) as? URL {
            let asset = AVURLAsset.init(url: val)
            
            if asset.isExportable {
                let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetAppleM4A)
                
                exportPath = NSTemporaryDirectory().appendingFormat("/\(UUID().uuidString).m4a") as NSString
                exportUrl = NSURL.fileURL(withPath: exportPath! as String) as NSURL
              
                exportSession?.outputURL = exportUrl! as URL
                exportSession?.outputFileType = AVFileTypeAppleM4A
                exportSession?.exportAsynchronously(completionHandler: {
                    // do some stuff with the file
                    do {
                        // try FileManager.default.removeItem(atPath: self.exportPath as String!)
                        print("Completed Exporting")
                    } catch {
                        
                    }
                })
            }
        }
        
        print("exported URL +\(String(describing: exportUrl))")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // CROP TEST
    
    @IBAction func crop(_ sender: Any) {
        
        cropAction(audioPath?.path)
      
    }
    
    // crop
    func cropAction(_ item: Any){
        
        let controller = IQAudioCropperViewController(filePath:(resourceaduioPath?.path)! )
        //        let controller = IQAudioCropperViewController(filePath:  (self.data2?.assetURL?.path)! )
        controller.delegate = self
        controller.title = "Edit"
        controller.barStyle = UIBarStyle.default
  
        controller.normalTintColor = UIColor.magenta
        controller.highlightedTintColor = UIColor.orange
        presentBlurredAudioCropperViewControllerAnimated(controller)
    }
    
    func audioCropperController(_ controller: IQAudioCropperViewController, didFinishWithAudioAtPath filePath: String) {
        //Do your custom work with file at filePath.
        print("cropped Audio "+filePath)
        self.audioPath = URL.init(fileURLWithPath: filePath)
        
        //        performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
    }
    
    func audioCropperControllerDidCancel(_ controller: IQAudioCropperViewController) {
        //Notifying that user has clicked cancel.
        controller.dismiss(animated: true) { _ in }
    }
    
    // video
    // MARK: - Video Recording Methods
    func recorder(_ recorder: HBRecorder, didFinishPickingMediaWith videoUrl: URL) {
        videoPath = videoUrl
        //playVideoButton.isHidden = false
        DispatchQueue.global(qos: .default).async(execute: {() -> Void in
            let asset = AVAsset(url: self.videoPath!)
            // url= give your url video here
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            let time: CMTime = CMTimeMake(2, 5)
            //it will create the thumbnail after the 5 sec of video
            let imageRef: CGImage? = try? imageGenerator.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: imageRef!)
            DispatchQueue.main.async(execute: {(_: Void) -> Void in
                //Run UI Updates
                //self.thumbnailImageView.image = thumbnail
            })
            
            let CMduration: CMTime = asset.duration
            let totalSeconds: Int = Int(CMTimeGetSeconds(CMduration))
            let seconds: Int = totalSeconds % 60
            let minutes: Int = (totalSeconds / 60) % 60
            let hours: Int = totalSeconds / 3600
            var duration: String = ""
            
            if hours > 0 {
                let hoursString: String = "\(hours) hour(s)"
                duration = duration + (hoursString)
            }
            
            if minutes > 0 {
                let minString: String = "\(minutes) min(s)"
                duration = duration + (minString)
            }
            
            if seconds > 0 {
                let secString: String = "\(seconds) sec(s)"
                duration = duration + (secString)
            }
            
            DispatchQueue.main.async(execute: {(_: Void) -> Void in
                //Run UI Updates
                //            _videoLenghtLabel.text = duration;
            })
        })
        print("VideoPath : + \(String(describing: videoPath))")
        
    }
    
    
    func recorderDidCancel(_ recorder: HBRecorder) {
        print("Recorder did cancel..")
    }
    

    @IBAction func openRecorder(_ sender: Any) {
        let bundle = Bundle(for: HBRecorder.self)
        let sb = UIStoryboard(name: "HBRecorder.bundle/HBRecorder", bundle: bundle)
        let recorder: HBRecorder? = sb.instantiateViewController(withIdentifier: "HBRecorder") as? HBRecorder
        recorder?.delegate = self
//        recorder?.topTitle = "Top title"
//        recorder?.bottomTitle = "HilalB - ©"
        recorder?.maxRecordDuration = 30
        recorder?.maxSegmentDurations = [3,3,3,3,3,3,2,2,2,2,2,1,1];
        
        recorder?.maxSegmentDuration = 5
        let processName = ProcessInfo.processInfo.globallyUniqueString
        self.process = processName
        recorder?.movieName = processName
        recorder?.modalTransitionStyle = .flipHorizontal
        navigationController?.pushViewController(recorder!, animated: true)
    }
    
//    @IBAction func Export(_ sender: Any) {
//        exportToMp4(video_url: videoPath!)
//    }
    
        @IBAction func merge(_ sender: Any)
        {
            mergeAndSave(audio_url: audioPath!, video_url: videoPath!)
        }
//    func videoPlay()
//    {
//        let playerController = AVPlayerViewController()
////        playerController.delegate = self.dele
//
//        let bundle = Bundle.main
//        let moviePath = videoPath?.path
//        let movieURL = URL(fileURLWithPath: moviePath!)
//
//        let player = AVPlayer(url: movieURL)
//        playerController.player = player
//        self.addChildViewController(playerController)
//        self.view.addSubview(playerController.view)
//        playerController.view.frame = self.view.frame
//
//        player.play()
//
//    }
 
    func exportToM4v(video_url:URL) {
        /*
         Export .mov file as mp4
         */
        
        let videoAsset = AVURLAsset.init(url: video_url, options: nil)
        let dirPaths2 = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        
        let docsDir2: String = dirPaths2[0].absoluteString
        let outputFilePath2: String = URL(fileURLWithPath: docsDir2).appendingPathComponent("Export.m4v").absoluteString
        
        let outputFileUrl2 = URL.init(fileURLWithPath: outputFilePath2)
        if FileManager.default.fileExists(atPath: outputFilePath2) {
            try? FileManager.default.removeItem(atPath: outputFilePath2)
        }
        
        var exportToMp4 = AVAssetExportSession.init(asset: videoAsset, presetName: AVAssetExportPresetPassthrough)
        exportToMp4?.outputURL = outputFileUrl2
        exportToMp4?.outputFileType = AVFileTypeMPEG4
        
        exportToMp4?.exportAsynchronously(completionHandler: {() -> Void in
            DispatchQueue.main.async(execute: {() -> Void in
                print("process:\(exportToMp4?.progress)")
                if exportToMp4?.status == .failed {
                    print("Failed to Export to m4v")
                }
                
                if exportToMp4?.status == .completed {
                    print("Exported to m4v + \(outputFilePath2)")
                    
                }
            })
        })

    }
    
    func mergeAndSave(audio_url: URL, video_url: URL )
    {
        let mixComposition = AVMutableComposition()
        
        let audioAsset = AVURLAsset.init(url: audio_url, options: nil)
        let videoAsset = AVURLAsset.init(url: video_url, options: nil)
        self.process = self.process! + ".m4v"
        let documentsUrl = exportUrl
        let fileurl = documentsUrl?.appendingPathComponent(self.process!)
        print(fileurl?.path)
        let a = audioAsset.tracks(withMediaType: AVMediaTypeAudio)
        print(a.count)
        
        let audioTrack: AVMutableCompositionTrack? = mixComposition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: kCMPersistentTrackID_Invalid)
        let videoTrack: AVMutableCompositionTrack? = mixComposition.addMutableTrack(withMediaType: AVMediaTypeVideo, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        try? audioTrack?.insertTimeRange(CMTimeRangeMake(kCMTimeZero, videoAsset.duration), of: audioAsset.tracks(withMediaType: AVMediaTypeAudio)[0], at: kCMTimeZero)
        
        try? videoTrack?.insertTimeRange(CMTimeRangeMake(kCMTimeZero, videoAsset.duration), of: videoAsset.tracks(withMediaType: AVMediaTypeVideo)[0], at: kCMTimeZero)
        
        let exportSession = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality)

        exportSession?.outputURL = fileurl
        exportSession?.outputFileType = AVFileTypeAppleM4V
        exportSession?.exportAsynchronously(completionHandler: {() -> Void in
            print("\(String(describing: exportSession?.error))")
            PHPhotoLibrary.shared().performChanges({
                
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: fileurl!)
            }) { saved, error in
                if saved {
                    let alertController = UIAlertController(title: "Your video was successfully saved", message: nil, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        })
        
       

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        var DestViewControler: VideoViewController  = segue.destination as! VideoViewController
        
        //       DestViewControler.shadeVideoUrl = self.outputFileUrl
        
    }
    
    
    /*
     
     TEST TEST TEST
     
     */
    
    func exportDidFinish(_ session: AVAssetExportSession)
    {
        if session.status == .completed {
            let outputURL: URL? = session.outputURL
            print("\(outputURL)")
            
            
        }
        
    }
    
    
    
    
}

