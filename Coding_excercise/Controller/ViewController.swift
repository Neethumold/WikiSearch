//
//  ViewController.swift
//  Coding_excercise
//
//  Created by Neethu on 02/02/2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!
    
    var webManager = WebManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webManager.delegate = self
        countLabel.textColor = .red
    }
    override func viewDidAppear(_ animated: Bool) {
        countLabel.text = K.EMPTY_STRING
        activityIndicator.isHidden = true
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        countLabel.text = K.EMPTY_STRING
        UIView.animate(withDuration: 0.2) {
            sender.backgroundColor = UIColor.systemGray
        }
        if let searchText = searchTextfield.text {
            if (searchText == K.EMPTY_STRING) {
                countLabel.textColor = .red
                countLabel.text = K.ENTER_VALID_INPUT
                UIView.animate(withDuration: 0.2) {
                    self.searchButton.backgroundColor = UIColor.white
                }
                return
            }
            startAnimatingActivityIndicator()
            webManager.searchWeb(searchKeyword: searchText)
        }
    }
}

extension ViewController: WebManagerDelegate {
    func didFindCount(countOfTitle: Int, title: String) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) {
                self.searchButton.backgroundColor = UIColor.white
            }
            self.stopAnimatingActivityIndicator()
            self.countLabel.textColor = .systemBlue
            self.countLabel.text = K.COUNT_LABEL_TEXT1+title+K.COUNT_LABEL_TEXT2+String(countOfTitle)
        }
    }

    func didFailWithError(error: Error) {
        print(K.ERROR_OCCURED + error.localizedDescription)
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) {
                self.searchButton.backgroundColor = UIColor.white
            }
            self.stopAnimatingActivityIndicator()
            self.countLabel.textColor = .red
            self.countLabel.text = error.localizedDescription
        }
    }
    
    func startAnimatingActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func stopAnimatingActivityIndicator() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
        activityIndicator.isHidden = true
    }
}
