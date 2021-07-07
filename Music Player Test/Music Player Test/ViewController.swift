//
//  ViewController.swift
//  MyMusicPlayer
//
//  Created by yagom
//  Copyright © 2017년 yagom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @UIOutlet var button: UIButton?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.addViewsWithCode()
        self.initializePlayer()
    }

}

