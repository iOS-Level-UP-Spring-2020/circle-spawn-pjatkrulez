import UIKit
class CircleSpawnController: UIViewController {
    

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        let doubleTapGesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkDoubleTap))
        let tripleTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.checkTripleTap))
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.checkLongPress))
        
        doubleTapGesture.numberOfTapsRequired = 2
        tripleTapGesture.numberOfTapsRequired = 3
        doubleTapGesture.delegate = self
        tripleTapGesture.delegate = self
        doubleTapGesture.delaysTouchesBegan = true
        tripleTapGesture.delaysTouchesBegan = true
        doubleTapGesture.require(toFail: tripleTapGesture)
        
        self.view.addGestureRecognizer(tripleTapGesture)
        self.view.addGestureRecognizer(doubleTapGesture)
        self.view.addGestureRecognizer(longPressGesture)
        self.view.isMultipleTouchEnabled = true
    }

    @objc func checkDoubleTap(sender : UITapGestureRecognizer) {
        createCircle(tap: sender)
    }

    @objc func checkTripleTap(sender: UITapGestureRecognizer){
        removeCircle(tap: sender)
    }

    @objc func checkLongPress(sender: UILongPressGestureRecognizer) {
        moveCircle(press: sender)
    }

    func createCircle(tap: UITapGestureRecognizer) {
        let point = tap.location(in: self.view)
        let circleView : UIView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        circleView.center = point
        circleView.backgroundColor = UIColor.randomBrightColor()
        circleView.layer.cornerRadius = 50
        UIView.animate(withDuration: 0.2) {
            circleView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
        UIView.animate(withDuration: 0.1) {
            circleView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        self.view.addSubview(circleView)
    }

    func removeCircle(tap: UITapGestureRecognizer){
        let point = tap.location(in: self.view)
        let filteredSubviews = view.subviews.filter {
            subView -> Bool in return subView.frame.contains(point)
        }
        guard let subviewPressed = filteredSubviews.last else {
            return
        }
        UIView.animate(withDuration: 0.2, animations: {
            subviewPressed.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            subviewPressed.alpha = 0.0
        }, completion: { _ in
            subviewPressed.removeFromSuperview()
        })
        
    }
    
    func moveCircle(press: UILongPressGestureRecognizer) {
        var offsetX: CGFloat = 0
        var offsetY: CGFloat = 0
        let point = press.location(in: self.view)
        let filteredSubviews = view.subviews.filter {
            subView -> Bool in return subView.frame.contains(point)
        }
        guard let subviewPressed = filteredSubviews.last else {
            return
        }
        let center = subviewPressed.center
        switch press.state {
            case .began:
                offsetX = point.x-center.x
                offsetY = point.y-center.y
                UIView.animate(withDuration: 0.2) {
                    subviewPressed.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                    subviewPressed.alpha = 0.5
                }
            case .ended, .failed, .cancelled:
                UIView.animate(withDuration: 0.2) {
                    subviewPressed.transform = CGAffineTransform(scaleX: 1, y: 1)
                    subviewPressed.alpha = 1
                }
            case .changed:
                subviewPressed.center = CGPoint(x: CGFloat(point.x-offsetX), y: CGFloat(point.y-offsetY))
            case .possible:
                return
            @unknown default:
                return
        }
    }

}
