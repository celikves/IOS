//
//  ServerAccess.swift
//  Cat Breeds App
//
//  Created by vesile çelik on 18.04.2022.
//

import Foundation
/*
class ServerAccess{
    
    let baseUrl = "https://docs.thecatapi.com/api-reference/breeds/breeds-list"
    
    func get(url : String, model: [BreedModel] , completionHandler: @escaping (Result<BreedModel, RequestError>) -> Void) -> URLSessionDataTask{
        let url = URL(string: url)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        request.setValue("x-api-key", forHTTPHeaderField: "ec260b4b-a939-4e2f-bbb7-cf7c1638ea3e")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 30.0
        let session = URLSession(configuration: sessionConfig)
        
        let task = session.dataTask(with: request) { [self] data, response, error in
            
            if let httpError = error{
                if httpError.localizedDescription != "cancelled"{
                    if error?._code == -1001 {
                        completionHandler(.failure(.timeOut))
                    }else{
                        completionHandler(.failure(.badRequest))
                    }
                    //send report to centry
                    Singleton.shared.getCrashAnalyticsManager().reportWithDomain(domain: session.debugDescription, code: -1001, errorMessage: ["functionName": url, "errorMessage": httpError.localizedDescription])
                }else{
                    completionHandler(.failure(.cancellRequest))
                }
            }else{
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200 ... 299:
                        if let data = data{
                            if let jsonResult = try? JSONDecoder().decode(model, from: data){
                                completionHandler(.success(jsonResult))
                            }else{
                                completionHandler(.failure(.badJson))
                            }
                        }
                    case 400:
                        let error = Singleton.shared.getCrashAnalyticsManager().sendCrahsReport(URL(string: url)!, data, httpResponse)
                        if error == "Invalid session token"{
                            removeSession()
                        }else{
                            completionHandler(.failure(.badRequest))
                        }
                        
                    default:

                        completionHandler(.failure(.serverError("error")))
                    }
                }
            }
        }
    }
}


enum RequestError: Error {
    
    case badRequest
    case badJson
    case serverError(String)
    case timeOut
    case cancellRequest
    case invalidSession
}
*/
