//
//  AddEditViewController.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 13/05/2024.
//

import UIKit
import PhotosUI

class AddEditViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassportNumber: UITextField!
    @IBOutlet weak var txtPassportPlaceOfIssue: UITextField!
    @IBOutlet weak var btnSaveUpdate: UIButton! {
        didSet {
            if self.isFromEdit {
                self.btnSaveUpdate.setTitle("Update", for: .normal)
            } else {
                self.btnSaveUpdate.setTitle("Save", for: .normal)
            }
        }
    }
    @IBOutlet weak var btnAddVehicle: UIButton!
    
    //MARK: - Properties
    var isFromEdit: Bool = false
    private var manager = EmployeeManager()
    private var selectedEmployee: Employee?
    var vehicles: [Vehicle] = []
    var empId: UUID?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if self.isFromEdit {
            self.selectedEmployee = self.manager.getEmployee(byIdentifier: self.empId!)
            self.imgProfilePic.image = UIImage(data: (self.selectedEmployee?.profilePicture)!)
            self.txtFullName.text = self.selectedEmployee?.name
            self.txtEmail.text = self.selectedEmployee?.email
            self.txtPassportNumber.text = self.selectedEmployee?.passport?.passportId
            self.txtPassportPlaceOfIssue.text = self.selectedEmployee?.passport?.placeOfIssue
            var title = ""
            for vehicle in self.vehicles {
                if title == "" {
                    title = vehicle.name
                } else {
                    title = "\(title), \(vehicle.name)"
                }
            }
        }
    }
    
    func configureImagePicker(){
        var configuration = PHPickerConfiguration()
        //0 unlimited 1 default
        configuration.selectionLimit = 0
        configuration.filter = .images
        let pickerViewController = PHPickerViewController(configuration: configuration)
        pickerViewController.delegate = self
        present(pickerViewController, animated: true)
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
    @IBAction func saveAction(_ sender: Any) {
        if self.isFromEdit {
            let passport = Passport(_id: (self.selectedEmployee?.passport?.id)!, _passportId: self.txtPassportNumber.text, _placeOfIssue: self.txtPassportPlaceOfIssue.text)
            
            let employee = Employee(_id: (self.selectedEmployee?.id)!, _name: self.txtFullName.text!, _email: self.txtEmail.text!, _profilePicture: (self.imgProfilePic.image?.pngData())!, _passport: passport, _vehicles: self.vehicles)
            
            if !self.manager.updateEmployee(record: employee) {
                return
            }
        } else {
            let passport = Passport(_id: UUID(), _passportId: self.txtPassportNumber.text, _placeOfIssue: self.txtPassportPlaceOfIssue.text)
            
            let employee = Employee(_id: UUID(), _name: self.txtFullName.text!, _email: self.txtEmail.text!, _profilePicture: (self.imgProfilePic.image?.pngData())!, _passport: passport, _vehicles: self.vehicles)
            
            self.manager.create(record: employee)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addVehicleAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddVehicleViewController") as? AddVehicleViewController {
            vc.action = { vehicle in
                if let vehicle {
                    self.vehicles.append(vehicle)
                    var title = ""
                    for vehicle in self.vehicles {
                        if title == "" {
                            title = vehicle.name
                        } else {
                            title = "\(title), \(vehicle.name)"
                        }
                    }
                    self.btnAddVehicle.setTitle(title, for: .normal)
                }
            }
            self.navigationController?.present(vc, animated: true)
        }
    }
    
    
    @IBAction func imgAction(_ sender: UIButton) {
        self.configureImagePicker()
    }
    
    
}

//MARK: - PHPickerViewControllerDelegate
extension AddEditViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        if let itemprovider = results.first?.itemProvider{
          
            if itemprovider.canLoadObject(ofClass: UIImage.self){
                itemprovider.loadObject(ofClass: UIImage.self) { image , error  in
                    if let error{
                        print(error)
                    }
                    if let selectedImage = image as? UIImage{
                        DispatchQueue.main.async {
                            self.imgProfilePic.image = selectedImage
                        }
                    }
                }
            }
            
        }
    }
}
