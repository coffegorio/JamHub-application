//
//  SceneDelegate.swift
//  JHApp
//
//  Created by Егорио on 24.11.2024.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupWindow(with: scene)
        checkAuthentication()
    }

    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
    }

    public func checkAuthentication() {
            if let currentUser = Auth.auth().currentUser {
//                print("Пользователь авторизован: \(currentUser.email ?? "неизвестно")")
                goToController(with: createTabBarController())  // Показываем TabBarController
            } else {
//                print("Пользователь не авторизован.")
                goToController(with: WelcomeScreenVC())  // Показываем WelcomeScreen
            }
        }

    private func goToController(with viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.25, animations: {
                self?.window?.layer.opacity = 0
            }) { [weak self] _ in
                let navigationController = UINavigationController(rootViewController: viewController)
                self?.window?.rootViewController = navigationController
                UIView.animate(withDuration: 0.25) {
                    self?.window?.layer.opacity = 1
                }
            }
        }
    }
    
    private func createTabBarController() -> UITabBarController {
        
        let homeScreenVC = UINavigationController(rootViewController: HomeScreenVC())
        let createPartyScreenVC = UINavigationController(rootViewController: CreatePartyScreenVC())
        let settingsScreenVC = UINavigationController(rootViewController: SettingsScreenVC())

        homeScreenVC.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        createPartyScreenVC.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "person.3"),
            selectedImage: UIImage(systemName: "person.3.fill")
        )
        settingsScreenVC.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeScreenVC, createPartyScreenVC, settingsScreenVC]

        tabBarController.tabBar.items?.forEach { item in
            item.title = nil
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0) // Сместить иконку, чтобы она была по центру
        }
        
        tabBarController.tabBar.tintColor = Styles.Colors.appThemeColor
        tabBarController.tabBar.unselectedItemTintColor = .gray

        return tabBarController
    }

    
}
