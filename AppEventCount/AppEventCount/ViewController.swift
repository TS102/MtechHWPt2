//
//  ViewController.swift
//  AppEventCount
//
//  Created by Tyler Sun on 10/12/22.
//

import UIKit

class ViewController: UIViewController {

    var appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    @IBOutlet var didFinishLaunchWithOptions: UILabel!
    @IBOutlet var configForConnecting: UILabel!
    @IBOutlet var willConnectToOptions: UILabel!
    @IBOutlet var sceneDidBecomeActive: UILabel!
    @IBOutlet var scenWillResignActive: UILabel!
    @IBOutlet var sceneWillEnterForground: UILabel!
    @IBOutlet var sceneDidEnterBackGround: UILabel!
    
    var didFinishLaunchWithOptionsCount = 0
    var configForConnectingCount = 0
    var willConnectToOptionsCount = 0
    var sceneDidBecomeActiveCount = 0
    var scenWillResignActiveCount = 0
    var sceneWillEnterForgroundCount = 0
    var sceneDidEnterBackGroundCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        // Do any additional setup after loading the view.
    }
    
    func updateView() {
        didFinishLaunchWithOptions.text = "The didfinishLaunchWithOptions has launched \(didFinishLaunchWithOptionsCount) time(s)"
        configForConnecting.text = "The configForConnection has launched \(configForConnectingCount) time(s)"
        willConnectToOptions.text = "The WillConnectTooptions has launched \(willConnectToOptionsCount) time(s)"
        sceneDidBecomeActive.text = "The didBecomeActive has launched \(sceneDidBecomeActiveCount) time(s)"
        scenWillResignActive.text = "The willResignActive has launched \(scenWillResignActiveCount) time(s)"
        sceneWillEnterForground.text = "The willEnterForground has launched \(sceneWillEnterForgroundCount) time(s)"
        sceneDidEnterBackGround.text = "The DidEnterBackground has launched \(sceneDidEnterBackGroundCount) time(s)"
    }


}

