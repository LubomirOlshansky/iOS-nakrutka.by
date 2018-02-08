//
//  OrderViewController.swift
//  nakrutka.by
//
//  Created by Lubomir Olshansky on 06/02/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var choseServicePickerView: UIPickerView!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var orderResponce: UILabel!
    
    let orderService = OrderService()
    var selectedServis: Int = 1
    var apiKey = ""
    var quantity = 0
    var link = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        choseServicePickerView.delegate = self
        choseServicePickerView.dataSource = self
        let instance = ApiKeySingletone.shared
        self.apiKey = instance.apiKey
    }
    
    let orderInfo:[(number: Int, name: String)] = [(1, "Лайки быстрые - 3р"), (2, "Подписчики - 29p"), (3, "Лайки - 10p"), (4, "Лайки быстрые - 5p"), (7, "Лайки быстрые - 8p"), (9, "Просмотры временных историй (Story) - 80р"), (11, "Лайки с быстрым стартом и накруткой."), (13, "Подписчики быстрые - 25р"), (14, "Лайки - 14р"), (18, "Подписчики с нашей гарантией - 320р"), (21, "Подписчики (нестабильные) - 19р"), (31, "Лайки быстрые - 17p")]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return orderInfo.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return orderInfo[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedServis = orderInfo[row].number
        print(selectedServis)
    }
    
    
    @IBAction func addOrder(_ sender: Any) {
        let quantity = Int(quantityTextField.text!)!
        let link = linkTextField.text!
        orderService.makeOrder(apiKey: apiKey, selectedServis: selectedServis, quantity: quantity, link: link) { [weak self]
            responce in
            print(responce)
            self?.orderResponce.text = responce
        }
    }
    
    
}
