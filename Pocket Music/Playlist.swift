//
//  Playlist.swift
//  Pocket Music
//
//  Created by Hai Duong on 12/8/18.
//  Copyright © 2018 Hai Duong. All rights reserved.
//

import UIKit

protocol PlaylistDelegate {
    func passSong(row: Int)
}

class Playlist: UITableViewController {
    
    var playlistDelegate: PlaylistDelegate?
    
    var library = MusicLibrary().songChoices
    
    var titleAudio = ""
    var artist = ""
    var songRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 
        // #warning Incomplete implementation, return the number of rows
        return library.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! PlaylistCell
        
        cell.SongLabel.text = library[indexPath.row]["title"]
        cell.ArtistLabel.text = library[indexPath.row]["artist"]
        
        if let coverPic = library[indexPath.row]["cover"] {
            //cell.CoverImage.contentMode = UIView.ContentMode.scaleAspectFit
            cell.CoverImage.image = UIImage(named: "\(coverPic)")
            
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->
        CGFloat {
            return 160.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        songRow = indexPath.row
        
        playlistDelegate?.passSong(row: songRow)
        self.navigationController?.popViewController(animated: true)
    }
}
