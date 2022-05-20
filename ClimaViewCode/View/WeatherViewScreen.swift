//
//  WeatherViewScreen.swift
//  ClimaViewCode
//
//  Created by Jean Lucas Vitor on 02/05/22.
//

import UIKit

protocol WeatherViewScreenProtocol: AnyObject {
    func tappedLocaleBtn()
    func tappedSearchBtn()
}

class WeatherViewScreen: UIView {
    
    private weak var delegate: WeatherViewScreenProtocol?
    
    func delegate(delegate: WeatherViewScreenProtocol?) {
          self.delegate = delegate
      }

    lazy var backgroundImage: UIImageView = {
        let bg = UIImageView()
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.backgroundColor = .clear
        bg.image = UIImage(named: "background")
        bg.contentMode = .scaleAspectFill
        return bg
    }()
    
    lazy var stachSearchBar: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fill
        return stack
    }()
    
    lazy var myLocaleBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.tintColor = .label
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(self.localePressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var searchLabel: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemFill
        textField.borderStyle = .roundedRect
        
        textField.placeholder = "Search"
        textField.textAlignment = .right
        textField.textColor = .label
        textField.font = UIFont.systemFont(ofSize: 25)
        return textField
    }()
    
    lazy var searchBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        btn.tintColor = .label
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(self.searchPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var weatherIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = UIColor(named: "weatherColor")
        return image
    }()
    
    lazy var stackTemperatureLabel: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.contentMode = .scaleToFill
        return stack
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 80, weight: .black)
        label.textAlignment = .left
        return label
    }()
    
    lazy var temperatureSimbol: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 100, weight: .light)
        label.textAlignment = .right
        label.text = "°"
        return label
    }()
    
    lazy var temperatureSimbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 100, weight: .light)
        label.textAlignment = .right
        label.text = "C"
        return label
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addElements()
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func localePressed() {
        self.delegate?.tappedLocaleBtn()
    }
    
    @objc func searchPressed() {
        self.delegate?.tappedSearchBtn()
    }
    
    public func configTextFieldDelegate(delegate: UITextFieldDelegate) {
           self.searchLabel.delegate = delegate
       }
    
    private func addElements() {
        self.addSubview(self.backgroundImage)
        self.addSubview(self.stachSearchBar)
        self.stachSearchBar.addArrangedSubview(self.myLocaleBtn)
        self.stachSearchBar.addArrangedSubview(self.searchLabel)
        self.stachSearchBar.addArrangedSubview(self.searchBtn)
        self.addSubview(self.weatherIcon)
        self.addSubview(self.stackTemperatureLabel)
        self.stackTemperatureLabel.addArrangedSubview(self.temperatureLabel)
        self.stackTemperatureLabel.addArrangedSubview(self.temperatureSimbol)
        self.stackTemperatureLabel.addArrangedSubview(self.temperatureSimbolLabel)
        self.addSubview(self.cityLabel)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            self.backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.stachSearchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.stachSearchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.stachSearchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            self.myLocaleBtn.leadingAnchor.constraint(equalTo: self.stachSearchBar.leadingAnchor),
            self.myLocaleBtn.heightAnchor.constraint(equalToConstant: 40),
            self.myLocaleBtn.widthAnchor.constraint(equalToConstant: 40),
            
            self.searchBtn.trailingAnchor.constraint(equalTo: self.stachSearchBar.trailingAnchor),
            self.searchBtn.heightAnchor.constraint(equalToConstant: 40),
            self.searchBtn.widthAnchor.constraint(equalToConstant: 40),
            
            self.weatherIcon.topAnchor.constraint(equalTo: self.stachSearchBar.bottomAnchor, constant: 20),
            self.weatherIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.weatherIcon.heightAnchor.constraint(equalToConstant: 120),
            self.weatherIcon.widthAnchor.constraint(equalToConstant: 120),
            
            self.stackTemperatureLabel.topAnchor.constraint(equalTo: self.weatherIcon.bottomAnchor, constant: 10),
            self.stackTemperatureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            self.cityLabel.topAnchor.constraint(equalTo: self.stackTemperatureLabel.bottomAnchor, constant: 10),
            self.cityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
    
}
