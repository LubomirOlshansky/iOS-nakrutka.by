//
//  StatusService.swift
//  nakrutka.by
//
//  Created by Lubomir Olshansky on 08/02/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import Foundation
import Alamofire

struct StatusResponce: Decodable {
    let quantity: String
    let link: String
    let charge: String
    let service: String
    let remains: Int
    let status: String
    let start_count: Int
}

class StatusService: UIViewController {
    
    typealias loadStatusDataComplition = (StatusResponce) -> Void
    
    let baseUrl = "https://nakrutka.by"
    
    func makeOrder(apiKey: String, orderID: Int, completion: @escaping loadStatusDataComplition) {
        
        let path = "/api"
        let parameters: Parameters = [
            "key": apiKey,
            "action": "status",
            "order": orderID,
            ]
        let url = baseUrl + path
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON(queue: .global(qos: .userInteractive))
        { responce in
            guard let data = responce.data else { return }
            do {
                let statusDecocded = try JSONDecoder().decode(StatusResponce.self, from: data)
                print(statusDecocded)
                DispatchQueue.main.async {
                    completion(statusDecocded)
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
