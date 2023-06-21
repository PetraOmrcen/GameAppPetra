import UIKit

public extension UIView {

    @discardableResult
    func addAsSubviewOf(_ superview: UIView) -> Self {
        if let stackView = superview as? UIStackView {
            stackView.addArrangedSubview(self)
        } else {
            superview.addSubview(self)
        }
        return self
    }

    @discardableResult
    func backgroundColor(_ backgroundColor: UIColor?) -> Self {
        self.backgroundColor = backgroundColor
        return self
    }

    @discardableResult
    func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }

    @discardableResult
    func isOpaque(_ opaque: Bool) -> Self {
        self.isOpaque = opaque
        return self
    }

    @discardableResult
    func isHidden(_ hidden: Bool) -> Self {
        self.isHidden = hidden
        return self
    }

    @discardableResult
    func isUserInteractionEnabled(_ enabled: Bool) -> Self {
        self.isUserInteractionEnabled = enabled
        return self
    }

    @discardableResult
    func clipsToBounds(_ clipsToBounds: Bool) -> Self {
        self.clipsToBounds = clipsToBounds
        return self
    }

    @discardableResult
    func tag(_ tag: Int) -> Self {
        self.tag = tag
        return self
    }

    @discardableResult
    func contentHuggingPriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        self.setContentHuggingPriority(priority, for: axis)
        return self
    }

    @discardableResult
    func contentCompressionResistancePriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        self.setContentCompressionResistancePriority(priority, for: axis)
        return self
    }

    @discardableResult
    func tintColor(_ tintColor: UIColor) -> Self {
        self.tintColor = tintColor
        return self
    }

    @discardableResult
    func layoutMargins(_ layoutMargins: UIEdgeInsets) -> Self {
        self.layoutMargins = layoutMargins
        return self
    }

    @discardableResult
    func addSubviews(_ views: UIView...) -> Self {
        addSubviews(views.map { $0 })
    }

    @discardableResult
    func addSubviews(_ views: [UIView]) -> Self {
        views.forEach {
            $0.addAsSubviewOf(self)
        }

        return self
    }

    // MARK: - Layer helper methods

    @discardableResult
    func cornerRadius(_ cornerRadius: CGFloat) -> Self {
        self.layer.cornerRadius(cornerRadius)
        return self
    }

    @discardableResult
    func masksToBounds(_ masksToBounds: Bool) -> Self {
        self.layer.masksToBounds(masksToBounds)
        return self
    }

    @discardableResult
    func borderWidth(_ borderWidth: CGFloat) -> Self {
        self.layer.borderWidth(borderWidth)
        return self
    }

    @discardableResult
    func borderColor(_ borderColor: UIColor?) -> Self {
        self.layer.borderColor(borderColor?.cgColor)
        return self
    }
}
