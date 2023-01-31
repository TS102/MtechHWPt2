//
//  DetailViewController.swift
//  Life-FormSearch
//
//  Created by Tyler Sun on 1/20/23.
//

import UIKit

class DetailViewController: UIViewController {

    var taxonConcepts = TaxonConcept()
    
    var id: Int

    init?(id: Int, coder: NSCoder) {
        self.id = id
        super.init(coder: coder)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBOutlet weak var lifeFormImage: UIImageView!
    
    
    @IBOutlet weak var scientificName: UILabel!
    @IBOutlet weak var kingdomLabel: UILabel!
    @IBOutlet weak var phylumLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var familyLabel: UILabel!
    @IBOutlet weak var genusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let infoRequest = DetailInfoRequest(id: id)

        Task {
            do {
                let info = try await sendRequest(infoRequest)
                let name = info.taxonConcept.scientificName ?? ""
                let imagelink = info.taxonConcept.dataObjects?.first?.mediaURL ?? ""
                await updateUI(with: name, imageLink: imagelink)
                print("imagelink is \(info)")
            }
            catch {
                print(error)
            }
        }
        print("Received \(id)")
    }
    
    
    func fetchImage(from url: URL) async throws -> UIImage {
           let (data, response) = try await URLSession.shared.data(from: url)
           
           guard let httpsResponse = response as? HTTPURLResponse, httpsResponse.statusCode == 200 else {
               throw PhotoInfoError.imageDataError
           }
           
           guard let image = UIImage(data: data) else {
               throw PhotoInfoError.imageDataError
           }
           
           return image
       }

    func updateUI(with name: String, imageLink: String) async {
        scientificName.text = name
        if imageLink != "" {
            Task {
                do {
                    print("this is url \(URL(string: imageLink)!)")
                    lifeFormImage.image = try await fetchImage(from: URL(string: imageLink)!)
                    print("image should change")
                } catch {
                    print(error)
                }
            }
        }
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
