//
//  CocktailView.swift
//  CocoaPods-Demo
//
//  Created by Brendon Crowe on 4/10/23.
//

import UIKit
import SnapKit

class CocktailView: UIView {
    
    public lazy var cocktailNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.numberOfLines = 2
        label.text = "Cocktail Name"
        return label
    }()
    
    public lazy var cocktailImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "photo")
        return iv
    }()
    
    public lazy var ingredientsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.numberOfLines = 0
        label.text = "Ingredients"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
      setupCocktailImageConstraints()
      setupCocktailNameLabel()
      setupIngredientsLabel()
    }
    
    private func setupCocktailImageConstraints() {
      addSubview(cocktailImage)
      cocktailImage.snp.makeConstraints { (make) in
        make.top.leading.bottom.trailing.equalTo(self.safeAreaLayoutGuide)
      }
    }
    
    private func setupCocktailNameLabel() {
      cocktailImage.addSubview(cocktailNameLabel)
      cocktailNameLabel.snp.makeConstraints { (make) in
        make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
      }
    }
    
    private func setupIngredientsLabel() {
      cocktailImage.addSubview(ingredientsLabel)
      ingredientsLabel.snp.makeConstraints { (make) in
        make.leading.bottom.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
      }
    }
  }
