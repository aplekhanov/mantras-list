import UIKit

final class CustomFont {
    static func nunitoBoldFont(ofSize size: CGFloat) -> UIFont {
        let font = UIFont(name: "Nunito-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
        return font
    }
    
    static func peachiBlackFont(ofSize size: CGFloat) -> UIFont {
        let font = UIFont(name: "Peachi-Black", size: size) ?? UIFont.systemFont(ofSize: size, weight: .black)
        return font
    }
}
