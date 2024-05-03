//
//  SceneDelegate.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let sceneWindow = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: sceneWindow)

        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }

    // the launcher view controller that implemented by view model
    private var viewController: MissionListViewController {

        // implement network layer
        let network = Network(
            apiHandler: APIHandlerImp(),
            responseHandler: ResponseHandlerImp()
        )

        // implement mission list service

        // implement view model
        let viewModel = MissionListViewModel()

        // return view controller by implemented via view model
        return MissionListViewController()
    }
}

