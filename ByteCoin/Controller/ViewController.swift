//
//  ViewController.swift
//  ByteCoin
//
//  Created by BK on 20/02/23.
//

import UIKit

class ViewController: UIViewController {

    //Interface builders outlets
    @IBOutlet weak var bitCoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    //CoinManagerObject
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Initialized all delegates
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }

}

//MARK: - UIPickerDataSOurce

extension ViewController: UIPickerViewDataSource {
    
    // determine how many columns we want in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 //no. of columns
    }
    
    // determine how many row we want in picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
}

//MARK: - UIPickerViewDelegate


extension ViewController: UIPickerViewDelegate {
    
    // this method expect a string output as a title for the given row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    // this method print the selected row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
    }
}

//MARK: - CoinManagerDeleget

extension ViewController: CoinManagerDelegate {
    
    func didUpdateCoin(_ coinManager: CoinManager, coinData: CoinModel) {
        DispatchQueue.main.async {
            self.currencyLabel.text = coinData.asset_id_quote
            self.bitCoinLabel.text = String((coinData.rate).round(to: 2))
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
