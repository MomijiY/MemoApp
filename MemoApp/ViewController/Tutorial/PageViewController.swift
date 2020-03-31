//
//  TutorialPageViewController.swift
//  MemoApp
//
//  Created by 吉川椛 on 2020/03/18.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    var pageViewControllers: [UIViewController] = []
    var nowPage: Int = 0
    //var currentPageでページ番号を管理
    var currentPage = 0
    
    static func instance() -> PageViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! PageViewController
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self

        //インスタンス化
        let pageViewA = storyboard!.instantiateViewController(withIdentifier: "first") as! FirstViewController
        let pageViewB = storyboard!.instantiateViewController(withIdentifier: "second") as! secondViewController
        let pageViewC = storyboard!.instantiateViewController(withIdentifier: "third") as! thirdViewController
        let pageViewD = storyboard!.instantiateViewController(withIdentifier: "forth") as! forthViewController
        let pageViewE = storyboard!.instantiateViewController(withIdentifier: "fifth") as! fifthViewController
        let pageViewF = storyboard!.instantiateViewController(withIdentifier: "sixth") as! sixthViewController
        let pageViewG = storyboard!.instantiateViewController(withIdentifier: "seventh") as! seventhViewController
        let pageViewH = storyboard!.instantiateViewController(withIdentifier: "eighth") as! eighthViewController
        let pageViewI = storyboard!.instantiateViewController(withIdentifier: "nineth") as! ninethViewController
        let pageViewJ = storyboard!.instantiateViewController(withIdentifier: "tenth") as! tenthViewController
        let pageViewJ2 = storyboard!.instantiateViewController(withIdentifier: "tenth2") as! tenth2ViewController
         let pageViewK = storyboard!.instantiateViewController(withIdentifier: "eleventh") as! eleventhViewController
         let pageViewL = storyboard!.instantiateViewController(withIdentifier: "twelth") as! twelthViewController
         let pageViewM = storyboard!.instantiateViewController(withIdentifier: "thirteenth") as! thirteenthViewController
        let pageViewN = storyboard!.instantiateViewController(withIdentifier: "last") as! lastViewController
        pageViewControllers = [pageViewA, pageViewB, pageViewC, pageViewD, pageViewE, pageViewF,pageViewG, pageViewH, pageViewI, pageViewJ,pageViewJ2, pageViewK, pageViewL, pageViewM, pageViewN]

        //最初に表示するページの指定
        self.setViewControllers([pageViewControllers[0]], direction: .forward, animated: true, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PageViewController : UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //全ページ数を返すメソッド
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllers.count
    }
    //現在のページを返すメソッド
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentPage
    }

       func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = pageViewControllers.firstIndex(of: viewController)
        if index == 0 {
            return nil
        } else {
            return pageViewControllers[index!-1]
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = pageViewControllers.firstIndex(of: viewController)
        if index == pageViewControllers.count - 1 {
            return nil
        } else {
            return pageViewControllers[index!+1]
        }
    }
}
