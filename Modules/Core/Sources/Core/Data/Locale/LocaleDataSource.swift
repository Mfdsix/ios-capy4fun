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

public final class LocaleDataSource {

    private let realm: Realm

    public init(realm: Realm) {
        self.realm = realm
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    
    func getFavoriteCapybaras() -> Observable<[CapybaraEntity]> {
        return Observable<[CapybaraEntity]>.create { observer in
            let datas = self.realm.objects(CapybaraEntity.self)
                .sorted(byKeyPath: "title", ascending: true)

            observer.onNext(datas.toArray(ofType: CapybaraEntity.self))
            observer.onCompleted()

            return Disposables.create()
        }
    }
    
    func findCapybara(id: String) -> Observable<Bool> {
        Observable.create { observer in
            let exists = self.realm.objects(CapybaraEntity.self)
                .filter("id == %@", id)
                .isEmpty == false

            observer.onNext(exists)
            observer.onCompleted()

            return Disposables.create()
        }
    }
    
    func addCapybaraToFavorite(from capybara: CapybaraEntity) -> Observable<Bool> {
        Observable.create { observer in
            do {
                try self.realm.write {
                    self.realm.add(capybara, update: .all)
                }
                observer.onNext(true)
                observer.onCompleted()
            } catch {
                observer.onError(DatabaseError.requestFailed)
            }

            return Disposables.create()
        }
    }
    
    func removeCapybaraFromFavorite(from id: String) -> Observable<Bool> {
        Observable.create { observer in
            guard let objectToDelete = self.realm.object(
                ofType: CapybaraEntity.self,
                forPrimaryKey: id
            ) else {
                observer.onNext(false)
                observer.onCompleted()
                return Disposables.create()
            }

            do {
                try self.realm.write {
                    self.realm.delete(objectToDelete)
                }
                observer.onNext(true)
                observer.onCompleted()
            } catch {
                observer.onError(DatabaseError.requestFailed)
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
