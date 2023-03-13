import UIKit

protocol CellModels {
    
}

struct CatFactModel: CellModels {
    let fact: String
}

struct JokeModel: CellModels {
    let setup: String
    let punchline: String
}

struct DogModel: CellModels {
    let image: UIImage
}

struct NasaModel: CellModels {
    let date: String
    let image: UIImage
    let title: String
    let url: String
    let explanation: String
    let author: String
}
