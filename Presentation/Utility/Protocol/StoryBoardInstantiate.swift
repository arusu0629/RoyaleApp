//
//  StoryBoardInstantiate.swift
//  Presentation
//
//  Created by nakandakari on 2020/05/29.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import UIKit

extension UIViewController: StoryboardInstantiate {}

protocol StoryboardInstantiate {
    static func instantiate() -> Self
}

extension StoryboardInstantiate where Self: UIViewController {
    
    static func instantiate() -> Self {
        let bundle = Bundle(for: self.self)
        let name = String(describing: self.self)
        
        guard let vc = UIStoryboard(name: name, bundle: bundle).instantiateInitialViewController() as? Self else {
            fatalError("UIViewController.instantiate() failed: \(name)")
        }

        return vc
    }
}
