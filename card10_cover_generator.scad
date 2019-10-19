/*
          
          A random cover generator for the CARD10 badge!
          ==============================================
          
          V3.2
          
          Cover features:
          ---------------
        * more variations possible than you'll ever need!!!
        * buttons become much more usable as they get a bigger surface
        * the cover can be clipped onto the badge - there are no tools required to change the cover
        * you can add a piece of clear plastic (e.g. cutout from a cheese packaging) as display protection 
        * the model has no overhangs, thus it is very easy to print (except if you turn side led's on)
        * you can turn off the randomization and generate exactly the cover that YOU want!
        
        
          How to use:
          -----------
        * open this code in openSCAD (download from https://www.openscad.org/)
        * specify whether you want a model with wristband or without (line 82) / the option
          with wristband also adds the wristband mounts to the watch cover
        * if you want to print a wristband, specify the sircumference of your wrist in line 107
        * specify from line 69 on which parts you want to generate 
        * select in line 68 if you want to have the parts oriented ready for print or in the way they will be
          assembled later
        * [optional]: adjust settings below in the section 'CUSTOMIZE YOUR COVER BY ADJUSTING VALUES BELOW:'
        * hit the render button in openSCAD (the button above the code with the hourglass & the cube)
        * hit the .stl export button right next to the render button
        * print your .stl model!
        
        
          Printing instructions on an FDM printer:
          ----------------------------------------
        * print upside down without support out of PLA
        * recommended slicer settings: 
            0.2mm layer height
            0.4mm wall thickness / 1 wall
            100% infill 
            0.4mm extruder
  
  
          Assembly instructions:
          ----------------------
        * clean up the print with a small utility knife
        * [optional]: cut a 14mm x 30mm piece of clear plastic as display protection (e.g. from a pet-bottle) 
                      and place it inside the display cutout 
        * If you printed a wristband: Glue FClip on the end of the bottom wristband (e.g. with superglue)
        * connect MClip with the top wristband (with a paper clip as axle)
        * connect both wristbands to the cover (with paper clips as axles)
        * if you printed a bottom: Unscrew the four screws on the bottom of the Card10, 
          remove the stainless steel electrodes, add the bottom piece, add the electrodes, 
          add the screws again.
        * clip the cover onto your card10 badge
        * print another cover for your friends
          
  
          License:
          ----------------------------------------------------------------------------
          "THE TSCHUNK-WARE LICENSE" (Revision 23):
          Niklas Roy wrote this file. As long as you retain this notice you
          can do whatever you want with this stuff. If we meet some day, and you think
          this stuff is worth it, you can buy me a tschunk in return
          ----------------------------------------------------------------------------
*/
echo("///////////////  CARD10 COVER GENERATOR  ///////////////");

//generate random seed number for all random generators

rndSeed=round(rands(0,5000,1)[0]); 

echo("Generating cover #");
echo(rndSeed);

none=0;half=1;full=2;normal=0;tiny=1;hidden=1;
visible=2;protected=3;protectedX=4;
wide=32;standard=25;
plain=0;  hexagons=1; pacman=2; heartbeat=3; flash=4;
function maybe()=round(rands(0,1,1,seed_value=rndSeed)[0])==1;
function rnd(x) =round(rands(0,x,1,seed_value=rndSeed)[0]);

//////////////////////////////////////////////////////////

// display all parts either in optimized print orientation 
// [ideal for exporting stl's for fdm prints] or in assembly view

// %% 'Print view' bool false 
printOrientation=false;

// select which parts you want to generate
// %% 'Generate watch cover' bool true 
generateCover       = true;
// %% 'Generate bottom plate' bool false 
generateBottom      = true;
// %% 'Generate wristband top' bool true 
generateBeltTop     = true;
// %% 'Generate wristband bottom' bool true 
generateBeltBottom  = true;
// %% 'Generate F clip' bool true 
generateFClip       = true; 
// %% 'Generate M clip' bool true 
generateMClip       = true;



// ***********************************************
// CUSTOMIZE YOUR COVER BY ADJUSTING VALUES BELOW:
// ***********************************************

// do you want to connect a 3D-printed wristband to your case? // this toggles the belt mounts on the case
// %% 'Generate wristband' bool true 
wristBand           = false;

// wrist band width - options are 'standard' and 'wide'
// %% 'Wristband width' select (25='Standard',32='Wide') 
beltWidth           =  standard; 

// plain', 'pacman', 'hexagons', 'heartbeat', 'flash'
// %% 'Wristband style' select (0='Plain',1='Hexagons',2='Pacman',3='Heartbeat',4='Flash') 
beltStyle           = rnd(4);//flash;


//circumference of the wrist in mm
// %% 'Wrist circumference' int (min=140,max=250,default=190)
wristCircumference  = 190;

// adjust diffusion layer above leds - options are:
// 'full' [full diffusion - led's are invisible when turned off]
// 'half' [only diffusion at bottom ...
//           ... led's won't blind you when you look at the display]
// 'none' [led's remain fully open - you get top brightness!]
// %% 'LED diffusor' select (0='None',1='Half',2='Full')
ledDiffusor         = rnd(2);//half;  

// toggle sideways visibility of top row led's 
// - if set to 'true', you'll have to print with minimal overhangs!
// %% 'LED top side cutout' bool true 
sideLEDs            = maybe();//true; 

// add protruding led protector on top
// %% 'Extended LED bar' bool true 
extendedLEDs        = maybe();//true;

// toggle cutout for visibility of personal state led
// %% 'Personal State LED visibility' bool true 
personalStateLED    = maybe();//true;  

// toggle visibility of left led rocket
// %% 'Left rocket visibility' bool true 
showLeftRocket      = maybe();//false;

// toggle visibility of right led rocket
// %% 'Right rocket visibility' bool true 
showRightRocket     = maybe();//true;  

// toggle visibility of top led rocket
// %% 'Top rocket visibility' bool true 
showTopRocket       = maybe();//false;  

// toggle cutout for sewable connectors
// %% 'GPIO accessibility' bool true 
GPIOaccess          = maybe();//true;  

// toggle bevels - [no bevels make the cover look more blocky]
// %% 'Bevels' bool true 
bevels              = maybe();//false; 

// toggle size of on-off-home button. options are:
// - 'normal' [explains itself]
// - 'tiny'   [tiny button in order to avoid accidental turn-off]

// %% 'Home button cover' select (0='Normal',1='Tiny') 
homeButtonCover     = normal;  

// toggle whether buttons have a riffled surface 
// - otherwise button surface is flat
// %% 'Riffled buttons' bool true 
riffledButtons      = maybe();//true;  

// cut out a small rectangle above the physical button in order to 
// make silver button case visible. blingbling!
// %% 'Shiny button cutouts' bool true 
shinyButtons        = maybe();//false;

// show more of the display module than just the screen area
// - when false, ccc is shown on the left side of the screen area
// %% 'Large screen cutout' bool true 
largeScreen         = maybe();//false;  

// toggle visibility of CARD10 logo   
// %% 'Logo visibility' bool true    
showLogo            = maybe();//false;  

// set screw style. options are 'hidden', 'visible', 'protected' or 'protectedX'
// %% 'Wristband style' select (1='Hidden',2='Visible',3='Protected',4='X-Protected') 
screwStyle          = rnd(3)+1;//protected; 

// embossed rings around screws?
// %% 'Screw visibility' bool true 
screwRings          = maybe();//false; 

// a little useless grill on top of the spikes???
// %% 'Useless grill' bool true 
spikeGrill          = maybe();//true;

//make multicolor prints by changing the filament after the first layer was printed - can be also just set to true if you want to have a bit more texture in the first layer
// %% 'First layer texture' bool true 
firstLayerDeco=maybe();//;
    
// END OF CUSTOMIZATION!

//////////////////////////////////////////////////////////


beltLengthTop       =(wristCircumference-90)/2;//N:50 K:40
beltThickness=0.45;
springWidth=.7; // thickness of button springs. default=.7
offSet=(beltWidth-20)/2;
extra=.3;                 
corner=3.1;              
width=45;              
height=35.5;                
depth=1;                    
screwHead=4.2;  
fundamentalHeight=38;
fundamentalWidth=45;
    
module bottom(){
    echo("generate bottom");
    color("Pink")difference(){
        bottomThickness=.5;
        
        // basic outer shape
        union(){
            translate([0,0,-.5-(bottomThickness/2)])cube([width+3,height+3,1+bottomThickness],center=true);
            
            //fill-in below right and select button
            translate([width/2+.9,-5.8,1.75])cube([1.2,9.5,6],center=true);
            
            //fill-in below left button
            translate([-width/2-.9,-7.75,1.75])cube([1.2,3.5,6],center=true);
            
            
        }

        // fundamental board basic shape (+extra on top and bottom)
        hull(){
            translate([width/2-corner+extra,fundamentalHeight/2-corner+2,0])cylinder($fn=24,r=corner,h=2,center=true); 
            translate([-width/2+corner-extra,fundamentalHeight/2-corner+2,0])cylinder($fn=24,r=corner,h=2,center=true); 
            translate([-width/2+corner-extra,-fundamentalHeight/2+corner-2,0])cylinder($fn=24,r=corner,h=2,center=true); 
            translate([width/2-corner+extra,-fundamentalHeight/2+corner-2,0]) cylinder($fn=24,r=corner,h=2,center=true); 
        }
        
        // chopped off corners
        translate([width/2+2,height/2+2,1]){
            rotate([0,0,45]) cube([6,10,15],center=true);
        }
        translate([-width/2-2,height/2+2,1]){
            rotate([0,0,-45])cube([6,10,15],center=true);
        }
        translate([width/2+2,-height/2-2,1]){
            rotate([0,0,-45])cube([6,10,15],center=true);
        }
        translate([-width/2-2,-height/2-2,1]){
            rotate([0,0,45])cube([6,10,15],center=true);
        }
        
        
        //screwdriver opening gap
        translate([-width/2-.9,-2,1.25])cube([3,4,20],center=true);
        
        //screws
        translate([width/2-3,height/2-3.25,-5])cylinder($fn=24,d=2.5,h=30,center=false); 
        translate([-width/2+3,height/2-3.25,-5])cylinder($fn=24,d=2.5,h=30,center=false); 
        translate([-width/2+3,-height/2+3.25,-5])cylinder($fn=24,d=2.5,h=30,center=false); 
        translate([width/2-3,-height/2+3.25,-5])cylinder($fn=24,d=2.5,h=30,center=false); 
    }
}

// corner cutouts bottom piece
module cornerCutout(){
        hull(){
            translate([width/2,fundamentalHeight/2-3,0])cube([19,7,15],center=true); 
            translate([width/2+3,fundamentalHeight/2-4,0])cube([19,7,15],center=true); 
        }
        translate([width/2-8,fundamentalHeight/2+1,0])rotate([0,0,45])cube([5,5,25],true);
    
}

  
// wristband decoration: flash
module flashDeco(){
difference(){color("Black")translate([0,50,0])cube([40,130,10],true);
for(i=[10:40:100]){translate([0,i,0])union()rotate([0,0,8])translate([0,-12.5,0]){
hull(){
    translate([4,27,0])cube([.1,.1,20],true);
    translate([-2,14,0])cube([5,.1,20],true);
}
hull(){
    translate([1.3,16.5,0])cube([5,.1,20],true);
    translate([-1.3,8.5,0])cube([5,.1,20],true);
}
hull(){
    translate([2,11,0])cube([5,.1,20],true);
    translate([-4,-2,0])cube([.1,.1,20],true);
}}}}}        
                

                
                    
module pacmanDeco(){
    echo("generate pacman");
    difference(){
        cube([150,250,50],true);
        //pacman
        difference(){
            cylinder(d=15,h=20,center=true,$fn=90);
            translate([0,7,-1])rotate([0,0,45])cube([10,10,23],true);
        }
        //pills
        for (i=[7:10:90])translate([0,i,-1])cylinder(d=3,h=20,center=true,$fn=12);
        //ghost
        gy=-50;
        translate([0,190,0]){rotate([0,0,180]){scale([.75,.9,1]){
            difference(){
                waveShift=2;
                union(){
                    //top half circle
                    translate([-3.5,150+gy,0])cylinder(d=14,h=15,center=true,$fn=90); 
                    //bottom rect & half wave
                    difference(){
                        translate([2,150+gy,0])cube([10,14,15],true);
                        for (i=[0+waveShift:6:20])translate([7,139+i+gy,-1])cylinder(d=3,h=18,center=true,$fn=12);
                    }
                    //bottom other half wave
                    for (i=[0+waveShift:6:14])translate([7,142+i+gy,0])cylinder(d=3,h=15,center=true,$fn=12);
                }
                //cutoof
                translate([2,136+gy,-1])cube([18,14,18],true);
                translate([2,164+gy,-1])cube([18,14,18],true);
            }
        }
    }}}
}
    



module hexDeco(){
    echo("generate hex");
    //hex
    difference(){
        translate([-30,-300,-10])cube([60,600,25]);
        for(i=[-248.8:9.5:250])translate([0,i,-10])rotate([0,0,0])cylinder($fn=6,h=20, r=4.7, center=true);
        for(i=[-244:9.5:250])translate([8.3,i,-10])rotate([0,0,0])cylinder($fn=6,h=20, r=4.7, center=true);
        for(i=[-244:9.5:250])translate([-8.3,i,-10])rotate([0,0,0])cylinder($fn=6,h=20, r=4.7, center=true);
    }
}
    

module heartbeatDeco(){
    echo("generate heartbeat");
    $fn=6;
    difference(){
    echo("generating heartbeat pattern...");
    translate([-30,-300,-10])cube([60,600,25]);
       rotate([0,0,90])for(i=[0:100:800])scale([.25,.25,20])translate([i-435,0,-.5]){
            echo(i);
   
            hull(){translate([10,0,0])cylinder(d=5);translate([15,5,0])cylinder(d=5);}
            hull(){translate([15,5,0])cylinder(d=5);translate([20,0,0])cylinder(d=5);}
            hull(){translate([20,0,0])cylinder(d=5);translate([25,0,0])cylinder(d=5);}
            hull(){translate([25,0,0])cylinder(d=5);translate([31,25,0])cylinder(d=5);}
            hull(){translate([31,25,0])cylinder(d=5);translate([34,-25,0])cylinder(d=5);}
            hull(){translate([34,-25,0])cylinder(d=5);translate([40,0,0])cylinder(d=5);}
            hull(){translate([40,0,0])cylinder(d=5);translate([45,0,0])cylinder(d=5);}
            hull(){translate([45,0,0])cylinder(d=5);translate([51,7,0])cylinder(d=5);}
            hull(){translate([51,7,0])cylinder(d=5);translate([57,0,0])cylinder(d=5);}
            hull(){translate([65,0,0])cylinder(d=5);translate([102,0,0])cylinder(d=5);}
        }
    }
}
    


    
module beltHalf(){
    echo("generate half belt");
    difference(){
        union(){
        translate([0,21,-5])cube([16,6,5]);//connection body
        //trapezoidal adaptor
        hull(){ 
                translate([0,21,-5])cube([16,6,1]);//watch end
                translate([0,31,-5])cube([beltWidth/2,2,        beltThickness]);//belt end
            }
        }
        //cutoffs
        
        //center dent
        hull(){
        translate([-1,21,-1.2])cube([8,4,8.5]);
        translate([-1,21,0])cube([10,4,8.5]);
        }
        //glue drop container
        translate([-1,21.5,-3.5])cube([3,3,5]);
        //pivot hole
        translate([0,22.5,-2.5])cube([50,1.2,1.2],center=true);
        //chamfer
        hull(){
        translate([-1,27,-4])rotate([30,0,0])cube([18,5,7]);
        translate([-1,25.5,-4])rotate([30,0,0])cube([18,5,7]);
        }
        //chamfer inside bottom
        translate([-1,18.7,-8])rotate([30,0,0])cube([18,4,6]);
        //chamfer inside top
        translate([-1,18.7,-2])rotate([30,0,0])cube([18,6,6]); 
        //first layer decoration
        if(firstLayerDeco){
             for(i = [-11.52 : 2.89 : 11.52])hull(){
                 translate([i,32,.3])cube([2,10,10],center=true);  
                 translate([i,27,2])cube([2,10,1],center=true);  
                 }   
            }
    }
   
    //belt top
    translate([0,33,-5])cube([beltWidth/2,beltLengthTop,beltThickness]);
   
}


module halfHolder(){
    echo("generate half clipf");

    color("Gold",1){
        difference(){
            translate([0,13,-1]){
                difference(){
                    // main body female connector
                    translate([0,0,-.3])cube([11.6+offSet,22,5.3]); 
                    // cutout center pole
                    translate([-1,-1,1])cube([4.3+offSet,50,2.7]);
                    // funnel into center hole
                    hull(){ 
                        // wide
                        translate([-1,-1,.5])cube([4.7+offSet,1.5,3.7]);
                        
                        // small
                        translate([-1,2,1])cube([4.3+offSet,1,2.7]);
                    }
                    
                    // cutout spring slot
                    translate([4.7+offSet,-1,1])cube([5.2,50,2.7]);
                    
                    // cutout spring slot funnel
                    hull(){
                        translate([4.3+offSet,-1,.5])cube([6.2,1.5,3.7]);
                        translate([4.7+offSet,2,1])cube([5.2,1,2.7]);
                    }
                    // cutout locking triangle
                    translate([4.7+offSet,11.7,1])cube([20,50,5]);
                    
                    // side cutoff belt width
                    translate([10+offSet,11.7,-1])cube([20,50,5]); 
                        
                    // side cutout finger pusher
                    translate([8.5+offSet,11.7,-10])cube([4,20,80]);
                    
                    // cutout glueing area
                    translate([-1,16.5,1])cube([20,50,5]);
                }
            }
            //------------------ cutoffs:
            //locking triangle
            translate([13+offSet,20,-20])rotate([0,0,29])cube([4,8,90], center=false);
   
            //chamfer top side    
         if (bevels)translate([10+offSet,12.9,4.5])rotate([0,45,0])cube([3,50,4]);
            //chamfer bottom side 
           if (bevels)translate([10+offSet,12.9,-2-beltThickness])rotate([0,45,0])cube([3,50,4]); 
            //chamfer bottom side - top/belt 
            translate([8.5+offSet,25,-2-beltThickness])rotate([0,45,0])cube([3,50,4]); 
            //chamfer bottom top  
            translate([-1,42.3,-3-beltThickness])rotate([45,0,0])cube([50,2,2]);
           
           //locking triangle
            translate([13+offSet,29,-20])rotate([0,0,45])cube([12,12,90], center=false);
             
        }
    }
}
module halfClip () {
    echo("generate half clipm");
    color( "DeepPink", 1.0 ) {                              //half inner clip
        difference(){
            union(){
                translate([10+offSet,0,0])cube([1.6,13,3.7], center=false);         //side block
                //spring
                translate([8+offSet,13,0]){
                    cube([1.6,12,3], center=false);         
                    translate([0,-1.4,0])rotate([0,0,45])cube([2,2,3], center=false);         //spring
                        
                    
                    translate([0,12,0]){                    //locking triangle
                        difference(){
                            cube([3,9,3], center=false);
                            translate([3,7,-1])rotate([0,0,29])cube([5,8,6], center=false);
                            translate([1.5,-.25,-1])rotate([0,0,-10])cube([5,.5,6], center=false); 
                        }
                    }
                }
                                          
                cube([10+offSet,13,3.7], center=false);//bottom / belt connection
              
                translate([0,13,0]){
                    difference(){
                        cube([3+offSet,20.5,3], center=false);           //center pole
                        translate([3+offSet,17,-1])rotate([0,0,20])cube([3,5,8]); //cut off top side   
                    }
                }
            }
            //cut off top / top
            translate([-1,30,2.5])rotate([-10,0,0])cube([18+offSet,5,8]);
            // flatten top
            translate([-1,13,2.1])cube([20,30,10],center=false);
           //chamfer bottom side corner
            translate([10+offSet,-1,-1])rotate([0,0,-45])cube([2,7,6]);     
            // cutout hinge
            translate([-1,-1,-10])cube([beltWidth/2-3,6,20],center=false);
            //pivot hole  
            translate([0,2,1.5])cube([50,1.2,1.2],center=true);
            
        }
    }
}
module beltBlock(){
    echo("generate belt block");
    //belt block top // supports which hold the pivot holes for mounting a belt
    difference(){
        translate([16.3,16.8,-4])cube([4.5,8.2,7]); //hinge mount main
        translate([15.3,16.2,-6])cube([6.5,2,7]); //inner space cutout
        translate([15.3,25,-2])rotate([30,0,0])cube([6.5,20,20]); //chamfer top
        translate([15.3,25,-9])rotate([30,0,0])cube([6.5,10,5]); //chamfer bottom
        translate([0,22.5,-2.5])cube([50,1.2,1.2],center=true);//pivot hole top
    // chamfer side triangular 
        if(bevels)translate([33,0,-9])rotate([0,0,30])cube([30,32,25]); 
            
        //first layer deco
        difference(){
        if (firstLayerDeco)translate([16.8,16.8,2.7])cube([3.5,4.7,.43]); //hinge mount main
        if(bevels)translate([32.4,0,-9])rotate([0,0,30])cube([35,37,25]); 
        }
            
    }
}

module watchBody(){
    echo("generate watch body");

    if (wristBand)beltBlocks();
    difference(){
        union(){
            difference(){
                // outer shell
                difference(){
                    union(){// main body
                        hull(){ 
                            translate([0,0,2.5])cube([width+3,height+3,3],center=true);
                            translate([0,0,-4.25])cube([width+3,height+3,3],center=true);
                        }
                        if(extendedLEDs==true){ // extended led block
                            hull(){ 
                                // top
                                translate([0,height/2+2,3])cube([32.6,2,3],center=true);
                                // bottom
                                translate([0,height/2,-1.3])cube([32.6,2,.1],center=true);
                            }
                        }
                    }
                    
                    //first layer deco /d:2.2 h:.9
                    if(firstLayerDeco){
                        
                        //arrow
                        if(!spikeGrill){
                            translate([-12.5,10,3.2])cube([3,4,1],true);
                            translate([-12.5,13,3.2])scale([1,.8,1])rotate([0,0,-30])cylinder($fn=3,h=1,d=6.5,center=true);
                            if(!showTopRocket){
                                translate([-5,10,3.2])cube([3,4,1],true);
                                translate([-5,13,3.2])scale([1,.8,1])rotate([0,0,-30])cylinder($fn=3,h=1,d=6.5,center=true);
                            }
                        }
                        
                        //stripes next to display
                        difference(){
                        union()for (i=[6.3:-2.28:-6]){
                        translate([0,i,3.2])cube([44.5,.9,1],true);
                        }
                        //cutouts
                        //display
                        translate([-.2,.625,0])cube([29,20,16],true); 
                       if(largeScreen && !showLeftRocket){
                            translate([-2,.625,0])cube([29,30,16],true); 
                        }
                        if (shinyButtons){
                        translate([-width/2+1,height/2-10,2])cube([6,6.5,16],center=true);//home
                        translate([width/2-1,-height/2+9,2])cube([6,6.5,16],center=true);//right
                        translate([-width/2+1,-height/2+10,2])cube([6,6.5,16],center=true);//left
                        translate([width/2-1,-height/2+15,2])cube([6,6.5,16],center=true);//select
                        }else{
                            
                        translate([-width/2-2,height/2-10,2])cube([6,6.5,16],center=true);//home
                        translate([width/2-1,-height/2+9,2])cube([6,6.5,16],center=true);//right
                        translate([-width/2-2,-height/2+10,2])cube([6,6.5,16],center=true);//left
                        translate([width/2+1.7,-height/2+15,2])cube([6,6.5,16],center=true);//select
                            }
                        if(showLeftRocket){translate([-11,1,0])cube([17,20,16],true);}
                        if(showRightRocket){translate([11,-2,0])cube([17,10,16],true);}
                    
                    
                        }
              
                    }
                    
                    // chopped off corners
                    translate([width/2+2,height/2+2,1]){
                        rotate([0,0,45]) cube([6,10,15],center=true);
                    }
                    translate([-width/2-2,height/2+2,1]){
                        rotate([0,0,-45])cube([6,10,15],center=true);
                    }
                    translate([width/2+2,-height/2-2,1]){
                        rotate([0,0,-45])cube([6,10,15],center=true);
                    }
                    translate([-width/2-2,-height/2-2,1]){
                        rotate([0,0,45])cube([6,10,15],center=true);
                    }
                    
                    // bevels
                    if(bevels==true){
                        translate([0,-height/2-5,4]){ // bottom
                            rotate([60,0,0])cube([60,10,10],center=true);
                            
                        }
                        
                        translate([-26.3,height/2+5,4]){ // top-left
                            rotate([30,0,0])cube([20,10,10],center=true);
                            
                        }
                        translate([26.3,height/2+5,4]){ // top-right
                            rotate([30,0,0])cube([20,10,10],center=true);
                            
                            translate([1.36,-3,0]){     // top right corner
                                rotate([0,0,-45]){
                                    rotate([30,0,0])cube([12,13,17],center=true);
                                }
                            }
                            translate([1.2,-.5,0]){     // right-top
                                rotate([0,0,90]){
                                    rotate([-30,1,0]){
                                        hull(){
                                            translate([-9,-5,0])cube([28,.1,10],center=true);
                                            translate([1.5,5,0])cube([28,.1,10],center=true);
                                        }
                                    }
                                }
                            }

                        }
                        
                    }
                    
                    //usb-c cutout
                    translate([-15,height/2-11,-5])cube([20,10,6],center=true);
                    
                    
                    //cutout between right and select button
                    translate([15,-5,-3])cube([20,8,7],center=true);
                    
                    
                    
                }

                union(){
                    // harmonic board basic shape
                    hull(){
                        translate([width/2-corner+extra,height/2-corner+extra,0])cylinder($fn=24,r=corner,h=depth,center=true); 
                        translate([-width/2+corner-extra,height/2-corner+extra,0])cylinder($fn=24,r=corner,h=depth,center=true); 
                        translate([-width/2+corner-extra,-height/2+corner-extra,0])cylinder($fn=24,r=corner,h=depth,center=true); 
                        translate([width/2-corner+extra,-height/2+corner-extra,0]) cylinder($fn=24,r=corner,h=depth,center=true); 
                        translate([0,0,-10]){ // lowered copy of the board
                            translate([width/2-corner+extra,height/2-corner+extra,0])cylinder($fn=24,r=corner,h=depth,center=true); 
                            translate([-width/2+corner-extra,height/2-corner+extra,0])cylinder($fn=24,r=corner,h=depth,center=true); 
                            translate([-width/2+corner-extra,-height/2+corner-extra,0])cylinder($fn=24,r=corner,h=depth,center=true); 
                            translate([width/2-corner+extra,-height/2+corner-extra,0])cylinder($fn=24,r=corner,h=depth,center=true); 
                            
                        }
                    }
                    
                    // show screws
                    if(screwStyle>1){
                        translate([width/2-3,height/2-3.25,.4])cylinder($fn=24,d1=screwHead,d2=screwHead+.5,h=3,center=false); 
                        translate([-width/2+3,height/2-3.25,.4])cylinder($fn=24,d1=screwHead,d2=screwHead+.5,h=3,center=false); 
                        translate([-width/2+3,-height/2+3.25,.4])cylinder($fn=24,d1=screwHead,d2=screwHead+.5,h=3,center=false); 
                        translate([width/2-3,-height/2+3.25,.4])cylinder($fn=24,d1=screwHead,d2=screwHead+.5,h=3,center=false); 
                                     
                   }else{
                   // hide screws
                        translate([width/2-3,height/2-3.25,-.75])cylinder($fn=24,d=screwHead,,h=2.5,center=false); 
                        
                        translate([-width/2+3,height/2-3.25,-.75])cylinder($fn=24,d=screwHead,,h=2.5,center=false); 
                        
                        translate([-width/2+3,-height/2+3.25,-.75])cylinder($fn=24,d=screwHead,,h=2.5,center=false); 
                        
                        translate([width/2-3,-height/2+3.25,-.75])cylinder($fn=24,d=screwHead,,h=2.5,center=false); 
                        
                    }
                    

                    
                    // personal state led
                    if(personalStateLED==true)translate([-15.75,19,-4])cube([2.5,3,7],center=true);
                    
                    
                    // leds
                    translate([0,height/2-1,.9]){
                        translate([0,-.3,-3])cube([32,2.4,7],center=true); // cutout for physical led's on board
                        for(led = [-14.5 : 2.89 : 14.5]){ // cutouts for led light channels
                            hull(){
                                if(extendedLEDs==true){
                                    translate([led,1.6,-.4])cube([2,2,.1],center=true);
                                    translate([led,1.25,1.6])cube([2,4.2,.1],center=true);
                                    
                                }else{
                                    translate([led,.6,0])cube([2,2,.1],center=true);
                                    translate([led,.6,1.75])cube([2,2.8,.1],center=true);
                                    
                                }
                            }
                            
                            if(sideLEDs==true){         // cutout for light channels on top side
                                translate([led,2,.3])cube([2,5,2],center=true);
                            }
                        }
                        for(led = [-14.5 : 2.89 : 14.5]){
                            if(ledDiffusor==half){// led diffusor only on 
                                                  // lower half to avoid blinding
                                translate([led,1.4,3]){
                                    if (extendedLEDs==true){
                                         translate([0,1.2,0])cube([2,1.5,3],center=true);
                                    }else{
                                         cube([2,1.2,3],center=true); 
                                    }
                                }
                            }
                            if(ledDiffusor==none){
                                translate([led,.6,3]){
                                    cube([2,2.8,3],center=true); // no led diffusor
                                    if (extendedLEDs==true)translate([0,1.4,0])cube([2,2.6,3],center=true);
                                }
                            }
                        }
                        
                    }

                    // display cutouts
                    
                    // display module                                        
                    translate([-0.75,.5,0])cube([30,14,5],center=true);   
                    
                    // screen cutout normal
                    translate([1.25,.625,0])cube([23,12.25,16],center=true); 
                    
                    
                    if (largeScreen==true){              // screen cutout large (becomes even larger when l&r rockets are deactivated)
                        translate([-2,.625,0])cube([23,12.25,16],center=true); 
                        if (showLeftRocket==false)translate([-3.5,.625,0])cube([23,12.25,16],center=true); 
                        if (showRightRocket==false)translate([2,.625,0])cube([23,12.25,16],center=true);  
                        
                    }
                    
                    // left rocket
                    if(showLeftRocket==true){
                        hull(){
                            translate([-16,2.25,.5])cube([4.1,6,.1],center=true); 
                            translate([-16.5,1.75,3])cube([4.5,10,.1],center=true);  
                        }
                    }         
                    // right rocket
                    if(showRightRocket==true){
                        hull(){
                            translate([16,-2.75,.5])cube([4.1,6,.1],center=true); 
                            translate([16.5,-2,3])cube([4.5,8,.1],center=true); 
                        }
                    }
                    
                    // ccc on the left side of display
                    translate([0,4.75,0]){                
                        translate([-13.5,1,0])cube([2.5,1,8]);
                        translate([-13.5,-1.5,0])cube([2.5,1,8]);
                        translate([-13.5,-1,0])cube([1,3,8]);
                        
                    }
                    translate([0,.375,0]){
                        translate([-13.5,1,0])cube([2.5,1,8]);
                        translate([-13.5,-1.5,0])cube([2.5,1,8]);
                        translate([-13.5,-1,0])cube([1,3,8]);
                        
                    }
                    translate([0,-4,0]){
                        translate([-13.5,1,0])cube([2.5,1,8]);
                        translate([-13.5,-1.5,0])cube([2.5,1,8]);
                        translate([-13.5,-1,0])cube([1,3,8]);
                        
                    }
                    // button cutouts
                    translate([-width/2+1,height/2-10,0]){
                       cube([5,4,3.5],center=true);//home
                        translate([-3.5,0,0])cube([5,4,16],center=true); 
                    }
                    translate([width/2-1,-height/2+9,0]){
                        cube([5,4,3.5],center=true);//right
                        translate([3.5,0,0])cube([5,4,16],center=true);
                        
                    }
                    translate([-width/2+1,-height/2+10,0]){
                        cube([5,4,3.5],center=true);//left
                        translate([-3.5,0,0])cube([5,4,16],center=true);
                    }
                    translate([width/2-1,-height/2+15,0]){
                        cube([5,4,3.5],center=true);//select
                        translate([3.5,0,0])cube([5,4,16],center=true);
                    }
                    
                    //side led cutout
                    translate([width/2-1,-height/2+22.5,.3]){
                        cube([2.6,5,3.5],center=true);//side led
                    }
                    
                    // shiny button cutouts
                    if (shinyButtons){
                        translate([-width/2+2,height/2-10,2])cube([2,4,3.5],center=true);//home
                        translate([width/2-2,-height/2+9,2])cube([2,4,3.5],center=true);//right
                        translate([-width/2+2,-height/2+10,2])cube([2,4,3.5],center=true);//left
                        translate([width/2-2,-height/2+15,2])cube([2,4,3.5],center=true);//select
                    }

                    //ir & top rocket & logo cutout
                    if (showLogo == true && showTopRocket==true){
                         union(){
                            difference(){
                                hull(){
                                    translate([width/2-18.5,height/2-5,4])cube([26,9.5,.1],center=true); 
                                    translate([width/2-17,height/2-6.25,.5])cube([22.75,6.5,.1],center=true); 
                                }
                                    //led cover inside ir  
                                translate([-10,height/2-3,0])cube([30,3,2],center=false); 
                                translate([-10,height/2-1.25,1])rotate([60,0,0])cube([30,5,2],center=false); 
                                // slope right
                                translate([16,2,0])rotate([0,10,0])cube([15,15,15]);
                            }
                        }
                    } else {
                    

                        //ir only cutout
                        hull(){
                            translate([7.75,13.75,0.5])cube([5.5,1.5,0.1],center=true);//select
                            translate([7.75,13.75,3.1])cube([8.5,3.5,0.1],center=true);//select
                        }
                        
                        if (showTopRocket==true){
                            // top rocket only cutout
                            hull(){
                                translate([-1.875,12,.5]) cube([6.5,4.5,.1],center=true); 
                                translate([-1.875,12.125,3.1])cube([9.5,6.75,.1],center=true);
                            }
                        }
                        if (showLogo==true){
                            // logo & ir cutout
                            hull(){
                                translate([9.75,11.25,0.5])cube([13.5,6.5,.1],center=true);//select
                                translate([8.75,11.75,3.1])cube([15.5,7.5,.1],center=true);//select
                            }
                        }
                    }
                    

                    //ecg

                        
                    translate([0.5,-height/2+2,.5]){
                        cube([26,14,16],center=true);//select
                        
                    hull()
                        {  
                            translate([0,0.5,3.5])cube([30,19,.1],center=true);
                            translate([0,.2,0])cube([26,14,.1],center=true);
                        }
                        
                    }

                    
                }
                //cutout for extra (sewable) connectors on bottom
                if (GPIOaccess==true)translate([0,0,-5.5])cube([34,50,3],center=true);  
                
            }
            

            
            // screw protection
            if(screwStyle>=3){
                translate([width/2-3,height/2-3.25,2.8])rotate([0,0,-45])cube([.6,5,1],true);
                translate([-width/2+3,height/2-3.25,2.8])rotate([0,0,45])cube([.6,5,1],true);
                translate([-width/2+3,-height/2+3.25,2.8])rotate([0,0,-45])cube([.6,5,1],true);
                translate([width/2-3,-height/2+3.25,2.8])rotate([0,0,45])cube([.6,5,1],true);
            }
            
            // screw protection X
            if(screwStyle==4){
                translate([width/2-3,height/2-3.25,2.8])rotate([0,0,45])cube([.6,5,1],true);
                translate([-width/2+3,height/2-3.25,2.8])rotate([0,0,-45])cube([.6,5,1],true);
                translate([-width/2+3,-height/2+3.25,2.8])rotate([0,0,45])cube([.6,5,1],true);
                translate([width/2-3,-height/2+3.25,2.8])rotate([0,0,-45])cube([.6,5,1],true);
            }
                    

            // button cover
            bcshift=.3; // shift buttons outwards
            
            
            scale([1,1,-1]){
                translate([width/2+.5+bcshift,-height/2+14,-4]){
                
                    cube([2.4,2,4],center=false);          //select
                
                    translate([1.75,0,0]){
                        cube([1.4,7.5,6],center=false);
                        if(riffledButtons==true){                            
                            for(riffle = [1: 2 : 6]){
                                translate([1.3,riffle,0])rotate([0,0,45])cube([1,1,6]);
                            }
                        }
                    }
                    hull(){                               // spring
                        translate([2,7.5,0])cube([springWidth,.1,6],center=false);
                        translate([-bcshift,11,0])cube([springWidth,1,6],center=false);
                    }
                }
            }
            
            scale([1,-1,-1]){
                translate([width/2+.5+bcshift,7.75,-4]){
                
                    cube([2.4,2,4],center=false);          //right
                
                    translate([1.75,-3.5,0]){
                        cube([1.4,8.5,6],center=false);
                        if(riffledButtons==true){                            
                            for(riffle = [1: 2 : 6]){
                                translate([1.3,riffle,0])rotate([0,0,45])cube([1,1,6]);   
                            }
                        }
                    }
                    hull(){                               // spring
                        translate([2,5,0])cube([springWidth,.1,6],center=false);
                        translate([-bcshift,7.3,0])cube([springWidth,1,6],center=false);
                    }
                }
            }
            
            
            scale([-1,-1,1]){
                scale([1,1,-1]){
                    translate([width/2+.5+bcshift,6.75,-4]){ 
                        cube([2.4,2,4],center=false);          //left
                        
                        translate([1.75,-3,0]){
                           cube([1.4,8.5,6],center=false);
                            if(riffledButtons==true){                            
                            for(riffle = [1: 2 : 6]){
                                translate([1.3,riffle,0])rotate([0,0,45])cube([1,1,6]);
                            }
                        }
                        }
                        hull(){                               // spring
                            translate([1.75,5,0])cube([springWidth,.1,6],center=false);
                            translate([.50-bcshift,8.1,0])cube([springWidth,1,6],center=false);
                        }
                    }
                }
            }
            if(homeButtonCover==normal){
                scale([-1,1,-1]){
                    translate([width/2+.5+bcshift,6.75,-4]){
                        cube([2.4,2,4],center=false);          //home
                        translate([1.75,-3,0]){
                            cube([1.4,8.5,4.5],center=false);
                            if(riffledButtons==true){                            
                                for(riffle = [1: 2 : 6]){
                                    translate([1.3,riffle,0])rotate([0,0,45])cube([1,1,4.5]);
                                }
                            }
                        }
                        hull(){                               // spring
                            translate([1.75,5,0])cube([.6,.1,4.5],center=false);
                            translate([.50-bcshift,8.1,0])cube([springWidth,1,4.5],center=false);
                            
                        }
                    }
                }
                // block between home and left button
                difference(){
                    translate([-width/2-3.5,-3,-.5])cube([3,6,4.5],center=false);  
                    if(bevels)translate([-29,1,0])rotate([0,30,0])cube([5,9.5,10],true);   
                }
                
            }else{
                scale([-1,1,-1]){
                    translate([width/2+.5+bcshift,6.75,-4]){
                        cube([2.4,2,4],center=false);          //tiny home button
                            if(riffledButtons==true){    
                                translate([3,.8,0])rotate([0,0,45])cube([1,1,4.5]); 
                            }
                        translate([1.75,0,0])cube([1.4,3,4.5],center=false);
                        
                        hull(){                               // spring
                            translate([1.75,3,0])cube([springWidth,.1,4.5],center=false);
                            translate([.50-bcshift,8.1,0])cube([springWidth,1,4.5],center=false);
                        }
                    }
                }
                // block between home and left button
                difference(){
                    translate([-width/2-3.5,-3,-.5])cube([2,8.75,4.5],center=false);  
                    if(bevels)translate([-29,1,0])rotate([0,30,0])cube([5,9.5,10],true);   
                }
            }
            

         
         // clip-on triangle inside left
             hull(){
                translate([-23.3,-4.5,-.8])cube([1,5,.1],center=false);
                translate([-24,-4.5,-5])cube([1,5,.1],center=false);
            }

         // clip-on triangle inside right
             hull(){
                translate([22.3,0,-.8])cube([1,5,.1],center=false);
                translate([23,0,-5])cube([1,5,.1],center=false);
            }
        }
        
        // cutouts for opening clipping mechanism with flat screwdriver
        
        // left
        translate([-23.5,-4,-6])cube([2,4,4],center=false);
        
        // right
        translate([21.5,0.5,-6])cube([2,4,4],center=false);
        
        // right - slot for flexibility
        translate([21.5,5,-6])cube([2,1,6.5],center=false);
        
        // make it more flat (cut off from top)
        translate([0,0,4])cube([60,50,2],center=true);
        
        // rings around screws
        if(screwRings)translate([0,0,-7])intersection(){
            difference(){
                hull(){
                    translate([.5,0,10])cube([43,33,2.6],true);
                    translate([.5,0,10])cube([45,30,2.6],true);
                }
                if (showLogo){
                    translate([2,10,10])cube([30,33,2.6],true);
                    translate([3,20,10])cube([30,10,2.6],true); // ring cutout top right logo window
                }
                if(bevels)translate([26.5,20,10])cube([10,20,2.6],true); //"
                if (shinyButtons)translate([23.5,-6.5,10])cube([10,10,2.6],true);  // bottom right
                    
            }
            union()
                {
                    translate([0,0,5]){difference(){
                    translate([width/2-3,height/2-3.25,5])cylinder($fn=72,d1=7,d2=8.75,h=2.5,center=true);
                    translate([width/2-3,height/2-3.25,5])cylinder($fn=72,d1=6.75,d2=4.4,h=2.6,center=true);
                }
            }
            translate([0,0,5]){difference(){
                    translate([-width/2+3,height/2-3.25,5])cylinder($fn=72,d1=7,d2=8.75,h=2.5,center=true);
                    translate([-width/2+3,height/2-3.25,5])cylinder($fn=72,d1=6.75,d2=4.4,h=2.6,center=true);
                }
            } 
            translate([0,0,5]){difference(){
                    translate([width/2-3,-height/2+3.25,5])cylinder($fn=72,d1=7,d2=8.75,h=2.5,center=true);
                    translate([width/2-3,-height/2+3.25,5])cylinder($fn=72,d1=6.75,d2=4.4,h=2.6,center=true);
                }
            } 
            translate([0,0,5]){difference(){
                    translate([-width/2+3,-height/2+3.25,5])cylinder($fn=72,d1=7,d2=8.75,h=2.5,center=true);
                    translate([-width/2+3,-height/2+3.25,5])cylinder($fn=72,d1=6.75,d2=4.4,h=2.6,center=true);
                    }
                } 
            }
        }
        // end of rings around screws
        
        // spike grill
        if (spikeGrill){
            if(showLogo && showTopRocket)
            {   for(i=[0:2:7])translate([-13.2,8.7+i,0])cube([7.5-i*1.1,.9,20],true);
                hull()for(i=[0:2:7])translate([-13.2,8.7+i,0])cube([7.5-i*1.1,.9,4],true);
            }
            if(showLogo && !showTopRocket)
            {   for(i=[0:2:7])translate([-12+i,8.7+i,0])cube([12,.9,20],true);
                hull()for(i=[0:2.1:7])translate([-12+i,8.7+i,0])cube([12,.9,4],true);
            }
            if(!showLogo &&showTopRocket)
            {   for(i=[0:2:7])translate([-12.5,8.7+i,0])cube([8-i*1.1,.9,20],true);
                hull()for(i=[0:2:7])translate([-12.5,8.7+i,0])cube([8-i*1.1,.9,4],true);
            }
            if(!showLogo &&!showTopRocket)
            {   for(i=[0:2:7])translate([-11+i,8.7+i,0])cube([14,.9,20],true);
                hull()for(i=[0:2.1:7])translate([-11+i,8.7+i,0])cube([14,.9,4],true);
            }
        }
    }
}


    
    
module beltDecoration(){
    echo("generate belt decoration:");
    echo(beltStyle);
    if(beltStyle==plain)translate([0,0,0])cube([60,300,25],true);
    if(beltStyle==pacman)pacmanDeco();
    if(beltStyle==hexagons)hexDeco();
    if(beltStyle==heartbeat)heartbeatDeco();
    if(beltStyle==flash)flashDeco();
}
    
module beltTop(){
    echo("generate belt top");
    difference(){
        union(){
            difference(){
                //belt
                union(){
                    beltHalf();
            mirror([1,0,0])beltHalf();
                    }
                        // cutoff chamfers
                        translate([beltWidth/2,beltLengthTop+32,-20])rotate([0,0,45])cube([20,4.6,20]);
                        translate([-beltWidth/2,beltLengthTop+32,-20])rotate([0,0,45])cube([4.6,20,20]);
                }

            // hinge block
            hull(){
                translate([-beltWidth/2+4.3,beltLengthTop+33.5,-5])cube([beltWidth-8.6,4.5,3.7],center=false);
                translate([-beltWidth/2+4.3,beltLengthTop+30.5,-5])cube([beltWidth-8.6,4.5,beltThickness],center=false);
            }
            
        }
        //pivot hole  
            translate([0,beltLengthTop+36,-3.5])cube([50,1.2,1.2],center=true);
        
        //chamfer hinge block top (for rotary freedom)
        translate([-beltWidth/2+4,beltLengthTop+38,-2.5])rotate([45,0,0])cube([beltWidth-8,2,2],center=false);
        //chamfer hinge block bottom (for rotary freedom)
        translate([-beltWidth/2+4,beltLengthTop+38,-6.5])rotate([60,0,0])cube([beltWidth-8,2,1],center=false);
        //glue drop hole
        translate([-2,beltLengthTop+33.6,-4.5])cube([4,3,10],center=false);
        
        //deko cutout
        difference(){
            //dekoarea
            translate([-beltWidth/2+3,36,-6])cube([beltWidth-6,beltLengthTop-6,50]);
            //belt decoration;
            translate([0,44,0])beltDecoration();
        }
    }
    if(firstLayerDeco)translate([-beltWidth/2+3,36,-5])cube([beltWidth-6,beltLengthTop-6,.3]);
}
    
module beltBottom(){
    echo("generate belt bottom");
    difference(){
        // main belt body : mirrored from top
        union(){ 
            //standard belt parts
            mirror([0,1,0])beltHalf();
            mirror([1,0,0])mirror([0,1,0])beltHalf();
            //adding conection to fClip
            translate([-(beltWidth-3.5)/2,-51-beltLengthTop,-5])cube([beltWidth-3.5,18,beltThickness]);
        }
        // cutoff chamfers
        translate([beltWidth/2+1.5,-36.2-beltLengthTop,-20])rotate([0,0,45])cube([10,4.6,20]);
        translate([-beltWidth/2-1.5,-36.2-beltLengthTop,-20])rotate([0,0,45])cube([4.6,10,20]);
                // cutoff end chamfers
        translate([beltWidth/2,-55-beltLengthTop,-20])rotate([0,0,45])cube([10,5,20]);
        translate([-beltWidth/2,-55-beltLengthTop,-20])rotate([0,0,45])cube([5,10,20]);
        
        // cutout glueing lock
        lockWidth=beltWidth-9.5;
        translate([-lockWidth/2,-48-beltLengthTop,-10])cube([lockWidth,3.5,100]); 
        translate([-lockWidth/2,-40-beltLengthTop,-10])cube([lockWidth,3.5,100]);
        
        //deko cutout
        difference(){
            //deko area
            translate([-beltWidth/2+3,-28-beltLengthTop,-6])cube([beltWidth-6,beltLengthTop-8,50]);
            //beltDeko
            translate([0,-143,0])rotate([0,0,0])beltDecoration();
        }
        
        //bending area
        for (i=[0:2.6:(beltWidth/2)-3])translate([i,-32-beltLengthTop,-6])cube([1,2,50],center=true);
        for (i=[0:2.6:(beltWidth/2)-3])translate([-i,-32-beltLengthTop,-6])cube([1,2,50],center=true);
    }
    

    if(firstLayerDeco)translate([-beltWidth/2+3,-28-beltLengthTop,-5])cube([beltWidth-6,beltLengthTop-6,.3]);
}

module beltBlocks(){
    echo("generate 4 belt blocks...");
    beltBlock();
    mirror([1,0,0])beltBlock();
    mirror([0,1,0])beltBlock();
    mirror([0,1,0])mirror([1,0,0])beltBlock();
}
module mClip(){
    echo("generate mclip");
    halfClip();
    mirror([1,0,0])halfClip();
}

module fClip(){
    echo("generate fclip");
    translate([0,-38.5,-3.5+beltThickness])halfHolder();  
    mirror([1,0,0])translate([0,-38.5,-3.5+beltThickness])halfHolder(); 
    // glueing lock
    lockWidth=beltWidth-10;
    translate([-lockWidth/2,-17.75,-5])cube([lockWidth,3,1]); 
    translate([-lockWidth/2,-09.75,-5])cube([lockWidth,3,1]); 
}




//assemble parts
echo("assemble parts");
if (printOrientation){
    echo("display in print orientation");
     color( c = rands(.3,.9,3) ){
     if(generateMClip)translate([-10,0,0])rotate([0,0,90])mClip();
     if(generateFClip)translate([-46,0,25.5])rotate([90,0,90])fClip();
     
         if(generateCover || generateBottom){
         if(generateBeltTop)translate([95,-42,5])rotate([0,0,90])beltTop();
         if(generateBeltBottom)translate([95,42,5])rotate([0,0,-90])beltBottom();
             }else{
         if(generateBeltTop)translate([-30,-18,5])rotate([0,0,-90])beltTop();
         if(generateBeltBottom)translate([-30,18,5])rotate([0,0,90])beltBottom();
             }
     
     
     if(generateCover)translate([10,0,3])rotate([180,0,90])watchBody();
     if(generateBottom)translate([55,0,1.5])rotate([0,0,90])bottom(); 
    }
}else{
        // non-print orientation (assembly view)
    echo("display in assembly view");
     color( c = rands(.3,.9,3,seed_value=rndSeed) ){
     if(generateMClip)translate([0,+beltLengthTop+34,0])mClip();
     if(generateFClip)translate([0,-beltLengthTop-30,5])fClip();
     if(generateBeltTop)translate([0,0,5])beltTop();
     if(generateBeltBottom)translate([0,0,5])beltBottom();
     if(generateCover)translate([0,0,5])watchBody();
     if(generateBottom)translate([70,0,-3])bottom();
     
     }    
}
        
            
    


    






