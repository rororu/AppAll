import UIKit

final class CellApi {
    static let shared = CellApi()
    
    private struct Api {
        static let catFactEndPoint = "https://catfact.ninja/fact"
        static let jokeEndPoint = "https://official-joke-api.appspot.com/random_joke"
        static let dogImageEndPoint = "https://dog.ceo/api/breeds/image/random"
        static let nasaApiKey = "F6o1cUAtqcbnhMlnEAOLmh7bVAm7nzPaBpCrZIMe"
        static let nasaEndPoint = "https://api.nasa.gov/planetary/apod"
    }
    
    private init() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func getCatFact(complition: @escaping (CatFactModel) -> Void) {
        guard let url = URL(string: Api.catFactEndPoint) else {
            print("Not url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let currnetFact = try JSONDecoder().decode(CatFact.self, from: data)
                let fact = CatFactModel(fact: currnetFact.fact)
                complition(fact)
            } catch {
                print("\(error)")
                return
            }
        }.resume()
    }
    
    public func getJoke(complition: @escaping (JokeModel) -> Void) {
        guard let url = URL(string: Api.jokeEndPoint) else {
            print("Not url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error data")
                return }
            
            do {
                let currentJoke = try JSONDecoder().decode(Joke.self, from: data)
                let joke = JokeModel(setup: currentJoke.setup, punchline: currentJoke.punchline)
                complition(joke)
            } catch {
                print(error)
                return
            }
        }.resume()
    }
    
    public func getDogImage(complition: @escaping (DogModel) -> Void) {
        guard let url = URL(string: Api.dogImageEndPoint) else {
            print("Not url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else { return }
            
            do {
                let currentDogInfo = try JSONDecoder().decode(DogImage.self, from: data)
                let dogImageUrl = URL(string: currentDogInfo.message) ?? URL(string: "")
                
                CellApi.shared.getImageFormUrl(url: dogImageUrl!) { value in
                    let currentDogModel = DogModel(image: value)
                    complition(currentDogModel)
                }
                
            } catch {
                print(error)
                return
            }
        }.resume()
    }
    
    public func getImageFormUrl(url: URL, complition: @escaping (UIImage) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            let currnetImage = UIImage(data: data) ?? UIImage()
            complition(currnetImage)
        }.resume()
    }
    
    public func getNasa(complition: @escaping (NasaModel) -> Void) {
        guard let url = URL(string: Api.nasaEndPoint + "?api_key=" + Api.nasaApiKey) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let currentNasa = try JSONDecoder().decode(Nasa.self, from: data)
                let nasaImageUrl = URL(string: currentNasa.hdurl) ?? URL(string: "")
                
                CellApi.shared.getImageFormUrl(url: nasaImageUrl!) { image in
                    let nasaModel = NasaModel(date: currentNasa.date,
                                              image: image,
                                              title: currentNasa.title,
                                              url: currentNasa.url,
                                              explanation: currentNasa.explanation,
                                              author: "Me")//currentNasa.copyright)
                    
                    complition(nasaModel)
                }
                
            } catch {
                print(error)
                return
            }
        }.resume()
    }
}
