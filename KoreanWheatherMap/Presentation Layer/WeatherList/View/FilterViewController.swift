//
//  FilterViewController.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/31.
//

import Foundation
import UIKit

import RxSwift

class FilterViewController: UIViewController {
    let topView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .clear
        return view
    }()
    let topDarkLine: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 3
        return view
    }()
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    var filterTableView = UITableView()
    var viewModel: WeatherListViewModel
    
    init(viewModel: WeatherListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupTableView()
    }
    
    func setupViews() {
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        topView.addGestureRecognizer(panGesture)
        
        view.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        topView.addSubview(topDarkLine)
        topDarkLine.translatesAutoresizingMaskIntoConstraints = false
        topDarkLine.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive = true
        topDarkLine.heightAnchor.constraint(equalToConstant: 6).isActive = true
        topDarkLine.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15).isActive = true
        topDarkLine.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupTableView() {
        view.addSubview(filterTableView)
        filterTableView.translatesAutoresizingMaskIntoConstraints = false
        filterTableView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        filterTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        filterTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        filterTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        filterTableView.backgroundColor = .white
        filterTableView.register(FilterTableViewCell.self, forCellReuseIdentifier: "Cell")
        filterTableView.delegate = self
        filterTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        guard translation.y >= 0 else { return }
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}
extension FilterViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FilterTableViewCell
        
        cell.itemLabel.text = viewModel.tableViewItems[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.row == 0 {
            viewModel.filterObservable.onNext(FilterState.closest)
        } else if indexPath.row == 1 {
            viewModel.filterObservable.onNext(FilterState.highestTemperature)
        }  else if indexPath.row == 2 {
            viewModel.filterObservable.onNext(FilterState.lowestTemperature)
        }  else if indexPath.row == 3 {
            viewModel.filterObservable.onNext(FilterState.biggestName)
        } else {
            viewModel.filterObservable.onNext(FilterState.smallestName)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
