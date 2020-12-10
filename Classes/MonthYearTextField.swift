//
//  MonthYearTextField.swift
//  MonthYearTextField
//
//  Created by Rahul Chopra on 10/12/20.
//

import Foundation
import UIKit

protocol ToolbarPickerViewDelegate: class {
    func didTapDone()
    func didTapCancel()
}

class MonthYearTextField: UITextField {
   enum PickerType: String {
      case month
      case year
   }
   
   @IBInspectable var pickerType: String = "month" {
      didSet {
         if let type = PickerType(rawValue: pickerType) {
            self.type = type
            if type == .month {
               let monthIndexes = Calendar.current.monthSymbols.enumerated().map({($0.offset + 1).string()})
               self.componentsArray = monthIndexes
            } else {
               var yearsArray = [String]()
               let currentYear = Calendar.current.component(.year, from: Date())
               for each in 0...10 {
                  yearsArray.append((currentYear + each).string())
               }
               self.componentsArray = yearsArray
            }
         } else {
            self.type = .month
            let monthIndexes = Calendar.current.monthSymbols.enumerated().map({($0.offset + 1).string()})
            self.componentsArray = monthIndexes
         }
      }
   }
   
   @IBInspectable var monthFormat: String = "MMM" {
      didSet {
         if monthFormat == "12" {
            let monthIndexes = Calendar.current.monthSymbols.enumerated().map({($0.offset + 1).string()})
            self.componentsArray = monthIndexes
         } else if monthFormat == "MMM" {
            self.componentsArray = Calendar.current.shortMonthSymbols
         } else if monthFormat == "M" {
            self.componentsArray = Calendar.current.veryShortMonthSymbols
         } else if monthFormat == "MMMM" {
             let monthIndexes = Calendar.current.monthSymbols
             self.componentsArray = monthIndexes
         } else {
            let monthIndexes = Calendar.current.monthSymbols
            self.componentsArray = monthIndexes
         }
      }
   }
   
   private var contentView: UIView = {
      let view = UIView()
      view.backgroundColor = UIColor.rgb(red: 222, green: 225, blue: 232)
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
   }()
   
   var pickerView: UIPickerView = {
      let pickerView = UIPickerView()
      pickerView.translatesAutoresizingMaskIntoConstraints = false
      return pickerView
   }()
   
    public weak var toolbarDelegate: ToolbarPickerViewDelegate?
   private var parentVC: UIViewController?
   private let toolBar = UIToolbar()
   private var bottomConstraint: NSLayoutConstraint!
   private var isPickerOpened: Bool = false
   private var type: PickerType = .month
   var componentsArray = [String]()
   
   
   // MARK:- INITIALIZERS
   override init(frame: CGRect) {
      super.init(frame: frame)
      self.commonInit()
   }
   
   required init?(coder: NSCoder) {
      super.init(coder: coder)
      self.commonInit()
   }
   
   private func commonInit() {
      let tap = UITapGestureRecognizer(target: self, action: #selector(openPickerView))
      self.addGestureRecognizer(tap)
      
      self.perform(#selector(setupPickerView), with: nil, afterDelay: 0.0)
   }
   
   @objc private func setupPickerView() {
    if let parentVC = self.parentViewController {
         parentVC.view.addSubview(contentView)
         contentView.addSubview(pickerView)
         self.setupToolBar()
         self.activateConstraints(parentVC: parentVC)
         
         pickerView.dataSource = self
         pickerView.delegate = self
      }
   }
   
   private func activateConstraints(parentVC: UIViewController) {
      NSLayoutConstraint.activate([
         contentView.leadingAnchor.constraint(equalTo: parentVC.view.leadingAnchor),
         contentView.trailingAnchor.constraint(equalTo: parentVC.view.trailingAnchor),

         pickerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         pickerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         pickerView.heightAnchor.constraint(equalToConstant: 200),
         pickerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
         
         toolBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         toolBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         toolBar.topAnchor.constraint(equalTo: contentView.topAnchor),
         toolBar.heightAnchor.constraint(equalToConstant: 50),
         
         pickerView.topAnchor.constraint(equalTo: toolBar.bottomAnchor)
      ])
      
      bottomConstraint = contentView.bottomAnchor.constraint(equalTo: parentVC.view.bottomAnchor, constant: 250)
      bottomConstraint.isActive = true
   }
   
   private func setupToolBar() {
      toolBar.barStyle = UIBarStyle.default
      toolBar.isTranslucent = true
      toolBar.tintColor = .black
      toolBar.sizeToFit()
      
      toolBar.isTranslucent = false
      toolBar.barStyle = .default

      let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
      let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
      
      var chooseTitle = ""
      if type == .month {
         chooseTitle = "Choose Month"
      } else {
         chooseTitle = "Choose Year"
      }
      
      let chooseLabel = UIBarButtonItem(title: chooseTitle, style: .plain, target: nil, action: nil)
      let spaceButton2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
      let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelTapped))

      toolBar.setItems([cancelButton, spaceButton, chooseLabel, spaceButton2, doneButton], animated: false)
      toolBar.isUserInteractionEnabled = true
      
      contentView.addSubview(toolBar)
      toolBar.translatesAutoresizingMaskIntoConstraints = false
   }
   
   @objc func doneTapped() {
      self.text = componentsArray[pickerView.selectedRow(inComponent: 0)]
      self.closePickerView()
   }
   
   @objc func cancelTapped() {
      self.closePickerView()
   }
   
   private func closePickerView() {
      isPickerOpened = !isPickerOpened
      self.bottomConstraint.constant = self.isPickerOpened == true ? 0 : 250
      self.contentView.alpha = self.isPickerOpened == true ? 1.0 : 0.0
      
      UIView.animate(withDuration: 2.0, delay: 0, options: .curveEaseInOut, animations: {
         self.layoutIfNeeded()
         self.contentView.layoutIfNeeded()
         self.superview!.layoutIfNeeded()
         self.parentVC?.view.layoutIfNeeded()
      }, completion: nil)
   }
   
   @objc func openPickerView() {
      if !isPickerOpened {
         self.closePickerView()
      }
   }
}


// MARK:- PICKER VIEW DATA SOURCE & DELEGATE METHODS
extension MonthYearTextField: UIPickerViewDataSource, UIPickerViewDelegate {
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
   }

   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return componentsArray.count
   }
   
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return componentsArray[row]
   }
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      print(componentsArray[row])
   }
}
