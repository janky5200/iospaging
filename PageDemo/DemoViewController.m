//
//  DemoViewController.m
//  PageDemo
//
//  Created by 4DTECH on 13-4-12.
//  Copyright (c) 2013年 4DTECH. All rights reserved.
//

#import "DemoViewController.h"
#define MIN_MOVE_WIDTH 
@interface DemoViewController ()

@end

@implementation DemoViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
           }
    return self;
}

- (void)viewDidLoad
{
    currentIndex = 0;
    [super viewDidLoad];
    [self indexChange:1];
    minMoveWidth = self.view.frame.size.width /5.0f;
    
    	// Do any additional setup after loading the view.
}
-(PageView *) createView:(int)index
{
    NSMutableString *string = [NSMutableString string];
    for(int i=0;i<100;i++)
    {
        [string appendFormat:@"%d",index,nil];
    }
    PageView *vi = [[[PageView alloc] initWithFrame:self.view.bounds txt:string] autorelease];
    vi.hidden = YES;
    vi.delegate = self;
    return vi;
}
-(void) indexChange:(int)newIndex
{
    if(currentIndex == newIndex)
        return;
    if(currentIndex ==0)
    {
        [self setVisitPage:[self createView:newIndex]];
        [self.view addSubview:self.visitPage];
        self.visitPage.hidden = NO;
    }
    if(newIndex>0)
    {
        if (newIndex>=currentIndex)
        {
            
        
            if(self.prePage)
            {
                [self.prePage removeFromSuperview];
                
            }
            if(newIndex>1)
            {
                [self setPrePage:self.visitPage];
                [self setVisitPage:self.nextPage];
            }
            [self setNextPage:[self createView:newIndex+1]];
            [self.view insertSubview:self.nextPage  atIndex:0];
        }
        else
        {
            if(self.nextPage)
            {
                [self.nextPage removeFromSuperview];
            }
            [self setNextPage:self.visitPage];
            
            
            
            [self setVisitPage:self.prePage];
            if(newIndex > 1)
            {
                [self setPrePage:[self createView:newIndex-1]];
                
                [self.view addSubview:self.prePage];
            }
            else
            {
                [self setPrePage:nil];
            }
        }
        currentIndex = newIndex;
    }

}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    float x = [touch locationInView:self.view].x;
    startX = x;
    fromLeft = x< self.view.frame.size.width /2;
    tap = YES;
}
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if(fromLeft && currentIndex <=1)
        return;
    UITouch *touch = [touches anyObject];
    float x = [touch locationInView:self.view].x;
    //CGRect rect = _visitPage.frame;
    if (fromLeft) {
        //self.nextPage.hidden = NO;
        if(self.prePage)
        {
           self.prePage.hidden = NO;
           self.nextPage.hidden = YES;
           [_prePage move:x animation:NO];
        }
        
    }
    else
    {
        self.prePage.hidden = YES;
        self.nextPage.hidden = NO;
        [_visitPage move:x animation:NO];

    }
    tap = NO;
    
}
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    float x = [touch locationInView:self.view].x;
    
    if (!fromLeft && (tap||startX - x >minMoveWidth))
    {
        [self.view setUserInteractionEnabled:NO];
        self.nextPage.hidden = NO;
        nextPageIndex = currentIndex+1;
        [_visitPage move:-self.view.frame.size.width animation:YES];
    }
    else if(!fromLeft && startX - x <=minMoveWidth)
    {
        [self.view setUserInteractionEnabled:NO];
        [_visitPage move:self.view.frame.size.width animation:YES];
    }
    else if(currentIndex >1)
    {
        [self.view setUserInteractionEnabled:NO];
        _prePage.hidden = NO;
        if (fromLeft && (tap||x-  startX >minMoveWidth))
        {
            nextPageIndex = currentIndex-1;
            [_prePage move:self.view.frame.size.width animation:YES];
        }
        else if(fromLeft &&  x - startX<=minMoveWidth)
        {
            [_prePage move:-self.view.frame.size.width animation:YES];
        }
    }
}
-(void) didFinishMove
{
    [self indexChange:nextPageIndex];
    [self.view setUserInteractionEnabled:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
