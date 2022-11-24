//
//  View+cornerRadius.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 20/10/2022.
//

import Foundation
import UIKit

extension UIView {
    
    // Add corner radius parameter
  @IBInspectable var cornerRadius: CGFloat {
   get{
        return layer.cornerRadius
    }
    set {
        layer.cornerRadius = newValue
        layer.masksToBounds = newValue > 0
    }
  }
    
}
