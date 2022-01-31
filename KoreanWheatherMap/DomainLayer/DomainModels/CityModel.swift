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
    let latitude: Double
    let longtitude: Double
    
    static var cities: [CityModel] = {
        var gongju = CityModel.init(korean: "공주시", english: "Gongju",latitude: 36.44667, longtitude: 127.11972)
        var gwangju = CityModel.init(korean: "광주시(전라남도)", english: "Gwangju",latitude: 35.15972, longtitude: 126.85306)
        var gumi = CityModel.init(korean: "구미시", english: "Gumi",latitude: 36.11944, longtitude: 128.34472)
        var gunsan = CityModel.init(korean: "군산시", english: "Gunsan",latitude: 35.96833, longtitude: 126.73722)
        var daegu = CityModel.init(korean: "대구시", english: "Daegu",latitude: 35.87222, longtitude: 128.60250)
        var daejeon = CityModel.init(korean: "대전시", english: "Daejeon",latitude: 36.35111, longtitude: 127.38500)
        var mokpo = CityModel.init(korean: "목포시", english: "Mokpo",latitude: 34.8118351, longtitude: 126.3921664)
        var busan = CityModel.init(korean: "부산시", english: "Busan",latitude: 35.17944, longtitude: 129.07556)
        var seosan = CityModel.init(korean: "서산시", english: "Seosan",latitude: 36.78500, longtitude: 126.45056)
        var seoul = CityModel.init(korean: "서울시", english: "Seoul",latitude: 37.56667, longtitude: 126.97806)
        var sokcho = CityModel.init(korean: "속초시", english: "Sokcho",latitude: 38.20694, longtitude: 128.59194)
        var suwon = CityModel.init(korean: "수원시", english: "Suwon",latitude: 37.26389, longtitude: 127.02861)
        var suncheon = CityModel.init(korean: "순천시", english: "Suncheon",latitude: 34.95583, longtitude: 127.49028)
        var ulsan = CityModel.init(korean: "울산시", english: "Ulsan",latitude: 35.53889, longtitude: 129.31667)
        var iksan = CityModel.init(korean: "익산시", english: "Iksan",latitude: 35.95000, longtitude: 126.95833)
        var jeonju = CityModel.init(korean: "전주시", english: "Jeonju",latitude: 35.82500, longtitude: 127.15000)
        var jeju = CityModel.init(korean: "제주시", english: "Jeju",latitude: 33.50000, longtitude: 126.51667)
        var cheonan = CityModel.init(korean: "천안시", english: "Cheonan",latitude: 36.81528, longtitude: 127.11389)
        var cheongju = CityModel.init(korean: "청주시", english: "Cheongju",latitude: 36.64389, longtitude: 127.48944)
        var chuncheon = CityModel.init(korean: "춘천시", english: "Chuncheon",latitude: 37.8813153, longtitude: 127.7299707)
        
        return [gongju, gwangju, gumi, gunsan, daegu, daejeon, mokpo, busan, seosan, seoul, sokcho, suwon, suncheon, ulsan, iksan, jeonju, jeju, cheonan, cheongju, chuncheon]
    }()
}
