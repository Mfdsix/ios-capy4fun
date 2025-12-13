//
//  CapybaraMapper.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

final class CapybaraMapper {
    
    static func mapResponsesToDomains(
        input responses: [CapybaraResponse]
    ) -> [CapybaraModel] {
        return responses.map { result in
            return CapybaraModel(
                id: String(result.id),
                title: result.id != 0 ? "Capy #\(String(describing: result.id))" : "-",
                image: result.image ?? "-",
                description: result.description ?? "-",
                isFavorite: false
            )
        }
    }
    
    static func mapEntitiesToDomains(
        input entities: [CapybaraEntity]
    ) -> [CapybaraModel] {
        return entities.map { result in
            return CapybaraModel(
                id: result.id,
                title: result.title,
                image: result.image,
                description: result.desc,
                isFavorite: true
            )
        }
    }
    
    static func convertModelToEntity(
        input model: CapybaraModel
    ) -> CapybaraEntity {
        let entity = CapybaraEntity()
        entity.id = model.id
        entity.title = model.title
        entity.image = model.image
        entity.desc = model.description
        
        return entity
    }
    
}
