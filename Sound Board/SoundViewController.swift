//
//  SoundViewController.swift
//  Sound Board
//
//  Created by Zeean Veljee on 29/05/17.
//  Copyright © 2017 Zed. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var soundNameTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var audioURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpRecorder()
        playButton.isEnabled = false
        addButton.isEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpRecorder() {
        do {
            //Create a session
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            
            //Create url for audio file
            let basePath: String  = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            //print("\n\n\n\n\n\n\n\(audioURL)\n\n\n\n\n\n")
            
            
            //Create settings for audio recorder
            var settings: [String : AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject
            settings[AVSampleRateKey] = 44100.0 as AnyObject
            settings[AVNumberOfChannelsKey] = 2 as AnyObject
            
            
            //Create audio recorder object
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)

        } catch let error as NSError{
            print(error)
        }
        
    }
    
    
    @IBAction func recordTapped(_ sender: Any) {
        
        if audioRecorder!.isRecording {
            //Stop the Recorder
            audioRecorder?.stop()
            
            //Change button to 'Record'
            recordButton.setTitle("Record", for: .normal)
            playButton.isEnabled = true
            addButton.isEnabled = true
        } else {
            //Start the Recorder
            audioRecorder?.record()
            
            //Change button to 'Stop'
            recordButton.setTitle("Stop", for: .normal)
        }
    }
    
    @IBAction func playTapped(_ sender: Any) {
       
        do {
        audioPlayer = try AVAudioPlayer(contentsOf: audioURL!)
        audioPlayer?.play()
        } catch {
            
        }
    }
    
    @IBAction func addTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let sound = Sound(context: context)
        sound.name = soundNameTextField.text
        sound.audio = NSData(contentsOf: audioURL!)
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = DateFormatter.Style.medium
        let convertedDate = dateFormatter.string(from: currentDate)
        
        sound.dateString = convertedDate

        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController?.popViewController(animated: true)
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
