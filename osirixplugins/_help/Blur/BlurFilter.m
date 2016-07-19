//
//  BlurFilter.m
//  Blur
//
//  Copyright (c) 2016 Sidd. All rights reserved.
//

#import "BlurFilter.h"

@implementation BlurFilter

- (void) initPlugin
{
}

- (long) filterImage:(NSString*) menuName
{
    NSArray *viewers = [[NSArray alloc] init];
    [viewers autorelease];
    viewers = [self viewerControllersList];
    ViewerController *viewer = [[ViewerController alloc] init];
    [viewer autorelease];
    viewer = [viewers objectAtIndex: 0];
    [viewers release];
    NSArray *pixList = [[NSArray alloc ] init];
    [pixList autorelease];
    pixList = [viewer pixList];
    DCMPix *pic = [[DCMPix alloc] init];
    [pic autorelease];
    pic = [pixList objectAtIndex:0];

    
    
    for (int k = 0; k < pixList.count; k++) {
        DCMPix *curPix = [[DCMPix alloc] init] ;
        [curPix autorelease];
        curPix = [pixList objectAtIndex: k];
        int maxX   = [curPix pheight];
        int maxY   = [curPix pwidth];
        float *fImage;
        fImage = [curPix fImage];
        
        for (int i = 1; i < maxX; i++) {
            for (int j = 1; j < maxY; j++) {
                if (i == 1 && j == 1) {
                    int pixSum =    fImage[i*(j+1)]     +
                                    fImage[(i+1)*(j+1)] +
                                    fImage[(i+1)*j];
                    int pixVal = pixSum/3;
                    fImage[i*j] = pixVal;
                }
                else if (i == maxX-1 && j == maxY-1) {
                    int pixSum =    fImage[i*(j-1)]     +
                                    fImage[(i-1)*(j-1)] +
                                    fImage[(i-1)*j];
                    int pixVal = pixSum/3;
                    fImage[i*j] = pixVal;
                }
                else if (i == 1) {
                    int pixSum =    fImage[i*(j-1)]     +
                                    fImage[i*(j+1)]     +
                                    fImage[(i+1)*(j+1)] +
                                    fImage[(i+1)*j]     +
                                    fImage[(i+1)*(j-1)];
                    int pixVal = pixSum/5;
                    fImage[i*j] = pixVal;
                }
                else if (j == 1) {
                    int pixSum =    fImage[(i-1)*j]     +
                                    fImage[(i+1)*j]     +
                                    fImage[(i+1)*(j+1)] +
                                    fImage[(i-1)*(j+1)] +
                                    fImage[i*(j+1)];
                    int pixVal = pixSum/5;
                    fImage[i*j] = pixVal;
                }
                else if (j == maxX-1){
                    int pixSum =    fImage[i*(j-1)]     +
                                    fImage[i*(j+1)]     +
                                    fImage[(i-1)*(j+1)] +
                                    fImage[(i-1)*j]     +
                                    fImage[(i-1)*(j-1)];
                    int pixVal = pixSum/5;
                    fImage[i*j] = pixVal;
                
                }
                else if (j == 1) {
                    int pixSum =    fImage[(i-1)*j]     +
                                    fImage[(i+1)*j]     +
                                    fImage[(i+1)*(j-1)] +
                                    fImage[(i-1)*(j-1)] +
                                    fImage[i*(j-1)];
                    int pixVal = pixSum/5;
                    fImage[i*j] = pixVal;
                }
                else {
                    int pixSum =    fImage[(i-1)*(j-1)] +
                                    fImage[(i-1)*j]     +
                                    fImage[(i-1)*(j+1)] +
                                    fImage[i*(j+1)]     +
                                    fImage[i*(j-1)]     +
                                    fImage[(i+1)*(j-1)] +
                                    fImage[(i+1)*j]     +
                                    fImage[(i+1)*(j+1)];
                    int pixVal = pixSum/8;
                    fImage[i*j] = pixVal;
                }
            }
        }
        
        
        
    }
	return 0;
}

@end
