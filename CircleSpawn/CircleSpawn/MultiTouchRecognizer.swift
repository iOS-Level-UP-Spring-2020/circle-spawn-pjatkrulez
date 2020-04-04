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
    
    var subviewPressed: UIView = UIView()
    var point: CGPoint = CGPoint()
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent ) {
        for touch in touches {
            point = touch.location(in: view)
            print(point)
            let filteredSubviews = view?.subviews.filter {
                subView -> Bool in return subView.frame.contains(point)
            }
            if(filteredSubviews!.isEmpty){
                return
            }
            
            subviewPressed = filteredSubviews!.last!
            let center = subviewPressed.center
            
             = point.x-center.x
            print("x \(CircleSpawnController().offsetX)")
            CircleSpawnController().offsetY = point.y-center.y
            print("y \(CircleSpawnController().offsetY)")
            UIView.animate(withDuration: 0.2) {
                self.subviewPressed.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                self.subviewPressed.alpha = 0.5
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        UIView.animate(withDuration: 0.2) {
            self.subviewPressed.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.subviewPressed.alpha = 1
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        UIView.animate(withDuration: 0.2) {
            self.subviewPressed.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.subviewPressed.alpha = 1
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        self.subviewPressed.center = CGPoint(x: CGFloat(point.x-CircleSpawnController().offsetX), y: CGFloat(point.y-CircleSpawnController().offsetY))
    }

}
