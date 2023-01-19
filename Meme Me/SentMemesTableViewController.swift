//
//  SentMemesTableViewController.swift
//  Meme Me
//
//  Created by Matheus da Silva Freire on 16/01/23.
//

import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties
    var memes: [Meme]! {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    
    // MARK: Action function
    @IBAction func newMeme(_ sender: Any) {
        let editMemeController = self.storyboard!.instantiateViewController(withIdentifier: "EditMemeController") as! EditMemeController
        self.navigationController?.pushViewController(editMemeController, animated: true)
    }
    
    // MARK: Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")!
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = String("\(meme.topText) \(meme.bottomText)")
        cell.imageView?.image = meme.memeImage
        
        return cell
    }
    
}
