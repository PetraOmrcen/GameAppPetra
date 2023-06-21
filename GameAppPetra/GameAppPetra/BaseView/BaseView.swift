
import UIKit


open class BaseView: UIView, BaseViewProtocol {

    public init() {
        super.init(frame: .zero)

        addViews()
        styleViews()
        setupConstraints()
        setupGestureRecognizers()
        setupBinding()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func addViews() {
        preconditionFailure("This method must be overridden")
    }

    open func styleViews() {
        // Default implementation is empty
    }

    open func setupConstraints() {
        preconditionFailure("This method must be overridden")
    }

    open func setupGestureRecognizers() {
        // Default implementation is empty
    }

    open func setupBinding() {
        // Default implementation is empty
    }
}
