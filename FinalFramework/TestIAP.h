//
//  TestIAP.h
//  FinalFramework
//
//  Created by Kanagaraj on 18/01/18.
//  Copyright © 2018 Trellisys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@interface TestIAP : NSObject {
    NSMutableArray *csIAPsArray;
}

@property (nonatomic, strong) SKProductsRequest *csRequest;

- (void) loadIAPsToArray:(NSString *)bundleIdentifier bookIds:(NSArray *)bookSufix productDelegate:(id )delegateID;

@end
