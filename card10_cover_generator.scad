/*
          
          A random cover generator for the CARD10 badge!
          ==============================================
          
          Cover features:
          ---------------
        * 24576 variations possible!!!
        * buttons become much more usable as they get a bigger surface
        * the cover can be clipped onto the badge - there are no tools required to change the cover
        * you can add a piece of clear plastic (e.g. cutout from a pet bottle) as display protection 
        * the model has no overhangs, thus it is very easy to print (except if you turn side led's on)
        * you can turn off the randomization and generate exactly the cover that YOU want!
        
        
          How to use:
          -----------
        * Open this code in openSCAD (download from https://www.openscad.org/)
        * [optional]: adjust settings below in the section 'CUSTOMIZE YOUR COVER BY ADJUSTING VALUES BELOW:'
        * hit the render button in openSCAD (the button above the code with the hourglass & the cube)
        * hit the .stl export button right next to the render button
        * print your .stl model!
        
        
          Printing instructions:
          ----------------------
        * print upside down without support
        * recommended slicer settings: 
            0.1mm layer height
            0.4mm wall thickness
            100% infill with 
            0.4mm extruder
  
  
          Assembly instructions:
          ----------------------
        * clean up the print with a small utility knife
        * [optional]: cut a 14mm x 30mm piece of clear plastic as display protection (e.g. from a pet-bottle) 
                      and place it inside the display cutout  
        * clip the cover onto your card10 badge
        * post a picture of your covered badge with the hashtag #card10
          
  
          License:
          ----------------------------------------------------------------------------
          "THE TSCHUNK-WARE LICENSE" (Revision 23):
          Niklas Roy wrote this file. As long as you retain this notice you
          can do whatever you want with this stuff. If we meet some day, and you think
          this stuff is worth it, you can buy me a tschunk in return
          ----------------------------------------------------------------------------
*/

none=0;half=1;full=2;normal=0;tiny=1;
function maybe()=round(rands(0,1,1)[0])==1;
function rnd(x) =round(rands(0,x,1)[0]);

                                //////////////////////////////////////////////////////////
                                // 
                                // CUSTOMIZE YOUR COVER BY ADJUSTING VALUES BELOW:
                                //  
                                //
ledDiffusor         = rnd(2);   // adjusts diffusion layer above leds - options are:
                                // - 'full' [full diffusion - led's are invisible when turned off]
                                // - 'half' [only diffusion at bottom ...
                                //           ... led's won't blind you when you look at the display]
                                // - 'none' [led's remain fully open - you get top brightness!]
sideLEDs            = maybe();  // toggle sideways visibility of top row led's 
                                // - if set to 'true', you'll have to print with minimal overhangs!
extendedLEDs        = maybe();  // adds protruding led protector on top
personalStateLED    = maybe();  // toggles cutout for visibility of personal state led
showLeftRocket      = maybe();  // toggles visibility of left led rocket
showRightRocket     = maybe();  // toggles visibility of right led rocket
showTopRocket       = maybe();  // toggles visibility of top led rocket
GPIOaccess          = maybe();  // toggles cutout for sewable connectors
bevels              = maybe();  // toggles bevels - [no bevels make the cover look more blocky]
homeButtonCover     = rnd(1);   // toggles size of on-off-home button. options are:
                                // - 'normal' [explains itself]
                                // - 'tiny'   [tiny button in order to avoid accidental turn-off]
riffledButtons      = maybe();  // toggles whether buttons have a riffled surface 
                                // - otherwise button surface is flat
largeScreen         = maybe();  // shows more of the display module than just the screen area
                                // - when false, ccc is shown left to the screen area
showLogo            = maybe();  // toggles visibility of CARD10 logo
showScrews          = maybe();  // toggles whether the four torx screws on top are covered or not
                                // 
                                // END OF CUSTOMIZATION!
                                //  
                                //////////////////////////////////////////////////////////



color( c = rands(.3,.9,3) ){
    extra=.3;                 
    corner=3.1;              
    width=45;              
    height=35.5;                
    depth=1;                    
    screwHead=4.2;             

    difference(){
        union(){
            difference(){
                // outer shell
                difference(){
                    union(){// main body
                        hull(){ 
                            translate([0,0,2.5]){
                                cube([width+3,height+3,3],center=true);
                            }
                            translate([0,0,-4.25]){
                                cube([width+3,height+3,3],center=true);
                            }
                        }
                        if(extendedLEDs==true){
                            hull(){ // extended led block
                                translate([0,height/2+2,3]){ // top
                                    cube([32.6,2,3],center=true);
                                }
                                translate([0,height/2,-1.3]){ // bottom
                                    cube([32.6,2,.1],center=true);
                                }
                            }
                        }
                    }
                    
                    // chopped off corners
                    translate([width/2+2,height/2+2,1]){
                        rotate([0,0,45]){
                            cube([6,10,15],center=true);
                        }
                    }
                    translate([-width/2-2,height/2+2,1]){
                        rotate([0,0,-45]){
                            cube([6,10,15],center=true);
                        }
                    }
                    translate([width/2+2,-height/2-2,1]){
                        rotate([0,0,-45]){
                            cube([6,10,15],center=true);
                        }
                    }
                    translate([-width/2-2,-height/2-2,1]){
                        rotate([0,0,45]){
                            cube([6,10,15],center=true);
                        }
                    }
                    
                    // bevels
                    if(bevels==true){
                        translate([0,-height/2-5,4]){ // bottom
                            rotate([60,0,0]){
                                cube([60,10,10],center=true);
                            }
                        }
                        
                        translate([-26.3,height/2+5,4]){ // top-left
                            rotate([30,0,0]){
                                cube([20,10,10],center=true);
                            }
                        }
                        translate([26.3,height/2+5,4]){ // top-right
                            rotate([30,0,0]){
                                cube([20,10,10],center=true);
                            }
                            translate([1.36,-3,0]){     // top right corner
                                rotate([0,0,-45]){
                                    rotate([30,0,0]){
                                        cube([12,13,17],center=true);
                                    }
                                }
                            }
                            translate([1.2,-.5,0]){     // right-top
                                rotate([0,0,90]){
                                    rotate([-30,1,0]){
                                        hull(){
                                            translate([-9,-5,0]){
                                                cube([28,.1,10],center=true);
                                            }
                                            translate([1.5,5,0]){
                                                cube([28,.1,10],center=true);
                                            }
                                        }
                                    }
                                }
                            }

                        }
                    }
                    
                    //usb-c cutout
                    translate([-15,height/2-11,-5]){
                            cube([20,10,6],center=true);
                    }
                    
                    //cutout between right and select button
                    translate([15,-5,-3]){
                            cube([20,8,7],center=true);
                    } 
                    
                    
                }

                union(){
                    // harmonic board basic shape
                    hull(){
                        translate([width/2-corner+extra,height/2-corner+extra,0]){
                            cylinder($fn=24,r=corner,h=depth,center=true); 
                        }
                        translate([-width/2+corner-extra,height/2-corner+extra,0]){
                            cylinder($fn=24,r=corner,h=depth,center=true); 
                        }
                        translate([-width/2+corner-extra,-height/2+corner-extra,0]){
                            cylinder($fn=24,r=corner,h=depth,center=true); 
                        }
                        translate([width/2-corner+extra,-height/2+corner-extra,0]){
                            cylinder($fn=24,r=corner,h=depth,center=true); 
                        }
                        translate([0,0,-10]){ // lowered copy of the board
                            translate([width/2-corner+extra,height/2-corner+extra,0]){
                                cylinder($fn=24,r=corner,h=depth,center=true); 
                            }
                            translate([-width/2+corner-extra,height/2-corner+extra,0]){
                                cylinder($fn=24,r=corner,h=depth,center=true); 
                            }
                            translate([-width/2+corner-extra,-height/2+corner-extra,0]){
                                cylinder($fn=24,r=corner,h=depth,center=true); 
                            }
                            translate([width/2-corner+extra,-height/2+corner-extra,0]){
                                cylinder($fn=24,r=corner,h=depth,center=true); 
                            }
                        }
                    }
                    
                    // screws
                    if(showScrews){
                        translate([width/2-3,height/2-3.25,.4]){
                            cylinder($fn=24,d1=screwHead,d2=screwHead+.5,h=3,center=false); 
                        }
                        translate([-width/2+3,height/2-3.25,.4]){
                            cylinder($fn=24,d1=screwHead,d2=screwHead+.5,h=3,center=false); 
                        }
                        translate([-width/2+3,-height/2+3.25,.4]){
                            cylinder($fn=24,d1=screwHead,d2=screwHead+.5,h=3,center=false); 
                        }
                        translate([width/2-3,-height/2+3.25,.4]){
                            cylinder($fn=24,d1=screwHead,d2=screwHead+.5,h=3,center=false); 
                        }             
                   }else{
                        translate([width/2-3,height/2-3.25,-.75]){
                            cylinder($fn=24,d=screwHead,,h=2.5,center=false); 
                        }
                        translate([-width/2+3,height/2-3.25,-.75]){
                            cylinder($fn=24,d=screwHead,,h=2.5,center=false); 
                        }
                        translate([-width/2+3,-height/2+3.25,-.75]){
                            cylinder($fn=24,d=screwHead,,h=2.5,center=false); 
                        }
                        translate([width/2-3,-height/2+3.25,-.75]){
                            cylinder($fn=24,d=screwHead,,h=2.5,center=false); 
                        }
                    }
                    
                    // personal state led
                    if(personalStateLED==true){
                        translate([-15.75,19,-4]){
                            cube([2.5,3,7],center=true);
                        }
                    }
                    
                    // leds
                    translate([0,height/2-1,.9]){
                        translate([0,-.3,-3]){
                            cube([32,2.4,7],center=true); // cutout for physical led's on board
                        }
                        for(led = [-14.5 : 2.89 : 14.5]){ // cutouts for led light channels
                            hull(){
                                if(extendedLEDs==true){
                                    translate([led,1.6,-.4]){
                                        cube([2,2,.1],center=true);
                                    }
                                    translate([led,1.25,1.6]){
                                        cube([2,4.2,.1],center=true);
                                    }
                                }else{
                                    translate([led,.6,0]){
                                        cube([2,2,.1],center=true);
                                    }
                                    translate([led,.6,1.75]){
                                        cube([2,2.8,.1],center=true);
                                    }
                                }
                            }
                            
                            if(sideLEDs==true){         // cutout for light channels on top side
                                translate([led,2,.3]){
                                    cube([2,5,2],center=true);
                                }
                                
                            }
                        }
                        for(led = [-14.5 : 2.89 : 14.5]){
                           /* if(ledDiffusor==full){
                                translate([led,.1,0]){
                                    cube([2,2,3.6],center=true); // led diffusor

                                }
                            }*/
                            if(ledDiffusor==half){// led diffusor only on 
                                                                 // lower half to avoid blinding
                                translate([led,1.4,3]){
                                    if (extendedLEDs==true){
                                         translate([0,1.2,0]){
                                            cube([2,1.5,3],center=true);
                                         }
                                    }else{
                                         cube([2,1.2,3],center=true); 
                                    }
                                }
                            }
                            if(ledDiffusor==none){
                                translate([led,.6,3]){
                                    cube([2,2.8,3],center=true); // no led diffusor
                                    if (extendedLEDs==true){
                                         translate([0,1.4,0]){
                                            cube([2,2.6,3],center=true);
                                         }
                                    }
                                }
                            }
                        }
                        
                    }

                    // display cutouts
                    
                                                            
                    translate([-0.75,.5,0]){           // display module
                        cube([30,14,5],center=true);   
                    }

                    translate([1.25,.625,0]){            // screen cutout normal
                        cube([23,12.25,16],center=true); 
                    }
                    
                    if (largeScreen==true){              // screen cutout large (becomes even larger when l&r rockets are deactivated)
                        translate([-2,.625,0]){          
                            cube([23,12.25,16],center=true); 
                        }
                        if (showLeftRocket==false){              
                            translate([-3.5,.625,0]){          
                                cube([23,12.25,16],center=true); 
                            }
                        }
                        if (showRightRocket==false){              
                            translate([2,.625,0]){          
                                cube([23,12.25,16],center=true); 
                            }
                        }
                    }
                    
                    if(showLeftRocket==true){
                        hull(){
                            translate([-16,2.25,.5]){
                                cube([4.1,6,.1],center=true); // left rocket
                            }  
                            translate([-16.5,1.75,3]){
                                cube([4.5,10,.1],center=true);  
                            }  
                        }
                    }         
                    if(showRightRocket==true){
                        hull(){
                            translate([16,-2.75,.5]){
                                cube([4.1,6,.1],center=true); // right rocket
                            }
                            translate([16.5,-2,3]){
                                cube([4.5,8,.1],center=true); // right rocket
                            }
                        }
                    }
                    
                    translate([0,4.75,0]){                // ccc on the left side of display
                        translate([-13.5,1,0]){
                            cube([2.5,1,8]);
                        }
                        translate([-13.5,-1.5,0]){
                            cube([2.5,1,8]);
                        }
                        translate([-13.5,-1,0]){
                            cube([1,3,8]);
                        }
                    }
                    translate([0,.375,0]){
                        translate([-13.5,1,0]){
                            cube([2.5,1,8]);
                        }
                        translate([-13.5,-1.5,0]){
                            cube([2.5,1,8]);
                        }
                        translate([-13.5,-1,0]){
                            cube([1,3,8]);
                        }
                    }
                    translate([0,-4,0]){
                        translate([-13.5,1,0]){
                            cube([2.5,1,8]);
                        }
                        translate([-13.5,-1.5,0]){
                            cube([2.5,1,8]);
                        }
                        translate([-13.5,-1,0]){
                            cube([1,3,8]);
                        }
                    }
                        
                        




                    // buttons
                    translate([-width/2+1,height/2-10,0]){
                        cube([5,4,3.5],center=true);//home
                        translate([-3.5,0,0]){
                            cube([5,4,16],center=true);//
                        }
                    }
                    translate([width/2-1,-height/2+9,0]){
                        cube([5,4,3.5],center=true);//right
                        translate([3.5,0,0]){
                            cube([5,4,16],center=true);//
                        }
                    }
                    translate([-width/2+1,-height/2+10,0]){
                        cube([5,4,3.5],center=true);//left
                        translate([-3.5,0,0]){
                            cube([5,4,16],center=true);//
                        }
                    }
                    translate([width/2-1,-height/2+15,0]){
                        cube([5,4,3.5],center=true);//select
                        translate([3.5,0,0]){
                            cube([5,4,16],center=true);//
                        }
                    }

                    //ir & top rocket & logo cutout
                    if (showLogo == true && showTopRocket==true){
                         union(){
                            difference(){
                                hull(){
                                    translate([width/2-18.5,height/2-5,4]){
                                        cube([26,9.5,.1],center=true); 
                                    }
                                    translate([width/2-17,height/2-6.25,.5]){
                                        cube([22.75,6.5,.1],center=true); 
                                    }
                                }
                                    
                                translate([-10,height/2-3,0]){//led cover inside ir  
                                    cube([30,3,2],center=false); 
                                }
                                translate([-10,height/2-1.25,1]){
                                    rotate([60,0,0]){
                                        cube([30,5,2],center=false); 
                                    }
                                }
                                translate([16,2,0]){ // slope right
                                    rotate([0,10,0]){
                                        cube([15,15,15]);
                                    }
                                }
                            }
                        }
                    } else {
                    

                        //ir only cutout
                        hull(){
                            translate([7.75,13.75,0.5]){
                                cube([5.5,1.5,0.1],center=true);//select
                            }
                            translate([7.75,13.75,3.1]){
                                cube([8.5,3.5,0.1],center=true);//select
                            }
                        }
                        
                        if (showTopRocket==true){
                            // top rocket only cutout
                            hull(){
                                translate([-1.875,12,.5]){
                                    cube([6.5,4.5,.1],center=true); 
                                }
                                translate([-1.875,12.125,3.1]){
                                    cube([9.5,6.75,.1],center=true); 
                                }
                            }
                        }
                        if (showLogo==true){
                            // logo & ir cutout
                            hull(){
                                translate([9.75,11.25,0.5]){
                                    cube([13.5,6.5,.1],center=true);//select
                                }
                                translate([8.75,11.75,3.1]){
                                    cube([15.5,7.5,.1],center=true);//select
                                }
                            }
                        }
                    }
                    

                    //ecg

                        
                    translate([0.5,-height/2+2,.5]){
                        cube([26,14,16],center=true);//select
                        
                    hull()
                        {  
                            translate([0,0.5,3.5]){
                                cube([30,19,.1],center=true);
                            }
                            translate([0,.2,0]){
                                cube([26,14,.1],center=true);
                            }
                        }
                        
                    }

                    
                }
                //cutout for extra (sewable) connectors on bottom
                if (GPIOaccess==true){
                    translate([0,0,-5.5]){
                        cube([34,50,3],center=true);
                    }
                }
            }
            


                    

            // button cover
            scale([1,1,-1]){
                translate([width/2+.5,-height/2+14,-4]){
                
                    cube([2.4,2,4],center=false);          //select
                
                    translate([1.75,0,0]){
                        cube([1.4,7.5,6],center=false);
                        if(riffledButtons==true){                            
                            for(riffle = [1: 2 : 6]){
                                translate([1.3,riffle,0]){
                                    rotate([0,0,45]){
                                        cube([1,1,6]);
                                    }   
                                } 
                            }
                        }
                    }
                    hull(){                               // spring
                        translate([2,7.5,0]){
                            cube([.6,.1,6],center=false);
                        }
                        translate([0,11,0]){
                            cube([.6,1,6],center=false);
                        }
                    }
                }
            }
            
            scale([1,-1,-1]){
                translate([width/2+.5,7.75,-4]){
                
                    cube([2.4,2,4],center=false);          //right
                
                    translate([1.75,-3.5,0]){
                        cube([1.4,8.5,6],center=false);
                        if(riffledButtons==true){                            
                            for(riffle = [1: 2 : 6]){
                                translate([1.3,riffle,0]){
                                    rotate([0,0,45]){
                                        cube([1,1,6]);
                                    }   
                                } 
                            }
                        }
                    }
                    hull(){                               // spring
                        translate([2,5,0]){
                            cube([.6,.1,6],center=false);
                        }
                        translate([0,7.3,0]){
                            cube([.6,1,6],center=false);
                        }
                    }
                }
            }
            
            
            scale([-1,-1,1]){
                scale([1,1,-1]){
                    translate([width/2+.5,6.75,-4]){ 
                        cube([2.4,2,4],center=false);          //left
                        
                        translate([1.75,-3,0]){
                           cube([1.4,8.5,6],center=false);
                            if(riffledButtons==true){                            
                            for(riffle = [1: 2 : 6]){
                                translate([1.3,riffle,0]){
                                    rotate([0,0,45]){
                                        cube([1,1,6]);
                                    }   
                                } 
                            }
                        }
                        }
                        hull(){                               // spring
                            translate([1.75,5,0]){
                                cube([.6,.1,6],center=false);
                            }
                            translate([.50,8.3,0]){
                                cube([.4,1,6],center=false);
                            }
                        }
                    }
                }
            }
            if(homeButtonCover==normal){
                scale([-1,1,-1]){
                    translate([width/2+.5,6.75,-4]){
                        cube([2.4,2,4],center=false);          //home
                    
                        translate([1.75,-3,0]){
                            cube([1.4,8.5,4.5],center=false);
                                if(riffledButtons==true){                            
                                    for(riffle = [1: 2 : 6]){
                                        translate([1.3,riffle,0]){
                                            rotate([0,0,45]){
                                                cube([1,1,4.5]);
                                            }   
                                        } 
                                    }
                                }
                        }
                        hull(){                               // spring
                            translate([1.75,5,0]){
                                cube([.6,.1,4.5],center=false);
                            }
                            translate([.50,8.3,0]){
                                cube([.4,1,4.5],center=false);
                            }
                        }
                    }
                }
                translate([-width/2-3.5,-3,-.5]){
                    cube([3,6,4.5],center=false);  // block between home and left button
                }
            }else{
                scale([-1,1,-1]){
                    translate([width/2+.5,6.75,-4]){
                        cube([2.4,2,4],center=false);          //tiny home button
                            if(riffledButtons==true){    
                                    translate([3,.8,0]){
                                        rotate([0,0,45]){
                                            cube([1,1,4.5]);
                                        }   
                                    } 
                            }
                        translate([1.75,0,0]){
                            cube([1.4,3,4.5],center=false);
                        }
                        hull(){                               // spring
                            translate([1.75,3,0]){
                                cube([.6,.1,4.5],center=false);
                            }
                            translate([.50,8.3,0]){
                                cube([.4,1,4.5],center=false);
                            }
                        }
                    }
                }

                translate([-width/2-3.5,-3,-.5]){
                    cube([2,8.75,4.5],center=false);  // block between home and left button
                }
            }
            

         
         // clip-on triangle inside left
             hull(){
                translate([-23.3,-4.5,-.8]){
                    cube([1,5,.1],center=false);
                }
                translate([-24,-4.5,-5]){
                    cube([1,5,.1],center=false);
                }
            }

         // clip-on triangle inside right
             hull(){
                translate([22.3,0,-.8]){
                    cube([1,5,.1],center=false);
                }
                translate([23,0,-5]){
                    cube([1,5,.1],center=false);
                }
            }
        }
        
        // cutouts for opening clipping mechanism with flat screwdriver
        
        translate([-23.5,-4,-6]){ // left
            cube([2,4,4],center=false);
        }
        
        translate([21.5,0.5,-6]){ // right
            cube([2,4,4],center=false);
        }
        translate([21.5,5,-6]){ // right - slot for flexibility
            cube([2,1,6.5],center=false);
        }
        
        // make it more flat (cut off from top)
        translate([0,0,4]){
            cube([60,50,2],center=true);
            //cube([60,50,6],center=true); // ultraflat - for testing purposes
        }
    }
}





