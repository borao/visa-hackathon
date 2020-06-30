//
//  SceneDelegate.swift
//  Beta Link
//
//  Created by 徐乾智 on 6/24/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import UIKit
import SwiftUI
import CYLTabBarController 

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        CYLPlusButtonSubclass.register()

        let mainTabBarVc = MainTabBarViewController(viewControllers: self.viewControllers(), tabBarItemsAttributes: self.tabBarItemsAttributesForController())

        if let windowScene = scene as? UIWindowScene {
            print("here")
            self.window = UIWindow(windowScene: windowScene)
            self.window?.frame  = UIScreen.main.bounds
            self.window?.rootViewController = mainTabBarVc
            mainTabBarVc.hideTabBadgeBackgroundSeparator();

            self.window?.makeKeyAndVisible()

            UITabBar.appearance().backgroundColor = UIColor.white
        }
    }
    
    func viewControllers() -> [UINavigationController]{
        let home = UINavigationController(rootViewController: HomeViewController())
        home.navigationBar.tintColor = visaBlue
        let profile =   UINavigationController(rootViewController: ProfileViewController())
        let viewControllers = [home, profile]
        
        return viewControllers
        
    }
    
    
    func tabBarItemsAttributesForController() ->  [[String : String]] {
        
        let tabBarItemOne = [CYLTabBarItemTitle:"Home",
                             CYLTabBarItemImage:"home",
                             CYLTabBarItemSelectedImage:"home_selected"]
        
        let tabBarItemTwo = [CYLTabBarItemTitle:"Profile",
                             CYLTabBarItemImage:"profile",
                             CYLTabBarItemSelectedImage:"profile_selected"]
        let tabBarItemsAttributes = [tabBarItemOne,tabBarItemTwo]
        return tabBarItemsAttributes
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


struct SceneDelegate_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
