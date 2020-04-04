//
//  nib.swift
//  AppleMusicPlayer
//
//  Created by Damir Lutfullin on 04.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import UIKit

extension UIView {
    
    class func loadViewNib <T: UIView> () -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?.first as! T
    }
}
