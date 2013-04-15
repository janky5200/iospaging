//
//  DemoViewController.h
//  PageDemo
//
//  Created by 4DTECH on 13-4-12.
//  Copyright (c) 2013年 4DTECH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageView.h"
@interface DemoViewController : UIViewController<PageViewDelegate>
{
    int currentIndex;
    BOOL fromLeft;
    BOOL tap;
    float startX;
    int nextPageIndex;
    float minMoveWidth;
}
@property(nonatomic,retain) PageView *visitPage;
@property(nonatomic,retain) PageView *prePage;
@property(nonatomic,retain) PageView *nextPage;
@end
