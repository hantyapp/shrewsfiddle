// Shrews fiddle
// Units = mm
// all circle sizes are diamter
$fa=3; // set this to a lowe number for better edges as the cost of rendering time

// Variables
materialWidth=5; // The sheet thickness Not Actuall relevent
numScrewsAroundNeck=12; // How many screws to put around each cuff
numScrewsAroundWrist=6; // How many screws to put around each cuff
wristSize=58; // The diameter of the wrist cuffs
wristDistance=30; // The distance from the edges of the wrists
neckSize=135; // The diameter of the neck cuff
collarWidth=20;//wristDistance * 2; // The collar width, making it wristDistance * 2 will make the screw holes meet, and looks nice
midLen=160; // The distance from the edge of the necck collar. to the first wrist collar
screwDiameter=4; // The diameter of the screws to be used
screwSpacingOffsetAngle=45; // Where to offset the orgin of the screw from
hingeDiameter=screwDiameter; // Diamter of the hinge screw;
lockDiameter=6; // Diameter of the lock hole, usually the padlock shank diamter;
layerSpacing=24; // How much spce to leave between each layer in the final render
splitSpacing=2; // How much space to leave between each half

// Calculated dimensions
totalLen = collarWidth + neckSize + collarWidth + midLen + collarWidth + wristSize + wristDistance + collarWidth;


/*
 * h = Hinge
 * L = Left
 * l = Lip
 * L = Left
 * t = Tab
 * L = Left
 */

hLlLtL();

translate([0,neckSize+collarWidth*2 + (layerSpacing/2),0])
    {
    //rotate([180,0,0])
    //{
        hRlRtR();
    //}
}

translate([0,(neckSize+collarWidth*2 + (layerSpacing/2))*2,0])
{
    rotate([0,0,0])
    {
        hLlLtL();
    }
}
module hLlLtL()
{
    
    translate([0,-(splitSpacing/2),0])
    {
        difference()
        {
            union()
            {
                baseHalf("right");
                hingeTab();
                lockTab();
                midTab();
            }
            union()
            {
                hingeHole();
                lockHole();
            }
        }
    }
    translate([0,(splitSpacing/2),0])
    {
        difference()
        {
            baseHalf("left");
            union()
            {
                hingeClean();
                hingeTab();
                lockClean();
                lockTab();
                midTab();
            }
        }
    }
}

module hLlLtR()
{
    translate([0,-(splitSpacing/2),0])
    {
        difference()
        {
            union()
            {
                baseHalf("right");
                hingeTab();
                lockTab();
            }
            union()
            {
                hingeHole();
                lockHole();
                midTab();
            }
        }
    }
    translate([0,(splitSpacing/2),0])
    {
        difference()
        {
            union()
            {
                baseHalf("left");
                midTab();
            }
            union()
            {
                hingeClean();
                hingeTab();
                lockClean();
                lockTab();
            }
        }
    }
}

module hLlRtR()
{
    translate([0,-(splitSpacing/2),0])
    {
        difference()
        {
            union()
            {
                baseHalf("right");
                hingeTab();
            }
            union()
            {
                hingeHole();
                lockTab();
                midTab();
                lockCleanB();
            }
        }
    }
    translate([0,(splitSpacing/2),0])
    {
        difference()
        {
            union()
            {
                baseHalf("left");
                midTab();
                lockTab();
                hingeClean();
                hingeTab();
            }
            union()
            {
                
                
                lockHole();
            }
        }
    }
}

module hRlRtR()
{    
    translate([0,-(splitSpacing/2),0])
    {
        difference()
        {
            union()
            {
                baseHalf("right");
            }
            union()
            {
                hingeCleanB();
                hingeTab();
                lockTab();
                midTab();
                lockCleanB();
            }
        }
    }
    translate([0,(splitSpacing/2),0])
    {
        difference()
        {
            union()
            {
                baseHalf("left");
                midTab();
                lockTab();
                hingeTab();
            }
            union()
            {
                hingeHole();
                lockHole();
            }
        }
    }
}

module hingeHole()
{
    translate([-(neckSize/2 + collarWidth/2),0,0])
    {
        circle(d=hingeDiameter);
    }
}

module lockHole()
{
    translate([(neckSize/2 + collarWidth + midLen + collarWidth + (wristSize * 2) + wristDistance + collarWidth*2),0,0])
    {
        circle(d=lockDiameter);
    }
}

module baseHalf(side)
{
    difference()
    {
        baseShape();
        cubeX = neckSize + (wristSize*2) + midLen + (collarWidth*6) + wristDistance;
        cubeY = neckSize/2+collarWidth;
        transY = side=="left" ? cubeY : 0;
        translate([-(neckSize/2 + collarWidth),-transY,0])
        {
            square([cubeX,cubeY]);
        }
    }
}


module hingeTab()
{
    translate([-(neckSize/2 + collarWidth/2),0,0])
    {
        circle(d=collarWidth);
    }
}

module hingeClean()
{
    translate([-(neckSize/2 + collarWidth),0,0])
    {
        square([collarWidth*2, collarWidth/3.5]);
    }
}

module hingeCleanB()
{
    translate([-(neckSize/2 + collarWidth),-3,0])
    {
        square([collarWidth*2, collarWidth/3.5]);
    }
}

module lockTab()
{
    translate([(neckSize/2 + collarWidth + midLen + collarWidth + (wristSize * 2) + wristDistance + collarWidth*2),0,0])
    {
        circle(d=collarWidth);
    }
}

module lockClean()
{
    translate([(neckSize/2 + collarWidth + midLen + collarWidth + (wristSize * 2) + wristDistance + collarWidth),0,0])
    {
        square([collarWidth*1.5, collarWidth/3]);
    }
}

module lockCleanB()
{
    translate([(neckSize/2 + collarWidth + midLen + collarWidth + (wristSize * 2) + wristDistance + collarWidth),-collarWidth/3.5,0])
    {
        square([collarWidth*1.5, collarWidth/3]);
    }
}

module midTab()
{
    translate([(neckSize/2 + collarWidth/2 + midLen/2),0,0])
    {
        scale([3,.4,1])
        {
            circle( d=collarWidth);
        }
    }
}
module baseShape()
{ 
    difference()
    {
        collar();
        innerSub();
    }
}

module innerSub()
{
    translate([0,0,0])
    {
        // Draw neck
        neckHole(neckSize);
        //screwHoles(neckSize, collarWidth, 10, screwDiameter);
        translate([(neckSize/2)+(collarWidth*2)+wristSize+wristDistance+midLen,0,0])
        {
            // Draw Wrist
            wristHoles(wristSize, wristDistance);
        }
        // Create Wrap
        // Subtract holes from base
    }
}

module collar()
{
    hull(){
        translate([0,0,0])
        {
            neckCollar (neckSize, collarWidth) ;
            translate([(neckSize/2)+(collarWidth*2)+wristSize+wristDistance+midLen,0,0])
            {
                wristCollar (wristSize, wristDistance, collarWidth);
            }
        }
    }
}

module neckHole (neckSize) 
{
    circle( d=neckSize);
    screwHoles(neckSize/2, collarWidth, numScrewsAroundNeck, screwDiameter);
}

module neckCollar (neckSize, collarWidth) 
{
    circle( d=neckSize+collarWidth*2);
}

module wristHoles ()
{
    translate([0 - (wristDistance + (wristSize / 2)),0,0])
    {
        circle( d=wristSize);
        screwHoles(wristSize / 2, collarWidth, numScrewsAroundWrist, screwDiameter);
    }
    translate([wristDistance + (wristSize / 2),0,0])
    {
        circle( d=wristSize);
        screwHoles(wristSize / 2, collarWidth, numScrewsAroundWrist, screwDiameter);
    }
}

module wristCollar ()
{
    translate([0 - (wristDistance + (wristSize / 2)),0,0])
    {
        circle( d=wristSize+collarWidth*2);
    }
    translate([wristDistance + (wristSize / 2),0,0])
    {
        circle( d=wristSize+collarWidth*2);
    }
}

module screwHoles (holeDiameter, collarWidth, countOfHoles, screwDiameter)
{
    rotate([0,0,screwSpacingOffsetAngle])
    {
        pathRadius = holeDiameter + (collarWidth / 2);
        for (i=[1:countOfHoles])  {
            translate([pathRadius*cos(i*(360/countOfHoles)),pathRadius*sin(i*(360/countOfHoles)),0]) circle(d=screwDiameter);
            }
        }
}