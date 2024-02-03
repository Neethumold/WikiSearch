//
//  WebManager.swift
//  Coding_excercise
//
//  Created by Neethu on 02/02/2024.
//

import Foundation

protocol WebManagerDelegate {
    func didFindCount(countOfTitle: Int, title: String)
    func didFailWithError(error: Error)
}

struct WebManager {
    var webUrl = K.URL_STRING
    var delegate: WebManagerDelegate?
    
    func searchWeb(searchKeyword: String) {
        if let encodedStringKeyword = urlEncode(searchKeyword) {
            let completeUrl = webUrl + "\(encodedStringKeyword)"
            if let url = URL(string: completeUrl) {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { data, response, error in
                    if error != nil {
                        print(K.ERROR_FETCHING_DATA)
                        delegate?.didFailWithError(error: error!)
                        return
                    }
                    if let safeData = data {
                        if let parsedData = parseJSON(dataFromWeb: safeData) {
                            let count = findCountOfTitle(parsedData: parsedData)
                            delegate?.didFindCount(countOfTitle: count, title: parsedData.title)
                        }
                    }
                }
                task.resume()
            }
        } else {
            print(K.ERROR_ENCODING_STRING)
        }
    }
    
    func findCountOfTitle(parsedData: WebModel) -> Int {
        let htmlText = parsedData.htmlText.lowercased()
        let title = parsedData.title.lowercased()
        let count = htmlText.components(separatedBy: title).count - 1
        return count
    }
    
    func parseJSON(dataFromWeb: Data) -> WebModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WebData.self, from: dataFromWeb)
            let parse = decodedData.parse
            let title = parse.title
            let html = parse.text.content
            return WebModel(title: title, htmlText: html)
        } catch {
            print(K.ERROR_DECODING_JSON)
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func urlEncode(_ string: String) -> String? {
        let allowedCharacterSet = CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ").inverted
        return string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
    }
}
