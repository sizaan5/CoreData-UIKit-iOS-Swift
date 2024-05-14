//
//  AddVehicleViewController.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 14/05/2024.
//

import UIKit

class AddVehicleViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var txtVehicleName: UITextField!
    @IBOutlet weak var txtType: UITextField!
    
    
    //MARK: - Properties
    var action: ((_ value: Vehicle?) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - IBActions
    @IBAction func doneAction(_ sender: UIButton) {
        let vehicle = Vehicle(_id: UUID(), _name: self.txtVehicleName.text!, _type: self.txtType.text!)
        
        self.action?(vehicle)
        
        self.dismiss(animated: true)
    }
    

}
