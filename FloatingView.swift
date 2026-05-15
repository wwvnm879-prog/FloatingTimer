import UIKit

class FloatingView: UIView {

    private let label = UILabel()

    private var timer: Timer?
    private var timeLeft: Double = 14.00

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        layer.cornerRadius = 20
        clipsToBounds = true

        label.frame = bounds
        label.textAlignment = .center
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(label)

        updateLabel()

        // 拖动
        let pan = UIPanGestureRecognizer(
            target: self,
            action: #selector(handlePan)
        )

        addGestureRecognizer(pan)

        // 缩放
        let pinch = UIPinchGestureRecognizer(
            target: self,
            action: #selector(handlePinch)
        )

        addGestureRecognizer(pinch)

        // 双击开始
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(startTimer)
        )

        tap.numberOfTapsRequired = 2

        addGestureRecognizer(tap)

        // 长按切换透明度
        let longPress = UILongPressGestureRecognizer(
            target: self,
            action: #selector(changeAlpha)
        )

        addGestureRecognizer(longPress)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func updateLabel() {
        label.text = String(format: "%.2f", timeLeft)
    }

    @objc func startTimer() {

        timer?.invalidate()

        timeLeft = 14.00

        updateLabel()

        timer = Timer.scheduledTimer(
            withTimeInterval: 0.01,
            repeats: true
        ) { _ in

            self.timeLeft -= 0.01

            if self.timeLeft <= 0 {

                self.timeLeft = 0

                self.timer?.invalidate()
            }

            self.updateLabel()
        }
    }

    @objc func handlePan(
        _ gesture: UIPanGestureRecognizer
    ) {

        let translation = gesture.translation(
            in: superview
        )

        center = CGPoint(
            x: center.x + translation.x,
            y: center.y + translation.y
        )

        gesture.setTranslation(
            .zero,
            in: superview
        )
    }

    @objc func handlePinch(
        _ gesture: UIPinchGestureRecognizer
    ) {

        transform = transform.scaledBy(
            x: gesture.scale,
            y: gesture.scale
        )

        gesture.scale = 1
    }

    @objc func changeAlpha() {

        if alpha == 1 {

            alpha = 0.4

        } else {

            alpha = 1
        }
    }
}
