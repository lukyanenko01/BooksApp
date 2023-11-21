//
//  SceneDelegate.swift
//  BooksApp
//
//  Created by Vladimir Lukyanenko on 21.11.2023.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let vc = UIHostingController(rootView: MainPage(viewModel: MainPageViewModel()))
        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
    }




}

