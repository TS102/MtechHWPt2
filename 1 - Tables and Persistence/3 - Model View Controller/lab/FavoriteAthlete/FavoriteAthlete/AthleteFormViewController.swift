//
//  AthlteteFormViewController.swift
//  FavoriteAthlete
//
//  Created by Tyler Sun on 10/13/22.
//

import UIKit

class AthleteFormViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var leagueTextField: UITextField!
    @IBOutlet var teamTextField: UITextField!
    
    var athlete: Athlete?
    
    init?(coder: NSCoder, athlete: Athlete?) {
        self.athlete = athlete
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateView() {
        guard let athleteCheck = athlete else {return}
        nameTextField.text = athleteCheck.name
        ageTextField.text = String(athleteCheck.age)
        leagueTextField.text = athleteCheck.league
        teamTextField.text = athleteCheck.team
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        updateView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        guard let name = nameTextField.text,
              let ageString = ageTextField.text,
              let age = Int(ageString),
            let league = leagueTextField.text,
        let team = teamTextField.text else {return}
        print("Athlete")
        athlete = Athlete(name: name, age: age, league: league, team: team)
        print("Save")
        performSegue(withIdentifier: "unWind", sender: self)
        print("unwinding")
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
