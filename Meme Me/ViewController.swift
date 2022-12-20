//
//  ViewController.swift
//  Meme Me
//
//  Created by Matheus da Silva Freire on 15/12/22.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
                        UINavigationControllerDelegate {
    
    // MARK: Properties
    
    let textFieldDelegate = MemeMeTextFieldDelegate()
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  3.0
    ]
    
    // MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    // MARK: Life Cy;e
    override func viewDidLoad() {
        super.viewDidLoad()
       
        initializeTextField(topTextField)
        initializeTextField(bottomTextField)
    }
    
    private func initializeTextField(_ textField: UITextField) {
        textField.text = "NEW TEXT"
        textField.textAlignment = .center
        textField.delegate = textFieldDelegate
        textField.defaultTextAttributes = memeTextAttributes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    // MARK: Actions

    @IBAction func pickAnImageFromAlbum(_ sender:Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender:Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        dismiss(animated: true)
    }

}

