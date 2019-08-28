/*
          
          A simple cover for CARD10-badge:
          ================================
        * reduces surface complexity and covers space in between PCB's in order to keep dirt out
        * left/right/select buttons become much more usable as they get a bigger surface
        * on-off button is left as it is in order to avoid accidental pushing
        * diffuses light from the LED's which are mounted on top
        * the cover can be clipped onto the badge - there are no tools required to change the cover
        * the model has no overhangs, thus it is very easy to print
        
          Printing instructions:
          ======================
        * print upside down!
        * adjust value for "ledDiffusionThickness" so that the LED diffusor is only one layer high
        * adjust the value for "extra" in order to achieve a tight fit around the Harmonic board
        * I printed mine with .05mm layer height out of white PLA on an Ultimaker 2 with 0.4mm extruder
  
        --------------------------------------------------------------------------------
          "THE TSCHUNK-WARE LICENSE" (Revision 23):
          Niklas Roy wrote this file. As long as you retain this notice you
          can do whatever you want with this stuff. If we meet some day, and you think
          this stuff is worth it, you can buy me a tschunk in return
        --------------------------------------------------------------------------------
        
          Modeled with OpenSCAD Version 2015.03-2
   
*/

ledDiffusionThickness=.28;  // thickness of diffusion layer for leds
extra=.25;                  // extra space around board for manufacturing imperfections

corner=3.1;                 // corner radius
width=45;                   // width of harmonic board
height=35.5;                // height of harmonic board
depth=1;                    // thickness of board
screwHead=4.2;              // diameter of screws

difference(){
    // outer shell
    difference(){
        hull(){ // main body
            translate([0,0,1]){
                cube([width+2,height+2,2],center=true);
            }
            translate([0,0,-5]){
                cube([width+2,height+2,2],center=true);
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
        translate([width/2-3,height/2-3.25,0]){
            cylinder($fn=24,d=screwHead,h=2.5,center=false); 
        }
        translate([-width/2+3,height/2-3.25,0]){
            cylinder($fn=24,d=screwHead,h=2.5,center=false); 
        }
        translate([-width/2+3,-height/2+3.25,0]){
            cylinder($fn=24,d=screwHead,h=2.5,center=false); 
        }
        translate([width/2-3,-height/2+3.25,0]){
            cylinder($fn=24,d=screwHead,h=2.5,center=false); 
        }

        // leds
        translate([0,height/2-1.5,1.2-ledDiffusionThickness]){
            //cube([32,3,1.6],center=true);
            for(led = [-15 : 3 : 15]){
                translate([led,0,0]){
                    cube([2.5,2.5,1.6],center=true);
                }
            }
            
        }

        // display
        translate([-0.75,.5,1.5]){
            cube([30,14,3],center=true);
        }

        // buttons
        translate([-width/2+2,height/2-10,1.5]){
            cube([3,4,16],center=true);//on-off
            translate([-2,0,0]){
                cube([4,2.5,16],center=true);//
            }
        }
        translate([width/2-1,-height/2+9,1.5]){
            cube([5,4,16],center=true);//right
        }
        translate([-width/2+1,-height/2+10,1.5]){
            cube([5,4,16],center=true);//left
        }
        translate([width/2-1,-height/2+15,1.5]){
            cube([5,4,16],center=true);//select
        }

        //ir
        hull(){
            translate([width/2-15,height/2-4,-0.1]){
                cube([6,1.5,0.1],center=true);//select
            }
            translate([width/2-15,height/2-4.5,2.1]){
                cube([7,2,0.1],center=true);//select
            }
        }
        //ecg
        hull()
        {
            translate([0.5,-height/2+4.5,2.5]){
                cube([26,10,.1],center=true);//select
            }
            translate([0.5,-height/2+4.5,.5]){
                cube([24,9,.1],center=true);//select
            }
        }
    }
}

// button cover

translate([width/2+2,-height/2+15,1]){
    cube([2.4,2,2],center=true);          //select
    translate([0.9,.5,-1]){
        cube([1.4,6.5,4],center=true);
    }
    hull(){                               // spring
        translate([1.3,3.8,-1]){
            cube([.5,.1,4],center=true);
        }
        translate([-1,10.1,-1]){
            cube([.2,1,4],center=true);
        }
    }
}

translate([width/2+2,-height/2+9,1]){
    cube([2.4,2,2],center=true);          //right
    translate([0.9,-.5,-1]){
        cube([1.4,6.5,4],center=true);
    }
    hull(){                               // spring
        translate([1.3,-3.8,-1]){
            cube([.5,.1,4],center=true);
        }
        translate([-1.1,-7.3,-1]){
            cube([.2,1,4],center=true);
        }
    }
}

translate([-width/2-2,-height/2+10,1]){
    cube([2.4,2,2],center=true);          //left
    translate([-0.9,0,-1]){
        cube([1.4,7,4],center=true);
    }
    hull(){                               // spring
        translate([-1.3,-3.5,-1]){
            cube([.5,.1,4],center=true);
        }
        translate([1.1,-8.3,-1]){
            cube([.2,1,4],center=true);
        }
    }
}

translate([-width/2-2,height/2-24,1]){ // triangle above left button
    hull(){
        translate([0,2.5,-1]){
            cube([3,.1,4],center=true);
        }
        translate([1.5,11.5,-1]){
            cube([.5,1,4],center=true);
        }
    }
}






