//
//  MemeMeTextFieldDelegate.swift
//  Meme Me
//
//  Created by Matheus da Silva Freire on 15/12/22.
//

import Foundation
import UIKit

class MemeMeTextFieldDelegate : NSObject, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    
}
