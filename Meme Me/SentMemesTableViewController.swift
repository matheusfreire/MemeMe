//
//  SentMemesTableViewController.swift
//  Meme Me
//
//  Created by Matheus da Silva Freire on 16/01/23.
//

import UIKit

// MARK: - SentMemesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate

class SentMemesTableViewController: UITableViewController {
    
    // MARK: Properties
    var memes: [Meme]! {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    
    // MARK: Life Cyle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        tableView!.reloadData()
    }
    
    // MARK: Action function
    @IBAction func newMeme(_ sender: Any) {
        let editMemeController = self.storyboard!.instantiateViewController(withIdentifier: "EditMemeController") as! EditMemeController
        self.navigationController?.pushViewController(editMemeController, animated: true)
    }
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")!
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = String("\(meme.topText) \(meme.bottomText)")
        cell.imageView?.image = meme.memeImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
}
