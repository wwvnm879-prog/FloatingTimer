import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear

        let floating = FloatingView(
            frame: CGRect(x: 120, y: 250, width: 160, height: 160)
        )

        view.addSubview(floating)
    }
}
