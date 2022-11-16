//
//  ToDoDetailTableViewController.swift
//  ListProject
//
//  Created by Tyler Sun on 11/7/22.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {

    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var notesTexView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var toDo: ToDo?
    
    var isDatePickerHidden = true
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesIndexPath = IndexPath(row: 0, section: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
            let currentDueDate: Date
            if let toDo = toDo {
              navigationItem.title = "ToDoCell"
              titleTextField.text = toDo.title
              isCompleteButton.isSelected = toDo.isComplete
              currentDueDate = toDo.dueDate
                notesTexView.text = toDo.notes
            } else {
              currentDueDate = Date().addingTimeInterval(24*60*60)
            }
        datePicker.date = currentDueDate
            updateDueDateLabel(date: currentDueDate)
            updateSaveButtonState()

    }
        
    func updateSaveButtonState() {
        let shouldEnableSaveButton = titleTextField.text?.isEmpty == false
        saveButton.isEnabled = shouldEnableSaveButton
    }
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = date.formatted(.dateTime.month(.defaultDigits).day().year(.twoDigits).hour().minute())
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == dateLabelIndexPath {
            updateDueDateLabel(date: datePicker.date)
            isDatePickerHidden.toggle()
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath:
            return 216
        case notesIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath where isDatePickerHidden == true:
            return 0
        case notesIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else {return}
        
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = datePicker.date
        let notes = notesTexView.text
        if toDo != nil {
            toDo?.title = title
            toDo?.isComplete = isComplete
            toDo?.dueDate = dueDate
            toDo?.notes = notes
        } else {
            toDo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
        }
    }

    @IBAction func textEditingChanged(_ sender: Any) {
        updateSaveButtonState()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected.toggle()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: sender.date)
    }
    
    
}
