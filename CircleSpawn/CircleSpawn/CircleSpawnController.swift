import UIKit

class CircleSpawnController: UIViewController {

    private var offsetX: CGFloat = 0
    private var offsetY: CGFloat = 0
	// TODO: Assignment 1

	override func loadView() {
		view = UIView()
		view.backgroundColor = .white
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.checkLongPress))
        gesture.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(gesture)
        self.view.addGestureRecognizer(longPressGesture)
        self.view.isMultipleTouchEnabled = true
	}

    @objc func checkAction(sender : UITapGestureRecognizer) {
        createCircle(tap: sender)
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
        self.view.addSubview(circleView)
    }

    func moveCircle(press: UILongPressGestureRecognizer) {
        
        let point = press.location(in: self.view)
        let filteredSubviews = view.subviews.filter { subView -> Bool in return subView.frame.contains(point)}
        guard let subviewPressed = filteredSubviews.first else {return}
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
