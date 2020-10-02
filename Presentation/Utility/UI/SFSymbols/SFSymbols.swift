//
//  SFSymbols.swift
//  Presentation
//
//  Created by nakandakari on 2020/07/18.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import UIKit

final class SFSymbols {

    // MARK: - RootViewController
    static var homeIconImage:     UIImage { return UIImage(systemName: "house")!.withTintColor(SFSymbols.iconImageColor) }
    static var homeFillIconImage: UIImage { return UIImage(systemName: "house.fill")!.withTintColor(SFSymbols.fillIconImageColor) }

    static var deckIconImage:     UIImage { return UIImage(systemName: "doc")!.withTintColor(SFSymbols.iconImageColor) }
    static var deckFillIconImage: UIImage { return UIImage(systemName: "doc.fill")!.withTintColor(SFSymbols.fillIconImageColor) }

    static var webIconImage:     UIImage { return UIImage(systemName: "globe")!.withTintColor(SFSymbols.iconImageColor) }
    static var webFillIconImage: UIImage { return UIImage(systemName: "globe")!.withTintColor(SFSymbols.fillIconImageColor) }

    // MARK: - WebViewController
    static var arrowLeftIconImage: UIImage { return UIImage(systemName: "arrow.left")!.withTintColor(SFSymbols.iconImageColor) }
    static var arrowRightIconImage: UIImage { return UIImage(systemName: "arrow.right")!.withTintColor(SFSymbols.iconImageColor) }
    static var arrowReloadIconImage: UIImage { return UIImage(systemName: "arrow.counterclockwise")!.withTintColor(SFSymbols.iconImageColor) }

}

extension SFSymbols {
    static var iconImageColor:     UIColor { return .systemGray }
    static var fillIconImageColor: UIColor { return .systemBlue }
}
