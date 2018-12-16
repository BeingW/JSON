//
//  MovieTableViewController.swift
//  BoostCampAssigment
//
//  Created by Jae Ki Lee on 12/7/18.
//  Copyright © 2018 Jae Ki Lee. All rights reserved.
//

import UIKit

class MovieTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //테이블뷰 셀 아이디
    let cellId = "cellId"
    var movieList: MovieList?
    
    //TableView 셋팅
    lazy var movieListTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: self.cellId)
        return tableView
    }()
    
    //새로고침 컨트롤러
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchMoviesFromJSON(sortingNumber: "0")
        setupNavigationItems()
        setupTableView()
        movieListTableView.refreshControl = self.refreshControl
        
    }
    
    //새로고침 동작
    @objc func handleRefresh() {
        print("테이블뷰 새로고침")
        movieList?.movies.removeAll()
        fetchMoviesFromJSON(sortingNumber: "0")
        self.movieListTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    //네비게이션 바
    fileprivate func setupNavigationItems() {
        self.navigationItem.title = "영화목록"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "GearItem@2x.png"), style: .plain, target: self, action: #selector(handleArrangeButton))
    }
    
    //영화 정렬 버튼
    @objc func handleArrangeButton() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "예매율", style: .default, handler: { (_) in
            
            self.fetchMoviesFromJSON(sortingNumber: "0")
            self.navigationItem.title = "예매율순"
            self.movieListTableView.reloadData()
            
        }))
        
        alertController.addAction(UIAlertAction(title: "큐레이션", style: .default, handler: { (_) in
            self.fetchMoviesFromJSON(sortingNumber: "1")
            self.navigationItem.title = "큐레이션순"
            self.movieListTableView.reloadData()
            
        }))
        
        alertController.addAction(UIAlertAction(title: "개봉일", style: .default, handler: { (_) in
            self.fetchMoviesFromJSON(sortingNumber: "2")
            self.navigationItem.title = "개봉일순"
            self.movieListTableView.reloadData()
            
        }))
        
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    //테이블뷰 셋업
    fileprivate func setupTableView() {
        view.addSubview(movieListTableView)
        
        movieListTableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    //JSON 통신
    fileprivate func fetchMoviesFromJSON(sortingNumber: String?) {
        let sortingNumber = sortingNumber ?? "0"
        
        let jsonUrlString = "http://connect-boxoffice.run.goorm.io/movies?order_type=\(sortingNumber)"
        
        guard let url = URL(string: jsonUrlString) else {return}
        
        URLSession.shared.dataTask(with: url) {(data, response, err) in
            
            guard let data = data else {return}
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                self.movieList = try decoder.decode(MovieList.self, from: data)
                
                DispatchQueue.main.async {
                    self.movieListTableView.reloadData()
                }
                
            } catch let jsonErr {
                print("Failed to parsing json \(jsonErr)")
                self.jsonErrAlet()
            }
            
            }.resume()
    
    }
    
    //json 수신 못할시 알람창
    func jsonErrAlet() {
        let alert = UIAlertController(title: "JSON Error", message: "데이터를 수신하지 못하였습니다. 인터넷 연결을 확인후 다시 시도해 주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "재연결", style: .default, handler: { (_) in
            self.handleRefresh()
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList?.movies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (view.frame.height)/5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = movieListTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MovieTableViewCell
        cell.movie = movieList?.movies[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailController = MovieDetailControllerA()
        movieDetailController.movie = self.movieList?.movies[indexPath.row]
        
        self.navigationController?.pushViewController(movieDetailController, animated: true)
    }
}
