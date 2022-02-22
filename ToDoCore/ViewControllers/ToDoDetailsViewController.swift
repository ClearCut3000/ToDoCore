//
//  ToDoDetailsViewController.swift
//  ToDoCore
//
//  Created by Николай Никитин on 22.02.2022.
//

import UIKit

class ToDoDetailsViewController: UIViewController {

  //MARK: - Properties
  var toDo = ToDo()

  //MARK: - Outlets
  @IBOutlet weak var toDoLabel: UILabel!
  @IBOutlet weak var doneTapped: UIButton!

  //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
      if toDo.priority == 1 {
        toDoLabel.text = "❗️" + toDo.name
      } else if toDo.priority == 2 {
        toDoLabel.text = "‼️" + toDo.name
      } else {
        toDoLabel.text = toDo.name
      }
    }
}
