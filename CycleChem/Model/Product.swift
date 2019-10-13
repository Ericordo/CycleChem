//
//  Product.swift
//  CycleChem
//
//  Created by Eric Ordonneau on 30/05/2019.
//  Copyright © 2019 Eric Ordonneau. All rights reserved.
//

import Foundation

public struct IAPProduct {
    
    public static let SwiftShopping = "com.price.ads50questions"
    
    private static let productIdentifiers: Set<ProductIdentifier> = [IAPProduct.SwiftShopping]
    
    public static let store = IAPHelper(productIds: IAPProduct.productIdentifiers)
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
    return productIdentifier.components(separatedBy: ".").last
}
