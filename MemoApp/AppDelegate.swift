//
//  AppDelegate.swift
//  MemoApp
//
//  Created by 吉川椛 on 2019/11/21.
//  Copyright © 2019 com.litech. All rights reserved.
//

import UIKit
import Siren


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 起動ごとにアラート表示、強制アップデートのルール
        let forceRules = Rules.init(promptFrequency: .immediately, forAlertType: .force)

        // 1日１回アラート表示、アップデートのタイミングはユーザが選べるルール
        let optionRules = Rules.init(promptFrequency: .daily, forAlertType: .option)

        // メジャーバージョンが上がった場合は強制アップデート
        // マイナーバージョン以下のアップデートの場合はユーザに選択可能とする
        let siren = Siren.shared
        siren.rulesManager = RulesManager(
            majorUpdateRules: forceRules,
            minorUpdateRules: optionRules,
            patchUpdateRules: optionRules,
            revisionUpdateRules: optionRules,
            showAlertAfterCurrentVersionHasBeenReleasedForDays: 1
        )
        // Override point for customization after application launch.
//
//        //使用するStoryboardのインスタンス化
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        //UserDefaultsにBool型のkey"launchedBefore"を用意
//        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
//
//        if (launchedBefore == true) {
//            UserDefaults.standard.set(false, forKey: "launchedBefore")
//        } else {
//            //起動を判定するlaunchedBeforeという論理型のKeyをUserDefaultsに用意
//            UserDefaults.standard.set(true, forKey: "launchedBefore")
//
//            //チュートリアル用のviewcontrollerのインスタンスを用意してwindowに渡す
//            let tutorialVC = storyboard.instantiateViewController(withIdentifier: "first") as! FirstViewController
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//            self.window?.rootViewController = tutorialVC
//        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

