//
//  ViewController.swift
//  CocoaPods-Demo
//
//  Created by Brendon Crowe on 4/10/23.
//

import UIKit
import Kingfisher

class CocktailViewController: UIViewController {
    
    private let cocktailView = CocktailView()
    private lazy var swipeGesture: UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer()
        gesture.addTarget(self, action: #selector(fetchCocktail))
        gesture.direction = .left
        return gesture
    }()
    
    override func loadView() {
        view = cocktailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        fetchCocktail()
        cocktailView.cocktailImage.isUserInteractionEnabled = true
        cocktailView.cocktailImage.addGestureRecognizer(swipeGesture)
    }
    
    // shake device to change cocktail
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            fetchCocktail()
        }
    }
    
    @objc private func fetchCocktail() {
        APIClient.fetchCockTail { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let cocktail):
                DispatchQueue.main.async {
                    self?.updateUI(cocktail)
                }
            }
        }
    }
    
    private func updateUI(_ cocktail: Cocktail) {
        cocktailView.cocktailNameLabel.text = cocktail.strDrink
        cocktailView.ingredientsLabel.text = cocktail.ingredients
        guard let imageURL = URL(string: cocktail.strDrinkThumb) else { return }
        cocktailView.cocktailImage.kf.setImage(with: imageURL)
        UIView.transition(with: cocktailView.cocktailImage, duration: 0.5, options: [.transitionFlipFromRight, .curveEaseOut]) {
            self.cocktailView.cocktailImage.kf.setImage(with: imageURL)
        }
    }
}

