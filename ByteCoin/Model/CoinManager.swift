//
//  CoinManager.swift
//  ByteCoin
//
//  Created by BK on 21/02/23.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, coinData: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "A8F5515F-5C8B-4BF3-92BD-0E2F5153D90B"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlSTring = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(urlString: urlSTring)
    }
    
    //API call
    func performRequest(urlString: String) {
        
        //1. create an url
        if let url = URL(string: urlString){
            
            //2. create a URLSession  (does networking)
            let session = URLSession(configuration: .default)
            
            //3. give the session task (put url like browser)
            
           // let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))  //Creates a task that retrieves the contents of the specified URL, then calls a handler upon completion.
            
            // converted above statement into closure
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let coin = self.parseJson(coinData: safeData) {
                        delegate?.didUpdateCoin(self, coinData: coin)
                        
                    }
                }
            }

            
            //4. start the task (start searching)
            task.resume()
            
        }
    }
    
    //5. parsing JSON data
    func parseJson(coinData: Data) -> CoinModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinModel.self, from: coinData)
            return decodedData
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil;
        }
    }
}
