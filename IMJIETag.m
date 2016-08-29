//
//  IMJIETag.m
//  IMJIETagView
//
//  Created by admin on 16/8/27.
//  Copyright © 2016年 IMJIE. All rights reserved.
//
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define UIColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define TextColor [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0]
#define GrayLine [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0]

#import "IMJIETag.h"
#import "UIView+SDAutoLayout.h"
@interface IMJIETag ()
{

    CGFloat viewW;
}

@property (nonatomic, strong) NSMutableArray *itemMArray;

@property (nonatomic, strong) NSMutableArray *itemMultipleMArray;


@end

@implementation IMJIETag

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        _itemMArray = [[NSMutableArray alloc] init];
        _itemMultipleMArray = [[NSMutableArray alloc] init];
        _itemsArray = @[];
        _rowsNum = 4;
        _selectTitleColor = TextColor;
        _defaultTitleColor = [UIColor blackColor];
        _font = [UIFont systemFontOfSize:13.0];
        _itemHeight = 30;
        _itemsMargin = 10;
        _itemsLineSpacing = 10;
        _cornerRadius = 0;
        _selectBorderColor = [UIColor blackColor];
        _defaultBorderColor = [UIColor grayColor];
        _borderSize = 0.5f;
        _selectBackgroundColor = [UIColor whiteColor];
        _defaultBackgroundColor = [UIColor whiteColor];
        _selectState = IMJIETagSingleSelect;
        _selectStyle = IMJIETagStaticStyle;
        
    }
    return self;
}



-(void)setItemsArray:(NSArray *)itemsArray{

    if (_itemsArray != itemsArray) {
        
        _itemsArray = itemsArray;
        viewW = (self.frame.size.width - _itemsMargin * (_rowsNum + 1))/_rowsNum;
        
        if (!_maxSelectIndex) {
           
            _maxSelectIndex = _itemsArray.count;
        }
        
    }
    
    [self setInitItems];
}

-(void)setRowsNum:(NSInteger)rowsNum{
    
    _rowsNum = rowsNum;
}

-(void)setSelectTitleColor:(UIColor *)selectTitleColor{

    _selectTitleColor = selectTitleColor;
}

-(void)setDefaultTitleColor:(UIColor *)defaultTitleColor{

    _defaultTitleColor = defaultTitleColor;
}

-(void)setFont:(UIFont *)font{

    _font = font;
}

-(void)setItemHeight:(CGFloat)itemHeight{

    _itemHeight = itemHeight;
}

-(void)setItemsMargin:(CGFloat)itemsMargin{

    _itemsMargin = itemsMargin;
}

-(void)setItemsLineSpacing:(CGFloat)itemsLineSpacing{

    _itemsLineSpacing = itemsLineSpacing;
}

-(void)setCornerRadius:(CGFloat)cornerRadius{

    _cornerRadius = cornerRadius;
}

-(void)setSelectBorderColor:(UIColor *)selectBorderColor{

    _selectBorderColor = selectBorderColor;
}

-(void)setDefaultBorderColor:(UIColor *)defaultBorderColor{

    _defaultBorderColor = defaultBorderColor;
    
}

-(void)setBorderSize:(CGFloat)borderSize{

    _borderSize = borderSize;
}

-(void)setSelectBackgroundColor:(UIColor *)selectBackgroundColor{

    _selectBackgroundColor = selectBackgroundColor;
}

-(void)setDefaultBackgroundColor:(UIColor *)defaultBackgroundColor{

    _defaultBackgroundColor = defaultBackgroundColor;
}

//-(void)setSelectString:(NSString *)selectString{
//
//    _selectString = selectString;
//    
//    if (_itemMArray.count) {
//        
//        for (UILabel *label in _itemMArray) {
//            
//            if ([_selectString isEqual: label.text]) {
//                
//                label.backgroundColor = _selectBackgroundColor;
//                label.textColor = _selectTitleColor;
//                [self makeCorner:_borderSize view:label color:_selectBorderColor];
//                
//                
//            }else{
//                
//                label.backgroundColor = _defaultBackgroundColor;
//                label.textColor = _defaultTitleColor;
//                [self makeCorner:_borderSize view:label color:_defaultBorderColor];
//            }
//        }
//
//    }
//}
//
//-(void)setSelectIndex:(NSInteger)selectIndex{
//
//    _selectIndex = selectIndex;
//    if (_itemMArray.count) {
//        
//        [self SingleSelect:_selectIndex];
//        
//    }
//}

-(void)setSelectStringArray:(NSArray *)selectStringArray{

    
    if (_selectStringArray != selectStringArray) {
        
        _selectStringArray = selectStringArray;
    }
    
    if (_itemMArray.count && _selectStringArray.count) {
        
        for (UILabel *label in _itemMArray) {
            
            if ([_selectStringArray containsObject:label.text]) {
                
                label.backgroundColor = _selectBackgroundColor;
                label.textColor = _selectTitleColor;
                [self makeCorner:_borderSize view:label color:_selectBorderColor];
                
                
            }else{
                
                label.backgroundColor = _defaultBackgroundColor;
                label.textColor = _defaultTitleColor;
                [self makeCorner:_borderSize view:label color:_defaultBorderColor];
            }
        }
        
    }

}

-(void)setSelectIndexArray:(NSArray *)selectIndexArray{

    if (_selectIndexArray != selectIndexArray) {
        
        _selectIndexArray = selectIndexArray;
    }
    
    if (_itemMArray.count && _selectStringArray.count) {
        
        for (UILabel *label in _itemMArray ) {
            
            if ([_selectIndexArray containsObject:[NSString stringWithFormat:@"%ld",(long)label.tag]]) {
                
                label.backgroundColor = _selectBackgroundColor;
                label.textColor = _selectTitleColor;
                [self makeCorner:_borderSize view:label color:_selectBorderColor];
                
                
            }else{
                
                label.backgroundColor = _defaultBackgroundColor;
                label.textColor = _defaultTitleColor;
                [self makeCorner:_borderSize view:label color:_defaultBorderColor];
            }
        }
        
    }

}

-(void)setMaxSelectIndex:(NSInteger)maxSelectIndex{

    _maxSelectIndex = maxSelectIndex;
}

-(void)setSelectState:(IMJIETagSelect)selectState{

    _selectState = selectState;
}

-(void)setSelectStyle:(IMJIETagStyle)selectStyle{

    _selectStyle = selectStyle;
}

-(void)setInitItems{

    __block NSInteger index;
    __block CGFloat labelX = 0.0f;
    __block CGFloat labelY = 0.0f;
    index = 0;
    [_itemsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        UILabel *label = [[UILabel alloc] init];
        label.text = (NSString *)obj;
        label.textColor = _defaultTitleColor;
        label.font = _font;
        label.backgroundColor = _defaultBackgroundColor;
        label.tag = idx;
        label.textAlignment = NSTextAlignmentCenter;
        CALayer *layer = label.layer;
        layer.cornerRadius = _cornerRadius;
        layer.masksToBounds = YES;
        [self addSubview:label];
        [self makeCorner:_borderSize view:label color:_defaultTitleColor];
        [self addClickEvent:self action:@selector(Select:) owner:label];
        
        [_itemMArray addObject:label];
   
        
        //默认选中
//        if (_selectString == obj) {
//            
//            self.selectString = _selectString;
//        }
//        
//        if (_selectIndex == idx) {
//            
//            self.selectIndex = _selectIndex;
//        }
        
        if ([_selectIndexArray containsObject:[NSString stringWithFormat:@"%ld",(long)idx]]) {
            
            self.selectIndexArray = _selectIndexArray;
        }
        
        if ([_selectStringArray containsObject:label.text]) {
        
            self.selectStringArray = _selectStringArray;
        }
        
        
        //布局样式
        if (_selectStyle == IMJIETagStaticStyle) {
            
            NSInteger rows =  idx/_rowsNum>(idx-1)/_rowsNum?0:index;
            index = rows?index:0;
            index ++;
            labelX = (_itemsMargin * (rows + 1)) + (viewW *rows - 1);
            labelY = (_itemsLineSpacing *(idx/_rowsNum + 1)) + (_itemHeight * (idx/_rowsNum ));
            
            
        }else if (_selectStyle == IMJIETagDynamicStyle){
            
            viewW = [self sizeWithText:(NSString *)obj font:_font].width + 10;
            UILabel *_label = _itemMArray[(idx==0?1:idx) - 1];

            [_label updateLayout];
            labelX = _itemsMargin + (_label.width + _label.origin.x);
            labelY = _itemsLineSpacing + (_label.height + _label.origin.y);
            labelY = (labelX + viewW  + 10 > CGRectGetWidth(self.frame))?labelY:_label.origin.y?_label.origin.y :10;
            labelX = (labelX + viewW  + 10 > CGRectGetWidth(self.frame))?_itemsMargin:labelX;
            
        }
        label.sd_layout
        .leftSpaceToView(self,labelX)
        .topSpaceToView(self,labelY)
        .widthIs(viewW)
        .heightIs(_itemHeight);
        
        if (idx == _itemsArray.count - 1) {

            [label updateLayout];
            CGRect frame = self.frame;
            frame.size.height = labelY + _itemHeight + 10;
            self.frame = frame;
            self.itemsHeight = frame.size.height;
        }
    }];}


#pragma mark 单选多选
-(void)Select:(UITapGestureRecognizer *)sender{

    if (_selectState == IMJIETagSingleSelect) {
        
        [self SingleSelect:[sender view].tag];
        
    }else if (_selectState == IMJIETagMultipleSelect){
    
        [self MultipleSelect:[sender view].tag];
    }
    
}

#pragma makr 单选
-(void)SingleSelect:(NSInteger )index{

    for (UILabel *label in _itemMArray) {
        
        if (index == label.tag) {
            
            label.backgroundColor = _selectBackgroundColor;
            label.textColor = _selectTitleColor;
            [self makeCorner:_borderSize view:label color:_selectBorderColor];
            
            NSString  *string = [NSString stringWithFormat:@"%ld",(long)label.tag];
            if ([_delegate respondsToSelector:@selector(IMJIE:didSelectItemS:SelectIndexs:)]) {
                
                [_delegate IMJIE:self didSelectItemS:@[label.text] SelectIndexs:@[string]];
            }
            
        }else{
        
            label.backgroundColor = _defaultBackgroundColor;
            label.textColor = _defaultTitleColor;
            [self makeCorner:_borderSize view:label color:_defaultBorderColor];
        }
    }
}

#pragma makr 多选
-(void)MultipleSelect:(NSInteger )index{
    

    for (UILabel *label in _itemMArray) {
        
        if (index == label.tag) {
            
            if ([_itemMultipleMArray containsObject:label]) {
            
                label.backgroundColor = _defaultBackgroundColor;
                label.textColor = _defaultTitleColor;
                [self makeCorner:_borderSize view:label color:_defaultBorderColor];
                [_itemMultipleMArray removeObject:label];
                
            }else{
            
                if (_itemMultipleMArray.count < _maxSelectIndex) {
                    
                    label.backgroundColor = _selectBackgroundColor;
                    label.textColor = _selectTitleColor;
                    [self makeCorner:_borderSize view:label color:_selectBorderColor];
                    [_itemMultipleMArray addObject:label];
                
                }
             
            }
            
            
        }
    }
    
    
    NSMutableArray *labelTagArray = [[NSMutableArray alloc] init];
    NSMutableArray *labelTitleArray = [[NSMutableArray alloc] init];
    for (UILabel *label in _itemMultipleMArray) {
        
        [labelTagArray addObject:[NSString stringWithFormat:@"%ld",(long)label.tag]];
        [labelTitleArray addObject:label.text];
        
    }
    
    if ([_delegate respondsToSelector:@selector(IMJIE:didSelectItemS:SelectIndexs:)]) {
        
        [_delegate IMJIE:self didSelectItemS:labelTitleArray SelectIndexs:labelTagArray];
    }
   
}




- (void) addClickEvent:(id)target action:(SEL)action owner:(UIView *)view{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    gesture.numberOfTouchesRequired = 1;
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:gesture];
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text sizeWithAttributes:attrs];
}

-(void)makeCorner:(CGFloat)corner view:(UIView *)view color:(UIColor *)color{
    
    CALayer * fileslayer = [view layer];
    fileslayer.borderColor = [color CGColor];
    fileslayer.borderWidth = corner;
    
}

@end
