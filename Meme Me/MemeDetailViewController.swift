//
//  MemeDetailViewController.swift
//  Meme Me
//
//  Created by Matheus da Silva Freire on 28/01/23.
//

import UIKit

class MemeDetailViewController: UIViewController {

    // MARK: Properties
    
    var meme: Meme!
    
    // MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
  
        self.tabBarController?.tabBar.isHidden = true
        
        self.imageView!.image = meme.memeImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
