//
//  SceneDelegate.swift
//  Digilearn_001
//
//  Created by Teke on 02/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = LoginViewController()
        window?.makeKeyAndVisible()
        
        let preferences = UserDefaults.standard
        let userId = preferences.string(forKey: DigilearnsKeys.USER_ID)
        let firstInstall = preferences.string(forKey: DigilearnsKeys.FIRST_INSTALL)
        
        if firstInstall == nil {
            
            preferences.set("done", forKey: DigilearnsKeys.FIRST_INSTALL)
            preferences.synchronize()
            
            window?.rootViewController = OnboardingViewController()
            window?.makeKeyAndVisible()
            
        }else if(userId != nil){
//            window?.rootViewController = HomeViewController()
//            window?.rootViewController = LoginViewController()
            window?.rootViewController = UINavigationController(rootViewController: HomeTabBarController())

            window?.makeKeyAndVisible()
        }else{
            window?.rootViewController = OnboardingViewController()
            window?.makeKeyAndVisible()
        }
        
        UITabBar.appearance().tintColor = UIColor(named: "color_ B63532")

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

