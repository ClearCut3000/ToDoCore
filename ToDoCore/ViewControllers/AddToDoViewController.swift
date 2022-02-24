//
//  AddToDoViewController.swift
//  ToDoCore
//
//  Created by Николай Никитин on 21.02.2022.
//

import UIKit

class AddToDoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  //MARK: - Properties
  var toDoTableViewController: ToDoTableViewController? = nil
  var picker = UIImagePickerController()

  //MARK: - Outlets
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var prioritySegment: UISegmentedControl!
  @IBOutlet weak var imageView: UIImageView!

  //MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    picker.delegate = self
  }

  //MARK: - UIImagePickerController Methods
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[.originalImage] as? UIImage {
      imageView.image = image
    }
    picker.dismiss(animated: true, completion: nil)
  }

  // MARK: - Actions
  @IBAction func addTapped(_ sender: Any) {
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
      let newToDo = ToDoCD(context: context)
      newToDo.priority = Int32(prioritySegment.selectedSegmentIndex)
      if let name = nameTextField.text {
        newToDo.name = name
      }
      newToDo.image = imageView.image?.jpegData(compressionQuality: 1.0)
      (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    navigationController?.popViewController(animated: true)
  }

  @IBAction func cameraTapped(_ sender: Any) {
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
    picker.sourceType = .camera
    present(picker, animated:  true, completion: nil)
    } else {
      let alert = UIAlertController(title: "Unable to access the camera!", message: nil, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      present(alert, animated: true)
    }
  }

  @IBAction func mediaFolderTapped(_ sender: Any) {
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
      picker.sourceType = .photoLibrary
      present(picker, animated: true, completion: nil)
    } else {
      let alert = UIAlertController(title: "Unable to access the photo library!", message: nil, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      present(alert, animated: true)
    }
  }
}
