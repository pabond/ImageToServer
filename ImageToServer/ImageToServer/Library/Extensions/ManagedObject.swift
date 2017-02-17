//
//  ManagedObject.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/16/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import CoreData

//extension NSManagedObject {
//    func setCustomValue(_ value: AnyObject, forKey key: String) {
//        self.willChangeValue(forKey: key)
//        self.setPrimitiveValue(value, forKey: key)
//        self.didChangeValue(forKey: key)
//        
//    }
//    
//    func customValue(forKey key: String) -> AnyObject {
//        self.willAccessValue(forKey: key)
//        let result = self.primitiveValue(forKey: key)
//        self.didAccessValue(forKey: key)
//        
//        return result as AnyObject
//    }
//    
//    func addCustomValue(_ value: AnyObject, forKey key: String)  {
//        
//    }
//    
//    func removeCustomValue(_ value: AnyObject, forKey key: String) {
//        
//    }
//    
//    func addCustomValues(_ values: Set<NSManagedObject>, forKey key: String) {
//        
//    }
//    
//    func removeCustomValues(_ values: Set<NSManagedObject>, forKey key: String) {
//        
//    }
//    
//    func addCustomValue(_ value: AnyObject, inSetForKey key: String) {
//        (self.primitiveValue(forKey: key)).addObject(value)
//    }
//    
//    func changeValues(_ values: Set<NSManagedObject>, forKey key: String, setMutation mutation: NSKeyValueSetMutationKind, withBlock block: () -> ()) {
//        self.willChangeValue(forKey: key, withSetMutation: mutation, using: values)
//        block()
//        self.didChangeValue(forKey: key, withSetMutation: mutation, using: values)
//    }
//    
//    - (void)addCustomValue:(id)value inMutableOrderedSetForKey:(NSString *)key {
//          [[self primitiveValueForKey:key] addObject:value];
//
//}
//        - (void)addCustomValue:(id)value forKey:(NSString *)key {
//            [self addCustomValues:[[NSSet alloc] initWithObjects:&value count:1] forKey:key];
//            }
//            
//            - (void)removeCustomValue:(id)value forKey:(NSString *)key {
//                [self removeCustomValues:[[NSSet alloc] initWithObjects:&value count:1] forKey:key];
//                }
//                
//                - (void)addCustomValues:(NSSet *)values forKey:(NSString *)key {
//                    NSMutableSet *primitiveSet = [self primitiveValueForKey:key];
//                    [self changeValues:values forKey:key setMutation:NSKeyValueUnionSetMutation withBlock:^{
//                        [primitiveSet unionSet:values];
//                        }];
//                    }
//                    
//                    - (void)removeCustomValues:(NSSet *)values forKey:(NSString *)key {
//                        NSMutableSet *primitiveSet = [self primitiveValueForKey:key];
//                        [self changeValues:values forKey:key setMutation:NSKeyValueMinusSetMutation withBlock:^{
//                            [primitiveSet minusSet:values];
//                            }];
//                        }
//                        
//
