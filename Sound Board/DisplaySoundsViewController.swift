//
//  DisplaySoundsViewController.swift
//  Sound Board
//
//  Created by Zeean Veljee on 29/05/17.
//  Copyright © 2017 Zed. All rights reserved.
//

import UIKit
import AVFoundation


class DisplaySoundsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var audioPlayer: AVAudioPlayer?
    var sounds: [Sound] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
          sounds = try context.fetch(Sound.fetchRequest())
            tableView.reloadData()
        } catch {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sounds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "soundCell", for: indexPath) as! SoundTableViewCell
        
        let sound = sounds[indexPath.row]
        
        cell.soundNameLabel.text = sound.name
        cell.descriptionLabel.text = "default"
        cell.dateLabel.text = sound.dateString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sound = sounds[indexPath.row]
        
        do {
            audioPlayer = try AVAudioPlayer(data: sound.audio! as Data)
            audioPlayer?.play()
        } catch {
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let sound = sounds[indexPath.row]
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            context.delete(sound)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                sounds  = try context.fetch(Sound.fetchRequest())
                tableView.reloadData()
            }
            catch {
                
            }
            
        }
    }
    
    
    
}

