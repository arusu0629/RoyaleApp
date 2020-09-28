//
//  SoundManager.swift
//  Presentation
//
//  Created by nakandakari on 2020/09/05.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation
import AVFoundation

enum SoundEffect {
    case selectCell
    case selectTab
    case selectSortButton
    case selectMenu

    var fileName: String {
        switch self {
        case .selectCell:
            return "card_fly_in_06"
        case .selectTab, .selectSortButton, .selectMenu:
            return "menu_click_06"
        }
    }

    var fileType: String {
        switch self {
        case .selectCell, .selectTab, .selectSortButton, .selectMenu:
            return "mp3"
        }
    }
}

final class SoundManager {

    static let shared = SoundManager()
    private init() {}

    private var player: AVAudioPlayer?

}

extension SoundManager {

    private func prepareSoundEffect(_ se: SoundEffect) {
        guard let soundPath = Bundle.main.path(forResource: se.fileName, ofType: se.fileType) else {
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundPath))
            player?.prepareToPlay()
        } catch let error {
            print("failed to prepare se = \(se) error = \(error)")
        }
    }

    func playSoundEffect(_ se: SoundEffect) {
        guard let soundPath = Bundle.main.path(forResource: se.fileName, ofType: se.fileType) else {
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundPath))
            player?.play()
        } catch let error {
            print("failed to play se = \(se) error = \(error)")
        }
    }
}
