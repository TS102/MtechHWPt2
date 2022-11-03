//
//  FamilyInfoViewController.swift
//  FamilyProjectpt2
//
//  Created by Tyler Sun on 11/1/22.
//

import UIKit

class FamilyInfoViewController: UIViewController {

    var familyInfo: FamilyInfo?
    
  
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    init?(coder aDecoder: NSCoder, familyInfo: FamilyInfo?) {
        self.familyInfo = familyInfo
        super.init(coder: aDecoder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // this is not working says init is not implemented

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView() {
        guard let familyInfo = familyInfo else { return }
        nameLabel.text = familyInfo.name
        ageLabel.text = familyInfo.age
        descriptionLabel.text = familyInfo.description
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
