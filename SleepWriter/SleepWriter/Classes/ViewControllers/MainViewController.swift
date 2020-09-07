//
//  ViewController.swift
//  SleepWriter
//
//  Created by Artyom Artamonov on 05.09.2020.
//  Copyright © 2020 Artyom Artamonov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    let pageControl : UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    var pages : [UIViewController] = [WriterViewController(), DreamsViewController()]
    
    func configurePageController() -> () {
        
        //TODO : Comment
        
        addChild(pageController)
        pageController.didMove(toParent: self)
        
        view.addSubview(pageController.view)
        view.addSubview(pageControl)
        
        pageController.delegate = self
        pageController.dataSource = self
        
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = pages.count
        
        NSLayoutConstraint.activate([pageController.view.topAnchor.constraint(equalTo: view.topAnchor),
                                     pageController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
                                     pageController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     pageController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        NSLayoutConstraint.activate([pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                                         constant: 10),
                                     pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        
        let startingViewController = pages[0]
        
        pageController.setViewControllers([startingViewController], direction: .forward, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePageController()
        
    }

}

// UIPageViewControllerDelegate and UIPageViewControllerDataSource
extension MainViewController : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageViewController = pageViewController.viewControllers![0]
        pageControl.currentPage = pages.firstIndex(of: pageViewController)!
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard var index = pages.firstIndex(of: viewController) else { return nil }
        
        index -= 1
        
        guard index >= 0 else { return nil }
        
        return pages[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard var index = pages.firstIndex(of: viewController) else { return nil }
        
        index += 1
        
        guard index < pages.count else { return nil }
        
        return pages[index]
    }
    
    
}