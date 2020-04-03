import UIKit

class CircleSpawnController: UIViewController {

	// TODO: Assignment 1

	override func loadView() {
		view = UIView()
		view.backgroundColor = .white
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.checkLongPress))
        gesture.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(gesture)
        self.view.addGestureRecognizer(longPress)
	}

    @objc func checkAction(sender : UITapGestureRecognizer) {
        createCircle(tap: sender)
     }
    
    @objc func checkLongPress(sender: UILongPressGestureRecognizer) {
        moveCircle(press: sender)
    }
    
    func createCircle(tap: UITapGestureRecognizer){
        let point = tap.location(in: self.view)
        let circleView : UIView = UIView(frame: CGRect(x: point.x, y: point.y, width: 100, height: 100))
        circleView.backgroundColor = UIColor.randomBrightColor()
        circleView.layer.cornerRadius = 50
        self.view.addSubview(circleView)
    }
    
    func moveCircle(press: UILongPressGestureRecognizer){
        let point = press.location(in: self.view)
        let filteredSubviews = view.subviews.filter { subView -> Bool in
          return subView.frame.contains(point)
        }
        guard let subviewPressed = filteredSubviews.first else {
          return
        }
        subviewPressed.center = point
    }
    
    
    
}
