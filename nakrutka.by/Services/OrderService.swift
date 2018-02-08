//
//  OrderSerivice.swift
//  nakrutka.by
//
//  Created by Lubomir Olshansky on 07/02/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct ErrorResponce: Decodable {
    let error: String
}
struct OrderResponce: Decodable {
    let order: String
}

class OrderService: UIViewController {
    
    typealias loadOrderDataComplition = (String) -> Void
    
    let baseUrl = "https://nakrutka.by"

    func makeOrder(apiKey: String, selectedServis: Int, quantity: Int, link: String, completion: @escaping loadOrderDataComplition) {
        
        let path = "/api"
        let parameters: Parameters = [
            "key": apiKey,
            "action": "create",
            "service": selectedServis,
            "quantity": quantity,
            "link": link,
        ]
        let url = baseUrl + path
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON(queue: .global(qos: .userInteractive))
            { responce in
            guard let data = responce.data else { return }
              do {
            let orderDecoded = try JSONDecoder().decode(OrderResponce.self, from: data)
            print(orderDecoded.order)
            DispatchQueue.main.async {
                completion(orderDecoded.order)
                return
            }
              } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                }
                
                
//                do {
//                let errorDecoded = try JSONDecoder().decode(ErrorResponce.self, from: data)
//                print(errorDecoded.error)
//                    DispatchQueue.main.async {
//                        completion(errorDecoded.error)
//                    }
//                } catch let jsonErr {
//                    print("Error serializing json:", jsonErr)
//                }
                
                
                
            }
        }
    }     
