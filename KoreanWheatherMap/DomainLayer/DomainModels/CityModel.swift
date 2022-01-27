//
//  CityModel.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/26.
//

import Foundation

struct CityModel {
    let korean: String
    let english: String
    
    static var cities: [CityModel] = {
        let gongju = CityModel.init(korean: "공주시", english: "Gongju")
        let gwangju = CityModel.init(korean: "광주시(전라남도)", english: "Gwangju")
        let gumi = CityModel.init(korean: "구미시", english: "Gumi")
        let gunsan = CityModel.init(korean: "군산시", english: "Gunsan")
        let daegu = CityModel.init(korean: "대구시", english: "Daegu")
        let daejeon = CityModel.init(korean: "대전시", english: "Daejeon")
        let mokpo = CityModel.init(korean: "목포시", english: "Mokpo")
        let busan = CityModel.init(korean: "부산시", english: "Busan")
        let seosan = CityModel.init(korean: "서산시", english: "Seosan")
        let seoul = CityModel.init(korean: "서울시", english: "Seoul")
        let sokcho = CityModel.init(korean: "속초시", english: "Sokcho")
        let suwon = CityModel.init(korean: "수원시", english: "Suwon")
        let suncheon = CityModel.init(korean: "순천시", english: "Suncheon")
        let ulsan = CityModel.init(korean: "울산시", english: "Ulsan")
        let iksan = CityModel.init(korean: "익산시", english: "Iksan")
        let jeonju = CityModel.init(korean: "전주시", english: "Jeonju")
        let jeju = CityModel.init(korean: "제주시", english: "Jeju")
        let cheonan = CityModel.init(korean: "천안시", english: "Cheonan")
        let cheongju = CityModel.init(korean: "청주시", english: "Cheongju")
        let chuncheon = CityModel.init(korean: "춘천시", english: "Chuncheon")
        
        return [gongju, gwangju, gumi, gunsan, daegu, daejeon, mokpo, busan, seosan, seoul, sokcho, suwon, suncheon, ulsan, iksan, jeonju, jeju, cheonan, cheongju, chuncheon]
    }()
}
