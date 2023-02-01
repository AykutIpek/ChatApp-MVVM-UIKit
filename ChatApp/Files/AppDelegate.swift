//
//  AppDelegate.swift
//  ChatApp
//
//  Created by aykut ipek on 25.01.2023.
//

import UIKit
import FirebaseCore
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = configureNavigationContoller(rootViewController: HomeViewController())
        window?.makeKeyAndVisible()
        FirebaseApp.configure()
        return true
    }
    
    private func configureNavigationContoller(rootViewController: UIViewController)-> UINavigationController{
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemBlue.cgColor,UIColor.systemBlue.cgColor, UIColor.systemPink.cgColor]
        gradient.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.height * 2, height: 64)
        let controller = UINavigationController(rootViewController: rootViewController)
        let apperance = UINavigationBarAppearance()
        apperance.configureWithDefaultBackground()
        apperance.backgroundImage = self.image(fromLayer: gradient)
        apperance.titleTextAttributes = [.foregroundColor: UIColor.white , .font: UIFont.preferredFont(forTextStyle: .title2)]
        controller.navigationBar.standardAppearance = apperance
        controller.navigationBar.compactAppearance = apperance
        controller.navigationBar.scrollEdgeAppearance = apperance
        controller.navigationBar.compactScrollEdgeAppearance = apperance
        return controller
    }
    
    func image(fromLayer layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
}

