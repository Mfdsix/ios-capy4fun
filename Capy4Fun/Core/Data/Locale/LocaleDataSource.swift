//
//  LocaleDataSource.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocaleDataSourceProtocol: AnyObject {
    
    func getFavoriteCapybaras() -> Observable<[CapybaraEntity]>
    func findCapybara(id: String) -> Observable<Bool>
    func addCapybaraToFavorite(from capybara: CapybaraEntity) -> Observable<Bool>
    func removeCapybaraFromFavorite(from id: String) -> Observable<Bool>
    
}

final class LocaleDataSource: NSObject {
    
    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
    }
    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }
    
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    
    func getFavoriteCapybaras() -> Observable<[CapybaraEntity]> {
        return Observable<[CapybaraEntity]>.create { observer in
            if let realm = self.realm {
                let datas: Results<CapybaraEntity> = {
                    realm.objects(CapybaraEntity.self)
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                
                observer.onNext(datas.toArray(ofType: CapybaraEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            
            return Disposables.create()
        }
    }
    
    func findCapybara(id: String) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                let exists = realm.objects(CapybaraEntity.self)
                    .filter("id == %@", id)
                    .isEmpty == false
                
                observer.onNext(exists)
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            
            return Disposables.create()
        }
    }
    
    func addCapybaraToFavorite(from capybara: CapybaraEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(capybara, update: .all)
                        
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            
            return Disposables.create()
        }
    }
    
    func removeCapybaraFromFavorite(from id: String) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                if let objectToDelete = realm.object(ofType: CapybaraEntity.self, forPrimaryKey: id) {
                    do {
                        try realm.write {
                            realm.delete(objectToDelete)
                            observer.onNext(true)
                            observer.onCompleted()
                        }
                    } catch {
                        observer.onError(DatabaseError.requestFailed)
                    }
                } else {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            
            return Disposables.create()
        }
    }
    
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0..<count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}
