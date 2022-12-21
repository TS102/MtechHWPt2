//
//  ViewController.swift
//  Dogs&Politics
//
//  Created by Tyler Sun on 12/2/22.
//

import UIKit

class ViewController: UIViewController {

    var dogController = DogController()
    
    @IBOutlet weak var dogImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task {
            do {
               let dogItem = try await dogController.fetchItems()
                dogImage.image = try await dogController.fetchImage(from: dogItem.dogImage)
            } catch {
                print(error)
            }
        }
    }

    @IBAction func newDogButtonTapped(_ sender: Any) {
        Task {
               let dogItem = try await dogController.fetchItems()
                dogImage.image = try? await dogController.fetchImage(from: dogItem.dogImage)
        }
    }
}

