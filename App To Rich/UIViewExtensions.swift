import UIKit

extension UIView {

    func transactionAnimation(with duration: CFTimeInterval, timingFuncion: CAMediaTimingFunction, animations: (Void) -> Void) {
        CATransaction.begin()
        CATransaction.disableActions()
        CATransaction.setAnimationDuration(duration)
        CATransaction.setAnimationTimingFunction(timingFuncion)
        animations()
        CATransaction.commit()
    }

    func pinLeading(toLeadingOf view: UIView, constant: CGFloat) {
        NSLayoutConstraint(item: view,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: constant).isActive = true
    }

    @discardableResult func pinTrailing(toTrailingOf view: UIView, constant: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: -constant)
        constraint.isActive = true
        return constraint
    }

    @discardableResult func pinTrailing(toLeadingOf view: UIView, constant: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view,
                                            attribute: .leading,
                                            relatedBy: .equal,
                                            toItem: self,
                                            attribute: .trailing,
                                            multiplier: 1.0,
                                            constant: -constant)
        constraint.isActive = true
        return constraint
    }

    func alignHorizontalAxis(toSameAxisOfView view: UIView) {
        NSLayoutConstraint(item: view,
                           attribute: .centerY,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerY,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
    }

    func pinTop(toTopOf view: UIView, constant: CGFloat) {
        NSLayoutConstraint(item: view,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: constant).isActive = true
    }

    @discardableResult func pinBottom(toBottomOf view: UIView, constant: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: view,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: -constant)
        constraint.isActive = true
        return constraint
    }

    func pinBottom(toTopOf view: UIView, constant: CGFloat) {
        NSLayoutConstraint(item: self,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: -constant).isActive = true
    }

    func setHeight(to constant: CGFloat) {
        NSLayoutConstraint(item: self,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1.0,
                           constant: constant).isActive = true
    }
}

struct CustomTextInputStyle: AnimatedTextInputStyle {
    
    var marginPosition: CGFloat = 25
    let activeColor = ColorUtil.pinkColor
    let inactiveColor = UIColor.gray.withAlphaComponent(0.7)
    let lineInactiveColor = UIColor.gray.withAlphaComponent(0.7)
    let errorColor = UIColor.red
    var textInputFont = UIFont.systemFont(ofSize: 14)
    let textInputFontColor = ColorUtil.pinkColor
    let placeholderMinFontSize: CGFloat = 9
    var placeholderSelfPosition: CGFloat = 9
    let counterLabelFont: UIFont? = UIFont.systemFont(ofSize: 9)
    let leftMargin: CGFloat = 5
    var topMargin: CGFloat = 0
    let rightMargin: CGFloat = 0
    let bottomMargin: CGFloat = 0
    let yHintPositionOffset: CGFloat = 7
    let yPlaceholderPositionOffset: CGFloat = 0
    public let textAttributes: [String: Any]? = nil
}
