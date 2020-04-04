//
//  MultiTouchRecognizer.swift
//  CircleSpawn
//
//  Created by Jan Biernacki on 04/04/2020.
//  Copyright © 2020 DaftAcademy. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class MultiTouchRecognizer: UIGestureRecognizer {
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (touches.count >= 2){
            state = .began
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .ended
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .cancelled
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .changed
    }
}
