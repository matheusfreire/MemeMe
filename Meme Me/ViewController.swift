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
        NSAttributedString.Key.strokeWidth:  -4.0,
    ]
    
    // MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        initializeTextField(topTextField, text: "TOP")
        initializeTextField(bottomTextField, text: "BOTTOM")
        shareButton.isEnabled = false
    }
    
    private func initializeTextField(_ textField: UITextField, text: String) {
        textField.text = text
        textField.textAlignment = .center
        textField.delegate = textFieldDelegate
        textField.defaultTextAttributes = memeTextAttributes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
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
    
    @IBAction func shareAction(_sender: Any) {
        let memeImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        activityController.completionWithItemsHandler = { activity, success, items, error in
            self.save()
            self.dismiss(animated: true, completion: nil)
        }
        
        present(activityController, animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {

        // Render view to an image
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        topToolbar.isHidden = true
        bottomToolbar.isHidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        bottomToolbar.isHidden = false
        topToolbar.isHidden = false

        return memedImage
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        shareButton.isEnabled = true
        dismiss(animated: true)
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if view.frame.origin.y == 0 {
            view.frame.origin.y = -getKeyboardHeight(notification)
       }
    }
                                               
    @objc func keyboardWillDisappear(_ notification: Notification) {
       view.frame.origin.y = 0
    }
    
    
    func save() {
        let meme = Meme(topText: topTextField.text, bottomText: bottomTextField.text, originalImage: imageView.image!, memeImage: generateMemedImage())
    }
}
