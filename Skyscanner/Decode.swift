//
//  Decode.swift
//  sssapp
//
//  Created by David Frenkel on 27/02/2016.
//  Copyright © 2016 sssapp. All rights reserved.
//
import UIKit
class Decode: NSObject {
    
    func cityToIATA(input: String) ->String{
        switch input {
        case "London, United Kingdom": return "BUD"
        case "Atlanta, United States": return "ATL"
        case "Beijing, China": return "PEK"
        case "Garhoud, United Arab Emirates" : return "DXB"
        case "Chicago, United States": return "ORD"
        case "Tokyo, Japan": return "NHD"
        case "Los Angeles, United States": return "LAX"
        case "Hong Kong, Hong Kong": return "HKG"
        case "Paris, France": return "CDG"
        case "Istanbul, Turkey": return "IST"
        case "Frankfurt, Germany": return "FRA"
        case "Pudong, China": return "PVG"
        case "Amsterdam, Netherlands": return "AMS"
        case "New York, United States": return "JFK"
        case "Singapore, Singapore": return "SIN"
        case "Denver, United States": return "DEN"
        case "Madrid, Spain": return "MAD"
        case "Las Vegas, United States": return "LAS"
        case "Phoenix, United States": return "PHX"
        case "Sao Paulo, Brazil": return "CGH"
        case "Seoul, South Korea": return "GMP"
        case "Moscow, Russia": return "DME"
        case "Jakarta, Indonesia": return "CGK"
        case "Mexico City, Mexico": return "MEX"
        case "Lima, Peru": return "LIM"
        case "Bangkok, Thailand": return "DMK"
        case "Tehran, Iran": return "THR"
        case "Hanoi, Vietnam": return "HAN"
        case "Ankara, Turkey": return "ANK"
        case "Santiago, Chile": return "SCL"
        case "Berlin, Germany": return "TXL"
        case "Bratislava, Slovak Republic": return "BTS"
        case "Prague, Czech Republic": return "PRG"
        case "Rome, Italy": return "FCO"
        case "Stockholm, Sweden": return "ARN"
        case "Bucharest, Romania": return "OTP"
        case "Vienna, Austria": return "VIE"
        case "Budapest, Hungary": return "BUD"
        case "Warsaw, Poland": return "WAW"
        case "Belgrade, Serbia": return "BEG"
        case "Sofia, Bulgaria": return "SOF"
        case "Dublin, Ireland": return "DUB"
        case "Riga, Latvia": return "RIX"
        case "Oslo, Norway": return "FBU"
        case "Helsinki, Finland": return "HEM"
        default: return "LAX"
            
        }
    }
}