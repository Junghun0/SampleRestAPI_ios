//
//  ListViewController.swift
//  SampleRestAPI_ios
//
//  Created by 박정훈 on 24/01/2019.
//  Copyright © 2019 swift. All rights reserved.
//

import Foundation
import UIKit

class ListViewController : UITableViewController{
    
    //튜플 아이템으로 구성된 데이터 세트
    var dataset = [
        ("다크 나이트","영웅물에 철학에 음악까지 더해져 예술이 되다.","2008-09-04", 8.95 ),
        ("호우시절","때를 알고 내리는 좋은 비","2009-10-08",7.31),
        ("말할 수 없는 비밀","여기서 너까지 다섯 걸음","2015-05-07",9.19)
    ]
    
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        for(title , desc , opendate , rating) in self.dataset{
            let mvo = MovieVO()
            mvo.title = title
            mvo.description = desc
            mvo.opendate = opendate
            mvo.rating = rating
            
            datalist.append(mvo)
        }
        return datalist
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. API 호출을 위한 URI를 생성
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=1&count=10&genreId=&order=releasedateasc"
        
        let apiURI: URL! = URL(string: url)
        
        //2. REST API 를 호출
        let apidata = try! Data(contentsOf: apiURI)
        
        //3. 데이터 전송 결과를 로그로 출력(반드시 필요한 코드는 아님)
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""; NSLog("API Result = \(log)")
        
        //4. JSON 객체를 파싱하여 NSDictionary 객체로 받음
        do{
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            
            //5. 데이터 구조에 따라 차례대로 캐스팅하며 읽어온다.
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
            //6. Iterator 처리를 하면서 API 데이터를 MovieVO 객체에 저장한다.
            for row in movie{
                //순회 상수를 NSDictionary 타입으로 캐스팅
                let r = row as! NSDictionary
                
                //테이블 뷰 리스트를 구성할 데이터 형식
                let mvo = MovieVO()
                
                //movie 배열의 각 데이터를 mvo 상수의 속성에 대입
                mvo.title = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail = r["thumbnailImage"] as? String
                mvo.detail = r["linkUrl"] as? String
                mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)
                
                //list 배열에 추가
                self.list.append(mvo)
            }
        }catch{}
    }
    
    
}
