//
//  VideoViewController.swift
//  AudioVideo
//
//  Created by Vipul Srivastav on 20	17-10-02.
//  Copyright © 2017 Vipul Srivastav. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class VideoViewController: UIViewController {
    
    var playerViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    
    var shadeVideoUrl : URL? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
        playerView = AVPlayer.init(url: shadeVideoUrl!)
        
        playerViewController.player = playerView
        
        self.present(playerViewController, animated: true) {
            self.playerViewController.player?.play()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
