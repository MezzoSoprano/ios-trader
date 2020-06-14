//
//  LoadingViewController.swift
//  trader
//
//  Created by Svyatoslav Katola on 09.06.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    lazy var activityIndicator = UIActivityIndicatorView()
    
    func startLoading() {
        activityIndicator.style = .large
        activityIndicator.frame = self.view.frame
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func finishLoading() {
        activityIndicator.stopAnimating()
    }
}
