//
//  View.swift
//  BasicViperUsage
//
//  Created by Ege Seçkin on 4.06.2022.
//

import Foundation
import UIKit
//Talks to -> Presenter

protocol AnyView {
    var presenter: AnyPresenter? {get set}
    
    func update(with datas: [Crypto])
    func update(with error: String)
}

class BasicViewController: UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource {

    var presenter: AnyPresenter?
    
    var datas: [Crypto] = []
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Downloading..."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        messageLabel.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 - 25, width: 200, height: 50)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = datas[indexPath.row].currency
        content.secondaryText = datas[indexPath.row].price
        cell.contentConfiguration = content
        cell.backgroundColor = .white
        return cell
    }
    
    
    
    func update(with datas: [Crypto]) {
        DispatchQueue.main.async {
            self.datas = datas
            self.messageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.datas = []
            self.tableView.isHidden = true
            self.messageLabel.text = error
            self.messageLabel.isHidden = false
        }
    }
    
    
    
    
}
