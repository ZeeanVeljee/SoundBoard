//
//  SoundEffectsViewController.swift
//  Sound Board
//
//  Created by Zeean Veljee on 06/06/17.
//  Copyright © 2017 Zed. All rights reserved.
//

import UIKit
import AVFoundation

class SoundEffectsViewController: UIViewController {
    
    var sound: Sound? = nil
    
    @IBOutlet weak var soundNameLabel: UITextField!
    
    @IBOutlet weak var slowSnailButton: UIButton!
    @IBOutlet weak var fastRabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var darthVaderButton: UIButton!
    
    var audioPlayer: AVAudioPlayer!
    //var receivedRecording: RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        soundNameLabel.text = sound?.name
        do {
            audioPlayer = try AVAudioPlayer(data: sound?.audio! as! Data)
            audioPlayer.enableRate = true
            audioEngine = AVAudioEngine()
        } catch {
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func finishTapped(_ sender: Any) {
    }
    
    @IBAction func finishAndCreateNewTapped(_ sender: Any) {
    }
    
    @IBAction func slowSnailEffect(_ sender: Any) {
        do {
            audioPlayer.stop()
            audioEngine.stop()
            audioEngine.reset()
            audioPlayer.rate = 0.6
            audioPlayer.currentTime = 0.0
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
            audioPlayer.play()
        } catch {}
        
    }
    
    @IBAction func fastRabbitEffect(_ sender: Any) {
        do {
            audioPlayer.stop()
            audioEngine.stop()
            audioEngine.reset()
            audioPlayer.rate = 1.7
            audioPlayer.currentTime = 0.0
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
            audioPlayer.play()
        } catch {}
        

    }
    
    @IBAction func chipmunkEffect(_ sender: Any) {
    }
    
    @IBAction func darthVaderEffect(_ sender: Any) {
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
