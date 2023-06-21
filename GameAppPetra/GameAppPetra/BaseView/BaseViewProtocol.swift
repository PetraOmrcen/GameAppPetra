
public protocol BaseViewProtocol {

    func addViews()

    func styleViews()

    func setupConstraints()

    func setupGestureRecognizers()
}

// MARK: - Default implementation
public extension BaseViewProtocol {

    func styleViews() {
        // The default implementation is empty (styling is not always needed).
    }

    func setupGestureRecognizers() {
        // The default implementation is empty (gestures are not always needed).
    }
}
