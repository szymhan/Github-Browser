//
//  DataLoader.swift
//  Github-Browser
//
//  Created by Hanzel, Szymon on 17/07/2019.
//  Copyright © 2019 Hanzel, Szymon. All rights reserved.
//

import Promis

enum FetchingDataError: Error {
    case malformedData
}


class DataLoader {

    
    func handleDataLoading(url: URL, completion: @escaping (RepositoriesViewModel?, Error?) -> ()) {

        let request = URLRequest(url: url)
        
        getData(request: request).thenWithResult { data in
            // continue by parsing the retrieved data
            self.parse(data: data)
            }.thenWithResult { parsedData in
                // continue by mapping the parsed data
                self.initiateviewModel(data: parsedData)
            }.thenWithResult{ data -> Future<RepositoriesViewModel> in
                self.downloadAvatars(data: data)
            }.onError { error in
                // executed only in case an error occurred in the chain
                print("error: " + String(describing: error))
            }.finally(queue: .main) { future in
                // always executed, no matter the state of the previous future or how the chain did perform
                switch future.state {
                case .result(let value):
                    completion(value,nil)
                    //self.viewModel = value
                case .error(let err):
                    completion (nil, err)
                    print(String(describing: err))
                case .cancelled, .unresolved:
                    completion (nil, nil)
                    print("this really cannot be if any chaining block is executed")
                }
        }
    }
    
    fileprivate func getData(request: URLRequest) -> Future<Data> {
        print(#function)
        print("request: " + String(describing: request))
        let promise = Promise<Data>()
        // async code retrieving the data here
        //let data = "[{\"key\":\"value\"}]".data(using: .utf8)!
        URLSession.shared.dataTask(with: request.url!) { (data,response,error) in
            switch (data,error){
            case (let data?, _):
                promise.setResult(data)
            case(nil, let error?):
                promise.setError(error)
            case (.none, _):
                promise.setError(FetchingDataError.malformedData)
            }
            }.resume()
        return promise.future
    }
    
    
    fileprivate func parse(data: Data) -> Future<RawServerResponse> {
        print(#function)
        print("data: " + String(describing: data))
        let promise = Promise<RawServerResponse>()
        // parsing code here
        do {
            let parsedData = try newJSONDecoder().decode(RawServerResponse.self, from: data)
            promise.setResult(parsedData)
        } catch {
            promise.setError(error)
        }
        // could simply return promise.future, but specific error handling/logging
        // should be done here as part of the responsibilities of the function
        return promise.future
            }
    
    fileprivate func initiateviewModel(data: RawServerResponse) -> Future<RepositoriesViewModel> {
        print(#function)
        let promise = Promise<RepositoriesViewModel>()
        
        do {
            let viewModel = RepositoriesViewModel(response: data)
            if let viewModel = viewModel {
                promise.setResult(viewModel)
            } else {
                throw FetchingDataError.malformedData
            }
        } catch {
            promise.setError(error)
        }
        return promise.future
//        return promise.future.onError {
//            error in
//            // handle/log error
//            DispatchQueue.main.async {
//                self.showAlert(title: "Eror while loading data from server", message: "Internal error occured", actionLabel: "Close")
//            }
        }
    
    fileprivate func downloadAvatars(data:RepositoriesViewModel) -> Future<RepositoriesViewModel> {
        print(#function)
        let promise = Promise<RepositoriesViewModel>()
        data.downloadAvatars()
        promise.setResult(data)
        return promise.future
    }
    
    func getReadme(repoName: String, ownerName: String) {
        let source = "https://raw.githubusercontent.com/\(ownerName)/\(repoName)/master/README.md"
        guard let url = URL(string: source) else {return}
        let data = try? Data(contentsOf: url)//make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        if let textData = data, let readmeString = String(data: textData, encoding: .utf8) {
            print (readmeString)
            
        }
    }
    
}

