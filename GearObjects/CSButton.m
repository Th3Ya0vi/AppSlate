//
//  CSButton.m
//  AppSlate
//
//  Created by 김태한 on 12. 01. 20..
//  Copyright (c) 2012년 ChocolateSoft. All rights reserved.
//

#import "CSButton.h"

@implementation CSButton

-(id) object
{
    return ((BButton*)csView);
}

//===========================================================================
#pragma mark -

-(void) setTintColor:(UIColor*)color
{
    if( [color isKindOfClass:[UIColor class]] )
        [((BButton*)csView).layer setBackgroundColor:color.CGColor];
}

-(UIColor*) getTintColor
{
    return [UIColor colorWithCGColor:((BButton*)csView).layer.backgroundColor];
}

-(void) setText:(NSString*)txt;
{
    if( [txt isKindOfClass:[NSString class]] )
        [((BButton*)csView) setTitle:txt];
    
    else if([txt isKindOfClass:[NSNumber class]] )
        [((BButton*)csView) setTitle:[((NSNumber*)txt) stringValue]];
}

-(NSString*) getText
{
    return ((BButton*)csView).btn.titleLabel.text;
}

-(void) setTextColor:(UIColor*)color
{
    if( [color isKindOfClass:[UIColor class]] )
        [((BButton*)csView) setTitleColor:color];
}

-(UIColor*) getTextColor
{
    return ((BButton*)csView).btn.titleLabel.textColor;
}

-(void) setFont:(UIFont*)font
{
    if( [font isKindOfClass:[UIFont class]] )
        [((BButton*)csView).btn.titleLabel setFont:font];
}

-(UIFont*) getFont
{
    return ((BButton*)csView).btn.titleLabel.font;
}

//===========================================================================

#pragma mark -

-(id) initGear
{
    if( ![super init] ) return nil;

    csView = [[BButton alloc] initWithFrame:CGRectMake(0, 0, 100, MINSIZE2)];
    [csView setUserInteractionEnabled:YES];

    csCode = CS_BUTTON;

    [((BButton*)csView) setTitle:@"Button"];
    [(BButton*)csView addTarget:self action:@selector(pushAction)];
    self.info = NSLocalizedString(@"Button", @"Button");

    DEFAULT_CENTER_D;
    NSDictionary *d0 = ALPHA_D;
    NSDictionary *d1 = MAKE_PROPERTY_D(@"Tint Color", P_COLOR, @selector(setTintColor:),@selector(getTintColor));
    NSDictionary *d2 = MAKE_PROPERTY_D(@"Button Text", P_TXT, @selector(setText:),@selector(getText));
    NSDictionary *d3 = MAKE_PROPERTY_D(@"Text Color", P_COLOR, @selector(setTextColor:),@selector(getTextColor));
    NSDictionary *d4 = MAKE_PROPERTY_D(@"Text Font", P_FONT, @selector(setFont:),@selector(getFont));

    pListArray = [NSArray arrayWithObjects:xc,yc,d0,d1,d2,d3,d4, nil];

    NSMutableDictionary MAKE_ACTION_D(@"Push", A_NUM, a1);
    actionArray = [NSArray arrayWithObjects:a1, nil];

    return self;
}

-(id)initWithCoder:(NSCoder *)decoder
{
    if( (self=[super initWithCoder:decoder]) ) {
        [(BButton*)csView addTarget:self action:@selector(pushAction)];
    }
    return self;
}

#pragma mark - Gear's Unique Actions

-(void) pushAction
{
    SEL act;
    NSNumber *nsMagicNum;

    // 3. Did Turn Off
    act = ((NSValue*)[(NSDictionary*)[actionArray objectAtIndex:0] objectForKey:@"selector"]).pointerValue;

    nsMagicNum = [((NSDictionary*)[actionArray objectAtIndex:0]) objectForKey:@"mNum"];
    CSGearObject *gObj = [USERCONTEXT getGearWithMagicNum:nsMagicNum.integerValue];
    
    if( nil != gObj ){
        if( [gObj respondsToSelector:act] )
            [gObj performSelector:act withObject:[NSNumber numberWithBool:YES]];
        else
            EXCLAMATION;
    }
}


@end