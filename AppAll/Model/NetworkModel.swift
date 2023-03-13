import UIKit

struct CatFact: Decodable {
    let fact: String
    let length: Int
}

struct Joke: Decodable {
    let type: String
    let setup: String
    let punchline: String
    let id: Int
}

struct DogImage: Decodable {
    let message: String
    let status: String
}

struct Nasa: Decodable {
    let date: String
    let hdurl: String
    let title: String
    let url: String
    let explanation: String
    //let copyright: String
}
