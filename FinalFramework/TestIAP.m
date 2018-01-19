//
//  TestIAP.m
//  FinalFramework
//
//  Created by Kanagaraj on 18/01/18.
//  Copyright © 2018 Trellisys. All rights reserved.
//

#import "TestIAP.h"

@implementation TestIAP
@synthesize csRequest;

/*- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSLog(@"load IAP success");
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"load IAP fail with error : %@", error);
}*/

- (void) loadIAPsToArray:(NSString *)bundleIdentifier bookIds:(NSArray *)bookSufix productDelegate:(id )delegateID{
    if(csIAPsArray == nil) {
        csIAPsArray = [[NSMutableArray alloc] init];
    }
    [csIAPsArray removeAllObjects];
    csRequest = nil;
    
    NSLog(@"started to create an array");
    
    @try {
        NSURL *path = [[NSBundle mainBundle] URLForResource:@"PriceTier" withExtension:@"json"];
        NSData *data = [NSData dataWithContentsOfURL:path];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if(json != nil && bundleIdentifier != nil) {
            for (NSString *key in json.allKeys) {
                [csIAPsArray addObject:[NSString stringWithFormat:@"%@.%@", bundleIdentifier, [json objectForKey:key]]];
            }
        }
        
        if(bookSufix != nil) {
            for (NSString *bookID in bookSufix) {
                [csIAPsArray addObject:[NSString stringWithFormat:@"%@.%@", bundleIdentifier, bookID]];
            }
        }
        NSLog(@"Array created : %@", csIAPsArray);
        
        if(csIAPsArray != nil && [csIAPsArray count] > 0) {
            NSLog(@"Array created and ready to parse");
            csRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithArray:csIAPsArray]];
            csRequest.delegate = delegateID;
            [csRequest start];
            NSLog(@"Array created and started to parse");
        }
        else {
            NSLog(@"Array created and somethig is missing");
        }
        
    }
    @catch (NSException *e) {
        NSLog(@"load IAP exception : %@", e.description);
    }
}

/*@IBAction func loadIAPs()  {
    
    let request = SKProductsRequest(productIdentifiers: NSSet(array: csIAPsArray as! [Any]) as! Set<String>)
    request.delegate = self
    request.start()
}

func readIAPsFromBundle() -> NSMutableArray! {
    
    let mutableArray = NSMutableArray()
    let path = Bundle.main.url(forResource: "PriceTier", withExtension: "json")
    let identifier = Bundle.main.bundleIdentifier?.replacingOccurrences(of: "-", with: "_")
    do {
        let data = try Data(contentsOf: path!)
        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
        if(json != nil && identifier != nil) {
            
            for (_, value) in json! {
                mutableArray.add("\(identifier!).\(value)")
            }
        }
    }
    catch {
        print(error)
    }
    
    if let bundleString = identifier {
        mutableArray.add("\(bundleString).book81003619001")
    }
    
    return mutableArray
}

func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    
    let count = response.products.count
    print("count : \(count)")
    
    if(count > 0) {
        for  i in 0 ..< count {
            let product = response.products[i] as SKProduct
            print("available = \(product.productIdentifier)   : \(product.price)")
        }
    }
}

func request(_ request: SKRequest, didFailWithError error: Error) {
    print(error)
}*/

@end
