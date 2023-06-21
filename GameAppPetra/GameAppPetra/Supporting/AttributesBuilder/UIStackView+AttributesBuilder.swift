import UIKit

@objc public extension UIStackView {

    @discardableResult
    func axis(_ axis: NSLayoutConstraint.Axis) -> Self {
        self.axis = axis
        return self
    }

    @discardableResult
    func alignment(_ alignment: UIStackView.Alignment) -> Self {
        self.alignment = alignment
        return self
    }

    @discardableResult
    func distribution(_ distribution: UIStackView.Distribution) -> Self {
        self.distribution = distribution
        return self
    }

    @discardableResult
    func spacing(_ spacing: CGFloat) -> Self {
        self.spacing = spacing
        return self
    }

    @discardableResult
    func addArrangedSubviews(_ views: [UIView]) -> Self {
        for view in views {
            addArrangedSubview(view)
        }
        return self
    }

    @discardableResult
    func removeArrangedSubviews() -> Self {
        for view in self.arrangedSubviews {
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        return self
    }

    @discardableResult
    func addBackground(color: UIColor) -> Self {
        let view = UIView(frame: bounds)
        view.backgroundColor = color
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(view, at: 0)

        return self
    }
}

public extension UIStackView {

    @discardableResult
    func addArrangedSubviews(_ views: UIView...) -> Self {
        for view in views {
            addArrangedSubview(view)
        }
        return self
    }
}
