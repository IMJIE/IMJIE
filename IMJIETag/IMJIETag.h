//
//  IMJIETag.h
//  IMJIETagView
//
//  Created by admin on 16/8/27.
//  Copyright © 2016年 IMJIE. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    
    IMJIETagSingleSelect                = 0, //单选
    IMJIETagMultipleSelect              = 1, //多选
    IMJIETagCannotSelect                = 2, //不能选中
    
}IMJIETagSelect;

typedef enum{
    
    IMJIETagStaticStyle                 = 0, //固定布局
    IMJIETagDynamicStyle                = 1, //动态布局
    
}IMJIETagStyle;

@class IMJIETag;
@protocol IMJIETagDelegate <NSObject>

/** delegate */
-(void)IMJIE:(IMJIETag *)imjie didSelectItemS:(NSArray *)items SelectIndexs:(NSArray *)itemindexs;

@end


@interface IMJIETag : UIView

@property (nonatomic, weak) id<IMJIETagDelegate>delegate;

/** rows default is 4*/
@property (nonatomic, assign) NSInteger rowsNum;

/** itemsArray*/
@property (nonatomic, strong) NSArray *itemsArray;

/** 单选&多选 default is IMJIETagSingleSelect */
@property (nonatomic, assign) IMJIETagSelect selectState;

/** 布局 default is IMJIETagStaticStyle */
@property (nonatomic, assign) IMJIETagStyle selectStyle;

/** 选中字体颜色 default is TextColor */
@property (nonatomic, strong) UIColor *selectTitleColor;

/** 默认字体颜色 default is GrayLine */
@property (nonatomic, strong) UIColor *defaultTitleColor;

/** 默认字体大小 default is 13*/
@property (nonatomic, strong) UIFont *font;

/** 标签的高度  default is 30*/
@property (nonatomic, assign) CGFloat itemHeight;

/** 标签间距 default is 10*/
@property (nonatomic, assign) CGFloat itemsMargin;

/** 标签行间距 default is 10*/
@property (nonatomic, assign) CGFloat itemsLineSpacing;

/** 圆角 default is 0*/
@property (assign, nonatomic) CGFloat cornerRadius;

/** 选中边框颜色 default is blackColor */
@property (strong, nonatomic) UIColor *selectBorderColor;

/** 默认边框颜色 default is grayColor */
@property (strong, nonatomic) UIColor *defaultBorderColor;

/** 边框大小 default is 0.5*/
@property (assign, nonatomic) CGFloat borderSize;

/** 选中背景颜色 default is whiteColor */
@property (strong, nonatomic) UIColor *selectBackgroundColor;

/** 默认背景颜色 default is whiteColor */
@property (strong, nonatomic) UIColor *defaultBackgroundColor;

/**  默认多选(文字类型 二选一) default is nil*/
@property (strong, nonatomic) NSArray *selectIndexArray;

/**  默认多选(数组角标 二选一) default is nil*/
@property (strong, nonatomic) NSArray *selectStringArray;

/** 多选最大个数  default is all */
@property (assign, nonatomic) NSInteger maxSelectIndex;

/** 全部标签的高度 */
@property (nonatomic, assign) CGFloat itemsHeight;

@end
