//
//  RemoteDataSource.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import Foundation
import Alamofire
import RxSwift

protocol RemoteDataSourceProtocol: AnyObject {
    
    func getCapybaras() -> Observable<[CapybaraResponse]>
    
}

public final class RemoteDataSource {

    public init() {}

}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getCapybaras() -> Observable<[CapybaraResponse]> {
        return Observable<[CapybaraResponse]>.create { observer in
            
            guard let url = URL(string: Endpoints.Gets.capybaras.url) else {
                observer.onError(URLError.invalidResponse)
                return Disposables.create()
            }
            
            let request = AF.request(url)
                .validate()
                .responseDecodable(of: CapybarasResponse.self) { response in
                    
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value.data)
                        observer.onCompleted()
                        
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
}
