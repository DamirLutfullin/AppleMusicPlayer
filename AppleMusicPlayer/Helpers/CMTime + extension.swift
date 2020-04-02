//
//  CMTime + extention.swift
//  AppleMusicPlayer
//
//  Created by Damir Lutfullin on 03.04.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation
import AVKit

extension CMTime {
    
    func convertToString() -> String {
        
        guard !CMTimeGetSeconds(self).isNaN else {
            return ""
        }
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let string = String(format: "%02d:%02d" , minutes, seconds)
        return string
    }
}
