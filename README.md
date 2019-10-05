# A cover generator for the CARD10 badge!
![different covers](/pics/card10_anim.gif) 
          
## Features
- more variations possible than you'll ever need!!!
- buttons become much more usable as they get a bigger surface
- the cover can be clipped onto the badge - there are no tools required to change the cover
- you can add a piece of clear plastic (e.g. cutout from a cheese packaging) as display protection 
- the model has no overhangs, thus it is very easy to print (except if you turn side led's on)
- you can turn off the randomization and generate exactly the cover that YOU want!
        
        
## How to use
- open this code in openSCAD (download from https://www.openscad.org/)
- specify whether you want a model with wristband or without (line 82) / the option
          with wristband also adds the wristband mounts to the watch cover
- if you want to print a wristband, specify the sircumference of your wrist in line 107
- specify from line 69 on which parts you want to generate 
- select in line 68 if you want to have the parts oriented ready for print or in the way they will be
          assembled later
- [optional]: adjust settings below in the section 'CUSTOMIZE YOUR COVER BY ADJUSTING VALUES BELOW:'
- hit the render button in openSCAD (the button above the code with the hourglass & the cube)
- hit the .stl export button right next to the render button
- print your .stl model!
        
        
## Printing instructions

- print upside down without support out of PLA
- recommended slicer settings: 
   0.2mm layer height
   0.4mm wall thickness / 1 wall
   100% infill 
   0.4mm extruder
  
  
## Assembly instructions

- clean up the print with a small utility knife
- [optional]: cut a 14mm x 30mm piece of clear plastic as display protection (e.g. from a pet-bottle) 
                      and place it inside the display cutout 
- If you printed a wristband: Glue FClip on the end of the bottom wristband (e.g. with superglue)
- connect MClip with the top wristband (with a paper clip as axle)
- connect both wristbands to the cover (with paper clips as axles)
- if you printed a bottom: Unscrew the four screws on the bottom of the Card10, 
          remove the stainless steel electrodes, add the bottom piece, add the electrodes, 
          add the screws again.
- clip the cover onto your card10 badge
- print another cover for your friends
          

## Wristband assembly

![](/pics/pac1.jpg)
![](/pics/pac2.jpg)
![](/pics/pac3.jpg)
![](/pics/pac4.jpg)
![](/pics/pac5.jpg)
![](/pics/pac6.jpg)
![](/pics/pac7.jpg)
![](/pics/pac8.jpg)
![](/pics/pac9.jpg)


## Examples

I added some stl files which were generated with Version 1 & 2 as examples. Here's a print of the model 1337haxx0r with all features unlocked:

![card10-model 1337haxx0r](/pics/P1770622.JPG)

All of the models feature a recessed display cutout where you can place a 30mm x 14mm transparent plastic piece as display protection.

![cover with plastic display protection](/pics/P1770635.JPG)

Here's the model 'functional style' with half diffusor after losing a round of Tetris:

![functional style](/pics/P1770665.JPG)

And here's a bunch of prints with different features. I cut out pieces from some food packaging for the screen protectors:

![different card10 cover prints](/pics/P1770695.JPG)

Thhere were plenty of test prints involved in making this work out nicely: 

![different card10 cover prints](/pics/P1770698.JPG)
