//
//  ToDoDetailsViewController.swift
//  ToDoCore
//
//  Created by Николай Никитин on 22.02.2022.
//

import UIKit

class ToDoDetailsViewController: UIViewController {

  //MARK: - Properties
  var toDoCD: ToDoCD? = nil

  //MARK: - Outlets
  @IBOutlet weak var toDoLabel: UILabel!
  @IBOutlet weak var detailImageView: UIImageView!

  //MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    if let toDo = toDoCD {
      if toDo.priority == 1 {
        if let name = toDo.name {
          toDoLabel.text = "❗️" + name
        }
      } else if toDo.priority == 2 {
        if let name = toDo.name {
          toDoLabel.text = "‼️"  + name
        }
      } else {
        if let name = toDo.name {
          toDoLabel.text = name
        }
      }
      if let data = toDo.image {
        detailImageView.image = UIImage(data: data)
      }
    }
  }

  //MARK: - Actions
  @IBAction func doneTapped(_ sender: Any) {
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
      if let toDo = toDoCD {
        context.delete(toDo)
      }
      (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    navigationController?.popViewController(animated: true)
  }
}
