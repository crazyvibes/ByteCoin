//
//  CoinModel.swift
//  ByteCoin
//
//  Created by BK on 21/02/23.
//

import Foundation

struct CoinModel:Codable {   //Codable --> can be used for both Encodable and Decodable
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
        
}

//added an extension function to Double to get a given speciffic round numbers
extension Double {
    func round(to places: Int) -> Double {
        let precisionNumber = pow(10, Double(places))
        var n = self //current value of double
        n = n * precisionNumber
        n.round()
        n = n / precisionNumber
        return n
    }
}
