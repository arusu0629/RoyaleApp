// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias AssetImageTypeAlias = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias AssetImageTypeAlias = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

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

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct DataAsset {
  internal fileprivate(set) var name: String

  #if os(iOS) || os(tvOS) || os(OSX)
  @available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
  internal var data: NSDataAsset {
    return NSDataAsset(asset: self)
  }
  #endif
}

#if os(iOS) || os(tvOS) || os(OSX)
@available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
internal extension NSDataAsset {
  convenience init!(asset: DataAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(OSX)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: AssetImageTypeAlias {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = AssetImageTypeAlias(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = AssetImageTypeAlias(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal extension AssetImageTypeAlias {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
