// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#elseif os(tvOS) || os(watchOS)
import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
    internal static let chestEpic = ImageAsset(name: "chest-epic")
    internal static let chestGiant = ImageAsset(name: "chest-giant")
    internal static let chestGold = ImageAsset(name: "chest-gold")
    internal static let chestGoldcrate = ImageAsset(name: "chest-goldcrate")
    internal static let chestLegendary = ImageAsset(name: "chest-legendary")
    internal static let chestMagical = ImageAsset(name: "chest-magical")
    internal static let chestMegalightning = ImageAsset(name: "chest-megalightning")
    internal static let chestOverflowinggoldcrate = ImageAsset(name: "chest-overflowinggoldcrate")
    internal static let chestPlentifulgoldcrate = ImageAsset(name: "chest-plentifulgoldcrate")
    internal static let chestRoyalwild = ImageAsset(name: "chest-royalwild")
    internal static let chestSilver = ImageAsset(name: "chest-silver")
    internal static let cardPlaceholder26000069 = ImageAsset(name: "card_placeholder_26000069")
    internal static let cardPlaceholder26000072 = ImageAsset(name: "card_placeholder_26000072")
    internal static let cardPlaceholder26000074 = ImageAsset(name: "card_placeholder_26000074")
    internal static let deckAverageElixir = ImageAsset(name: "deck_average_elixir")
    internal static let deckFourCycleElixir = ImageAsset(name: "deck_four_cycle_elixir")
    internal static let playerTrophy = ImageAsset(name: "player_trophy")
    internal static let titleIcon = ImageAsset(name: "title_icon")
    internal static let registerLogo = ImageAsset(name: "Register_logo")
    internal static let signinExample1 = ImageAsset(name: "Signin_Example_1")
    internal static let signinExample2 = ImageAsset(name: "Signin_Example_2")
    internal static let signinExample3 = ImageAsset(name: "Signin_Example_3")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ImageAsset {
    internal fileprivate(set) var name: String

    #if os(macOS)
    internal typealias Image = NSImage
    #elseif os(iOS) || os(tvOS) || os(watchOS)
    internal typealias Image = UIImage
    #endif

    @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
    internal var image: Image {
        let bundle = BundleToken.bundle
        #if os(iOS) || os(tvOS)
        let image = Image(named: name, in: bundle, compatibleWith: nil)
        #elseif os(macOS)
        let name = NSImage.Name(self.name)
        let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
        #elseif os(watchOS)
        let image = Image(named: name)
        #endif
        guard let result = image else {
            fatalError("Unable to load image asset named \(name).")
        }
        return result
    }

    #if os(iOS) || os(tvOS)
    @available(iOS 8.0, tvOS 9.0, *)
    internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
        let bundle = BundleToken.bundle
        guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
            fatalError("Unable to load image asset named \(name).")
        }
        return result
    }
    #endif
}

internal extension ImageAsset.Image {
    @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
    @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
    convenience init!(asset: ImageAsset) {
        #if os(iOS) || os(tvOS)
        let bundle = BundleToken.bundle
        self.init(named: asset.name, in: bundle, compatibleWith: nil)
        #elseif os(macOS)
        self.init(named: NSImage.Name(asset.name))
        #elseif os(watchOS)
        self.init(named: asset.name)
        #endif
    }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle(for: BundleToken.self)
        #endif
    }()
}
// swiftlint:enable convenience_type
