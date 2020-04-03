import UIKit

class CircleSpawnController: UIViewController {

	// TODO: Assignment 1

	override func loadView() {
		view = UIView()
		view.backgroundColor = .white
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        gesture.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(gesture)
	}

    @objc func checkAction(sender : UITapGestureRecognizer) {
        createCircle(tap: sender)
     }
    
    func createCircle(tap: UITapGestureRecognizer){
        let point = tap.location(in: self.view)
        let circleView : UIView = UIView(frame: CGRect(x: point.x, y: point.y, width: 100, height: 100))
        circleView.backgroundColor = UIColor.randomBrightColor()
        circleView.layer.cornerRadius = 50
        self.view.addSubview(circleView)
    }
}
