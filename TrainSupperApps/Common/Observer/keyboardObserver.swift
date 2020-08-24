//
//  keyboardObserver.swift
//  TrainSupperApps
//
//  Created by Adli Raihan on 22/08/20.
//  Copyright © 2020 Adli Raihan. All rights reserved.
//

import UIKit
import SwiftUI

class keyboardObserver: ObservableObject {
    
    @Published var rectKeyboard: CGRect = .init()
    private var rectIsModified: Bool = false
    private var diffRect: CGSize = .init()
    private var diffTextField: CGRect = .init()
    private var diffFromSreen: CGPoint = .init()
    
    func createObservable(_ setDiffRect: CGSize) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldRect(_:)), name: UITextField.textDidBeginEditingNotification, object: nil)
        self.diffRect = setDiffRect
    }
    
    func removeObservable() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidBeginEditingNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Any) {
        if let _sender = sender as? NSNotification {
            if let userInfo = _sender.userInfo {
                if let frameBegin = userInfo["UIKeyboardFrameBeginUserInfoKey"], let _frame = frameBegin as? CGRect {
                    self.calculateDiff(_frame)
                }
            }
        }
    }
    
    @objc func keyboardWillHide(_ sender: Any) {
        self.rectKeyboard = .init(x: 0, y: 0, width: 0, height: 0)
    }
    
    @objc func textFieldRect(_ sender: Any) {
        if let _sender = sender as? NSNotification {
            if let _obj = _sender.object as? UITextField {
                self.diffTextField = _obj.frame
                self.diffFromSreen = _obj.convert(screenBounds.origin, to: nil)
            }
        }
        print(sender)
    }
    
    private func calculateDiff(_ frameInfo: CGRect) {
        let yDiff = (diffFromSreen.y + frameInfo.size.height) - diffRect.height
        print(yDiff)
        self.rectKeyboard = .init(x: 0, y: -yDiff, width: 0, height: 0)
    }
    
}
