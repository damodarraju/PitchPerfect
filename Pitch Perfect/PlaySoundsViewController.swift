//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Raju on 13/04/2015.
//  Copyright (c) 2015 Damodar Gundu. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view.
//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
//           var filePathUrl = NSURL.fileURLWithPath(filePath)
//           
//            
//        }else{
//            println("filePath is empty")
//            
//        }
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Disposed any resources that can be recreated.
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        //Play audio sloooowly here....
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        
        
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        //Play audio Fast here...
        audioPlayer.stop()
        audioPlayer.rate  = 1.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()

    
    
   }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
        
        
    }
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
       playAudioWithVariablePitch(-1000)
    
    }

    @IBAction func stopButton(sender: UIButton) {
        audioPlayer.stop()
    }
}
