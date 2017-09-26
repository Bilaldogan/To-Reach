import UIKit
import Foundation

public protocol AnimatedTextInputStyle {
    var activeColor: UIColor { get }
    var inactiveColor: UIColor { get }
    var lineInactiveColor: UIColor { get }
    var errorColor: UIColor { get }
    var textInputFont: UIFont { get set }
    var textInputFontColor: UIColor { get }
    var placeholderMinFontSize: CGFloat { get }
    var placeholderSelfPosition: CGFloat { get set }
    var counterLabelFont: UIFont? { get }
    var leftMargin: CGFloat { get }
    var topMargin: CGFloat { get set}
    var rightMargin: CGFloat { get }
    var bottomMargin: CGFloat { get }
    var marginPosition: CGFloat { get set }
    var yHintPositionOffset: CGFloat { get }
    var yPlaceholderPositionOffset: CGFloat { get }
    var textAttributes: [String: Any]? { get }
}

public struct AnimatedTextInputStyleBlue: AnimatedTextInputStyle {

    public let activeColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    public let inactiveColor = UIColor.black.withAlphaComponent(1.0)
    public let lineInactiveColor = UIColor.black.withAlphaComponent(1.0)
    public let errorColor = UIColor.red
    public var textInputFont = UIFont.systemFont(ofSize: 14)
    public let textInputFontColor = UIColor.black
    public let placeholderMinFontSize: CGFloat = 9
    public var placeholderSelfPosition: CGFloat = 10
    public let counterLabelFont: UIFont? = UIFont.systemFont(ofSize: 9)
    public var marginPosition: CGFloat = 25
    public let leftMargin: CGFloat = 5
    public var topMargin: CGFloat = 20
    public let rightMargin: CGFloat = 0
    public let bottomMargin: CGFloat = 0
    public let yHintPositionOffset: CGFloat = 7
    public let yPlaceholderPositionOffset: CGFloat = 0
    //Text attributes will override properties like textInputFont, textInputFontColor...
    public let textAttributes: [String: Any]? = nil

    public init() { }
}
