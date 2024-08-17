//
//  HomeModuleBuilder.swift
//  MovieLinkDemoTest
//
//  Created by Vijay Lal on 17/08/24.
//

import Foundation
import UIKit
class HomeModuleBuilder {
    func buildModel() -> UIViewController {
        let vc = HomeController()
        let networkLayer = NetworkLayer()
        let viewModel = HomeViewModel(networkLayer: networkLayer)
        vc.viewModel = viewModel
        return vc
    }
}
