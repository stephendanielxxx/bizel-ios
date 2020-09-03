//
//  LoginViewModel.swift
//  Digilearn_001
//
//  Created by Teke on 03/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel{
    var loginModel = BehaviorRelay<[LoginModel]>(value: [])
    var posts = BehaviorRelay<[Post]>(value: [])

    func getLoginModel(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
               
               // fetch data menggunakan URLSession
               URLSession.shared.dataTask(with: url){(data, response, error) in
                   do{
                       
                       self.posts.accept(try JSONDecoder().decode([Post].self, from: data!))
                       
                   }catch let err{
                       print(err)
                   }
               }.resume()
    }
}
