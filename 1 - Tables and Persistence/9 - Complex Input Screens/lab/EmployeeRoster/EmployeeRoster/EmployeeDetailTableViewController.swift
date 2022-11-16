
import UIKit

protocol EmployeeDetailTableViewControllerDelegate: AnyObject {
    func employeeDetailTableViewController(_ controller: EmployeeDetailTableViewController, didSave employee: Employee)
}

class EmployeeDetailTableViewController: UITableViewController, UITextFieldDelegate, EmployeeTypeTableViewControllerDelegate {
    func employeeTypeTableViewController(controller: EmployeeTypeTableViewController, didselect employeeType: EmployeeType) {
        self.employeeType = employeeType
        employeeTypeLabel.textColor = .black
        employeeTypeLabel.text = "\(employeeType)"
        updateSaveButtonState()
    }


    // MARK: outlet and properties
    var employeeType: EmployeeType?
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var employeeTypeLabel: UILabel!
    @IBOutlet var saveBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var dobDatePicker: UIDatePicker!
    
    let dobDatePickerIndenxPath = IndexPath(row: 2, section: 0)
    let dobLabelIndexPath = IndexPath(row: 1, section: 0)
    
    weak var delegate: EmployeeDetailTableViewControllerDelegate?
    var employee: Employee?
    
    var isEditingBirthday: Bool = false {
        didSet {
            dobDatePicker.isHidden = !isEditingBirthday
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        updateSaveButtonState()
    }
    
    func updateView() {
        if let employee = employee {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            
            dobLabel.text = employee.dateOfBirth.formatted(date: .abbreviated, time: .omitted)
            dobLabel.textColor = .label
            employeeTypeLabel.text = employee.employeeType.description
            employeeTypeLabel.textColor = .label
        } else {
            navigationItem.title = "New Employee"
        }
    }
    
    private func updateSaveButtonState() {
        let shouldEnableSaveButton = nameTextField.text?.isEmpty == false
        saveBarButtonItem.isEnabled = shouldEnableSaveButton
        if employeeType != nil {
            saveBarButtonItem.isEnabled = true
        } else {
            saveBarButtonItem.isEnabled = false
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case dobDatePickerIndenxPath where isEditingBirthday == false: return 0
        default: return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case dobDatePickerIndenxPath: return 216
        default: return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == dobLabelIndexPath && isEditingBirthday == false {
            isEditingBirthday.toggle()
        } else if indexPath == dobLabelIndexPath && isEditingBirthday == true  {
            isEditingBirthday.toggle()
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    //MARK: IBActions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text else {
            return
        }
        guard let employeeType = employeeType else { return }
        
        let employee = Employee(name: name, dateOfBirth: dobDatePicker.date, employeeType: employeeType)
        delegate?.employeeDetailTableViewController(self, didSave: employee)
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        employee = nil
    }

    @IBAction func nameTextFieldDidChange(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    
    @IBAction func datePickerChanged(_ sender: Any) {
        dobLabel.text = dobDatePicker.date.formatted(date: .abbreviated, time: .omitted)
    }
    
    @IBSegueAction func showEmployeeTypes(_ coder: NSCoder) -> EmployeeTypeTableViewController? {
        let selectEmployeeTypeController = EmployeeTypeTableViewController(coder: coder)
        selectEmployeeTypeController?.delegate = self
        selectEmployeeTypeController?.employeeType = employeeType
        return selectEmployeeTypeController
    }
    
    
    
}
