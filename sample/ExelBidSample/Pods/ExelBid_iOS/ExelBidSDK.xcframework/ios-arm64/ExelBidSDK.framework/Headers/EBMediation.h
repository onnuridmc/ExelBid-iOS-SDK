//
//  EBMediation.h
//
//  Created by Jaeuk Jeong on 2023/02/15.
//

#import <Foundation/Foundation.h>

@interface EBMediation : NSObject

@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) int index;
@property (nonatomic, assign) int priority_rate;
@property (nonatomic, strong) NSString *unit_id;

- (id)initWith:(NSDictionary *)dic;

@end
