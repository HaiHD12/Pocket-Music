//
//  PocketMain.swift
//  Pocket Music
//
//  Created by Hai Duong on 11/28/18.
//  Copyright © 2018 Hai Duong. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class PocketMain: UIViewController, PlaylistDelegate {
    
    var library = MusicLibrary().songChoices
    
    @IBOutlet weak var CoverImage: UIImageView!
    @IBOutlet weak var ProgressBar: UIProgressView!
    @IBOutlet weak var SongTitle: UILabel!
    @IBOutlet weak var Artist: UILabel!
    @IBOutlet weak var shuffle: UISwitch!
    
    var player: AVAudioPlayer!
    
    func passSong(row: Int) {
        self.songIndex = row

        SongTitle.text = library[row]["title"]
        Artist.text = library[row]["artist"]
        CoverImage.image = UIImage(named: "\(library[row]["title"]!).jpg")

        let path = Bundle.main.path(forResource: library[songIndex]["title"], ofType: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            player.play()
            
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PocketMain.updateProgressView), userInfo: nil, repeats: true)
            ProgressBar.setProgress(Float(player.currentTime/player.duration), animated: true)
        } catch {
            print("Can't Play Song")
        }
    }
    
    
    @objc func updateProgressView() {
        if player.isPlaying {
            ProgressBar.setProgress(Float(player.currentTime/player.duration), animated: true)
        }
    }
    
    func passInst(string: String) {
        self.mode = string
    }
    
    var songIndex = 0
    var mode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addFadeBackground(top: primary, bottom: secondary)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func play(_ sender: Any) {
        if player != nil {
            if !player.isPlaying {
                player.play()
            }
        }
    }
    
    @IBAction func pause(_ sender: Any) {
        player.pause()
    }
    
    @IBAction func stop(_ sender: Any) {
        player.stop()
        player.currentTime = 0
        ProgressBar.progress = 0
    }
    
    @IBAction func fastForward(_ sender: Any) {
        var time: TimeInterval = player.currentTime
        time += 0.5
        
        if time < player.duration {
            player.currentTime = time
        }
    }
    
    @IBAction func rewind(_ sender: Any) {
        var time: TimeInterval = player.currentTime
        time -= 0.5
        
        if time > 0 {
            player.currentTime = time
        }
    }
    
    
    var previousSong = 0
    @IBAction func nextSong(_ sender: Any) {
        if songIndex == 0 || songIndex < library.count {
            if shuffle.isOn {
                previousSong = songIndex
                var randIndex = Int(arc4random_uniform(UInt32(library.count)))
                while randIndex == songIndex {
                    randIndex = Int(arc4random_uniform(UInt32(library.count)))
                }
                
                songIndex = randIndex
            } else {
            songIndex += 1
            }
            passSong(row: songIndex)
        }
    }
    
    
    @IBAction func backSong(_ sender: Any) {
        if ProgressBar.progress != 0 {
            player.stop()
            player.currentTime = 0
            ProgressBar.progress = 0
        } else if songIndex != 0 || songIndex > 0 {
            if shuffle.isOn {
               songIndex = previousSong
            } else {
                songIndex -= 1
            }
            
            passSong(row: songIndex)
        }
    }
    
    @IBAction func signOut(_ sender: Any) {
        try! Auth.auth().signOut()
        if player != nil {
            if player.isPlaying {
                player.stop()
            }
        } 
        self.dismiss(animated: false, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlaylistSegue" {
            if let target = segue.destination as? Playlist {
                target.playlistDelegate = self
            }
        }
    }
    
}

