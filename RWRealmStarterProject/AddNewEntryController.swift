//
//  AddNewEntryController.swift
//  RWRealmStarterProject
//
//  Created by Bill Kastanakis on 8/6/14.
//  Copyright (c) 2014 Bill Kastanakis. All rights reserved.
//

import UIKit
import RealmSwift

class AddNewEntryController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  var selectedCategory: Category!
  var specimen: Specimen!

  @IBOutlet weak var categoryTextField: UITextField!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var descriptionTextField: UITextView!
  
  var selectedAnnotation: SpecimenAnnotation!
    
   override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if validateFields() {
            if specimen == nil {
                addNewSpecimen()
            } else {
                updateSpecimen()
            }
            return true
        } else {
            return false
        }
    }

  //MARK: - Validation
  
  func validateFields() -> Bool {
    
    if (nameTextField.text.isEmpty || descriptionTextField.text.isEmpty || selectedCategory == nil) {
      let alertController = UIAlertController(title: "Validation Error", message: "All fields must be filled", preferredStyle: .Alert)
      let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Destructive, handler: {(alert : UIAlertAction!) in
        alertController.dismissViewControllerAnimated(true, completion: nil)
      })
      alertController.addAction(alertAction)
      presentViewController(alertController, animated: true, completion: nil)
      
      return false
      
    } else {
      return true
    }
  }

  //MARK: - UITextFieldDelegate
  
  func textFieldDidBeginEditing(textField: UITextField) {
     performSegueWithIdentifier("Categories", sender: self)
  }
  
  //MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if (specimen == nil) {
        title = "Add New Specimen"
    } else {
        title = "Edit \(specimen.name)"
        fillTextFields()
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  @IBAction func unwindFromCategories(segue: UIStoryboardSegue) {
    let categoriesController = segue.sourceViewController as! CategoriesTableViewController
    
    selectedCategory = categoriesController.selectedCategory
    categoryTextField.text = selectedCategory.name

  }
  
  //MARK: - Actions
  
//  override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
//    
//  }
    
    func addNewSpecimen() {
        let realm = Realm()
        let newSpecimen = Specimen() //3
        //4
        newSpecimen.name = self.nameTextField.text
        newSpecimen.category = self.selectedCategory
        newSpecimen.specimenDescription =  self.descriptionTextField.text
        newSpecimen.latitude = self.selectedAnnotation.coordinate.latitude
        newSpecimen.longitude = self.selectedAnnotation.coordinate.longitude
        realm.write() {
                realm.add(newSpecimen) //9
        }
        specimen = newSpecimen
    }
    
    func fillTextFields() {
        nameTextField.text = specimen.name
        categoryTextField.text = specimen.category.name
        descriptionTextField.text = specimen.specimenDescription
        
        selectedCategory = specimen.category
    }
    
    func updateSpecimen() {
        let realm = Realm()
        realm.write() {
            self.specimen.name = self.nameTextField.text
            self.specimen.category = self.selectedCategory
            self.specimen.specimenDescription = self.descriptionTextField.text
        }
    }
  
}
