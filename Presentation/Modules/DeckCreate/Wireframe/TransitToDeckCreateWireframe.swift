//
//  TransitToDeckCreateWireframe.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 30/08/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Domain
import UIKit

protocol TransitToDeckCreateWireframe: AnyObject {

    var viewController: UIViewController? { get }

    func presentDeckCreate(deckIndex: Int, selectedCardList: [CardModel])
}

extension TransitToDeckCreateWireframe {

    func presentDeckCreate(deckIndex: Int, selectedCardList: [CardModel]) {
        let vc = DeckCreateBuilder.build(deckIndex: deckIndex, selectedCardList: selectedCardList)
        self.viewController?.present(vc, animated: true, completion: nil)
    }
}
