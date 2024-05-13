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
    @IBOutlet weak var btnSaveUpdate: UIButton! {
        didSet {
            if self.isFromEdit {
                self.btnSaveUpdate.setTitle("Update", for: .normal)
            } else {
                self.btnSaveUpdate.setTitle("Save", for: .normal)
            }
        }
    }
    
    //MARK: - Properties
    var isFromEdit: Bool = false
    private var manager = EmployeeManager()
    private var selectedEmployee: Employee?
    var empId: UUID?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if self.isFromEdit {
            self.selectedEmployee = self.manager.fetchEmployee(byIdentifier: self.empId!)
            self.imgProfilePic.image = UIImage(data: (self.selectedEmployee?.profilePicture)!)
            self.txtFullName.text = self.selectedEmployee?.name
            self.txtEmail.text = self.selectedEmployee?.email
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
            if !self.manager.updateEmployee(employee: Employee(name: self.txtFullName.text, email: self.txtEmail.text, profilePicture: self.imgProfilePic.image?.pngData(), id: selectedEmployee!.id)) {
                return
            }
        } else {
            self.manager.createEmployee(employee: Employee(name: self.txtFullName.text, email: self.txtEmail.text, profilePicture: self.imgProfilePic.image?.pngData(), id: UUID()))
        }
        
        self.navigationController?.popViewController(animated: true)
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
