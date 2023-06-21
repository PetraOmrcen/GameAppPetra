import UIKit

public extension CALayer {

    @discardableResult
    func frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }

    @discardableResult
    func backgroundColor(_ backgroundColor: CGColor?) -> Self {
        self.backgroundColor = backgroundColor
        return self
    }

    @discardableResult
    func cornerRadius(_ cornerRadius: CGFloat) -> Self {
        self.cornerRadius = cornerRadius
        return self
    }

    @discardableResult
    func borderWidth(_ borderWidth: CGFloat) -> Self {
        self.borderWidth = borderWidth
        return self
    }

    @discardableResult
    func borderColor(_ borderColor: CGColor?) -> Self {
        self.borderColor = borderColor
        return self
    }

    @discardableResult
    func opacity(_ opacity: Float) -> Self {
        self.opacity = opacity
        return self
    }

    @discardableResult
    func masksToBounds(_ masksToBounds: Bool) -> Self {
        self.masksToBounds = masksToBounds
        return self
    }

    @discardableResult
    func shadowColor(_ shadowColor: CGColor?) -> Self {
        self.shadowColor = shadowColor
        return self
    }

    @discardableResult
    func shadowOpacity(_ shadowOpacity: Float) -> Self {
        self.shadowOpacity = shadowOpacity
        return self
    }

    @discardableResult
    func shadowOffset(_ shadowOffset: CGSize) -> Self {
        self.shadowOffset = shadowOffset
        return self
    }

    @discardableResult
    func shadowRadius(_ shadowRadius: CGFloat) -> Self {
        self.shadowRadius = shadowRadius
        return self
    }
}
