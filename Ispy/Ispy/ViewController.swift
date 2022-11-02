//
//  ViewController.swift
//  Ispy
//
//  Created by Tyler Sun on 10/17/22.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollViewOutLet: UIScrollView!
    @IBOutlet var ispyImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollViewOutLet.delegate = self
        
        
    }


    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return ispyImage
    }
    
    func updateZoomFor(size: CGSize) {
        let widthScale = size.width / ispyImage.bounds.width
        let heightScale = size.height / ispyImage.bounds.height
        let scale = min(widthScale, heightScale)
        scrollViewOutLet.minimumZoomScale = scale
        scrollViewOutLet.zoomScale = scale
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateZoomFor(size: view.bounds.size)
    }
}

