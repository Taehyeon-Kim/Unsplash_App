//
//  ColorPickData.swift
//  Unsplash_API_Test
//
//  Created by taehy.k on 2021/02/15.
//

/*
 {
     "result": {
         "colors": {
             "background_colors": [
                 {
                     "b": 42,
                     "closest_palette_color": "graphite",
                     "closest_palette_color_html_code": "#3a3536",
                     "closest_palette_color_parent": "black",
                     "closest_palette_distance": 6.54300546646118,
                     "g": 44,
                     "html_code": "#2a2c2a",
                     "percent": 38.9320678710938,
                     "r": 42
                 },
                 {
                     "b": 104,
                     "closest_palette_color": "light brown",
                     "closest_palette_color_html_code": "#ac8a64",
                     "closest_palette_color_parent": "skin",
                     "closest_palette_distance": 4.84842586517334,
                     "g": 136,
                     "html_code": "#9d8868",
                     "percent": 34.507884979248,
                     "r": 157
                 },
                 {
                     "b": 54,
                     "closest_palette_color": "graphite",
                     "closest_palette_color_html_code": "#3a3536",
                     "closest_palette_color_parent": "black",
                     "closest_palette_distance": 10.0781946182251,
                     "g": 66,
                     "html_code": "#424236",
                     "percent": 26.5600471496582,
                     "r": 66
                 }
             ],
             "color_percent_threshold": 1.75,
             "color_variance": 32,
             "foreground_colors": [
                 {
                     "b": 158,
                     "closest_palette_color": "sand",
                     "closest_palette_color_html_code": "#c1b7b0",
                     "closest_palette_color_parent": "light grey",
                     "closest_palette_distance": 4.66602230072021,
                     "g": 170,
                     "html_code": "#b3aa9e",
                     "percent": 38.8724822998047,
                     "r": 179
                 },
                 {
                     "b": 92,
                     "closest_palette_color": "antique gold",
                     "closest_palette_color_html_code": "#8c7c61",
                     "closest_palette_color_parent": "olive green",
                     "closest_palette_distance": 10.5157136917114,
                     "g": 103,
                     "html_code": "#71675c",
                     "percent": 38.7055320739746,
                     "r": 113
                 },
                 {
                     "b": 44,
                     "closest_palette_color": "graphite",
                     "closest_palette_color_html_code": "#3a3536",
                     "closest_palette_color_parent": "black",
                     "closest_palette_distance": 4.85745763778687,
                     "g": 49,
                     "html_code": "#34312c",
                     "percent": 22.4219856262207,
                     "r": 52
                 }
             ],
             "image_colors": [
                 {
                     "b": 41,
                     "closest_palette_color": "graphite",
                     "closest_palette_color_html_code": "#3a3536",
                     "closest_palette_color_parent": "black",
                     "closest_palette_distance": 5.99257469177246,
                     "g": 42,
                     "html_code": "#292a29",
                     "percent": 22.715892791748,
                     "r": 41
                 },
                 {
                     "b": 44,
                     "closest_palette_color": "graphite",
                     "closest_palette_color_html_code": "#3a3536",
                     "closest_palette_color_parent": "black",
                     "closest_palette_distance": 8.57022571563721,
                     "g": 54,
                     "html_code": "#36362c",
                     "percent": 22.3001708984375,
                     "r": 54
                 },
                 {
                     "b": 90,
                     "closest_palette_color": "moss",
                     "closest_palette_color_html_code": "#525f48",
                     "closest_palette_color_parent": "olive green",
                     "closest_palette_distance": 11.4980545043945,
                     "g": 101,
                     "html_code": "#6a655a",
                     "percent": 19.7444267272949,
                     "r": 106
                 },
                 {
                     "b": 89,
                     "closest_palette_color": "medium coffee",
                     "closest_palette_color_html_code": "#9c7644",
                     "closest_palette_color_parent": "skin",
                     "closest_palette_distance": 4.67335033416748,
                     "g": 125,
                     "html_code": "#997d59",
                     "percent": 19.2720146179199,
                     "r": 153
                 },
                 {
                     "b": 170,
                     "closest_palette_color": "sand",
                     "closest_palette_color_html_code": "#c1b7b0",
                     "closest_palette_color_parent": "light grey",
                     "closest_palette_distance": 4.353600025177,
                     "g": 181,
                     "html_code": "#b9b5aa",
                     "percent": 15.9674987792969,
                     "r": 185
                 }
             ],
             "object_percentage": 36.7866592407227
         }
     },
     "status": {
         "text": "",
         "type": "success"
     }
 }
 */

import Foundation

struct ColorResponse: Codable {
    let result: ColorResults
}

struct ColorResults: Codable {
    var colors: Colors
//    let status: Status
}

struct Status: Codable {
    let type: String
}

struct Colors: Codable {
//    var color_variance: Int
    var image_colors: [Color]
}

struct Color: Codable {
    var closest_palette_color: String
    var r: Int
    var g: Int
    var b: Int
}
