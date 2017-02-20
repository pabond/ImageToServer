//
//  BPVMacro.h
//  iOSProject
//
//  Created by Bondar Pavel on 7/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#define $(...)  [NSSet setWithObjects:__VA_ARGS__, nil]

#define BPVDefineBaseViewProrety(propertyName, viewClass) \
    @property (nonatomic, readonly) viewClass *propertyName;

#define BPVBaseViewGetterSyntesize(selector, viewClass) \
    - (viewClass *)selector { \
        if ([self isViewLoaded] && [self.view isKindOfClass:[viewClass class]]) { \
            return (viewClass *)self.view; \
        } \
        \
        return nil; \
    }

#define BPVViewControllerBaseViewPropertyWithGetter(viewControllerClass, propertyName, baseViewClass) \
    @interface viewControllerClass (__BPVPrivateBaseView_##viewControllerClass_##propertyName) \
    BPVDefineBaseViewProrety(propertyName, baseViewClass)\
    \
    @end \
    \
    @implementation viewControllerClass (__BPVPrivateBaseView_##viewControllerClass_##propertyName) \
    \
    @dynamic propertyName; \
    \
    BPVBaseViewGetterSyntesize(propertyName, baseViewClass)\
    \
    @end


#define BPVPerformBlock(block) \
    if (block) { \
        block(); \
    }


#define BPVWeakify(variable) \
    __weak __typeof(variable) __BPVWeakified_##variable = variable;

//should be called only after BPVWeakify call
#define BPVStrongify(variable) \
    __strong __typeof(variable) variable = __BPVWeakified_##variable;


#define BPVEmptyResult

#define BPVStrongifyAndReturnIfNil(variable) \
    BPVStrongifyAndReturnResultIfNil(variable, BPVEmptyResult)

#define BPVStrongifyAndReturnNilIfNil(variable) \
    BPVStrongifyAndReturnResultIfNil(variable, nil)

#define BPVStrongifyAndReturnResultIfNil(variable, result) \
    BPVStrongify(variable); \
    if (!variable) { \
        return result; \
    }


#define BPVConstant(type, name, value) \
    static const type name = value;


#define BPVStringConstantWithValue(name, value) \
    static NSString * const name = @#value


#define BPVStringConstant(name) \
    static NSString * const name = @#name


#define BPVPrintCurrentSelector \
    NSLog(@"[INFO] %@", NSStringFromSelector(_cmd))


#define BPVReturnOnce(type, variable, block)  \
    do {\
        static dispatch_once_t onceToken; \
        static type *variable = nil; \
        dispatch_once(&onceToken, ^{ \
            if (block) { \
                variable = block(); \
            } \
        }); \
        \
        return variable; \
        \
    } while (0)

#define BPVStringFromSEL(sel) \
    NSStringFromSelector(@selector(sel))

#define BPVSetKVCValue(value, valueGetter) \
    [self setValue:value forKey:NSStringFromSelector(@selector(valueGetter))]

#define BPVKVCValue(valueGetter) \
    return [self valueForKey:NSStringFromSelector(@selector(valueGetter))]
