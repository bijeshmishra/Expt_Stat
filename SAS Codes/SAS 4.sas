DM 'LOG; CLEAR; ODSRESULTS; CLEAR;';
TITLE 'Split plot Assignment 4 Height';
DATA sas4;
INPUT rep water color $ height width;
/* WP = Water, SP = Color, Blocks = Rep, Response = height & Width */
DATALINES;
1 1 Red 10.4641 18.9764 
1 1 White 8.6361 18.5999
1 1 Coral 8.6836 17.6397
1 2 Red 11.2051 22.5655 
1 2 White 11.5241 21.1620
1 2 Coral 7.9262 16.5507
2 1 Red 15.3595 16.6630
2 1 White 14.7127 16.7290
2 1 Coral 13.4858 16.6223
2 2 Red 16.5188 20.3693 
2 2 White 15.3492 19.2496
2 2 Coral 13.1782 17.4857
3 1 Red 14.2442 13.8697
3 1 White 15.2705 12.3667
3 1 Coral 14.8693 10.9506
3 2 Red 14.1018 17.2177
3 2 White 13.8954 16.5381
3 2 Coral 10.4144 13.6593 
4 1 Red 11.4202 15.3572
4 1 White 8.4697 14.8884
4 1 Coral 8.6994 13.6597
4 2 Red 15.9493 20.9637
4 2 White 15.1878 21.5276
4 2 Coral 11.7707 17.3201
;
/* Height */
PROC GLIMMIX DATA=sas4 NOBOUND PLOTS = RESIDUALPANEL;
CLASS rep water color; /* Block, Whole Plot, Sub Plot */
MODEL height = water | color / DDFM=SATTERTH; /*WP SP WP*SP */
RANDOM rep rep*water; /*WPBlock WPBlock*SP */ 
LSMEANS water color / LINES ADJUST = TUKEY PDIFF; /* N/A IF SIGNIFICANT INTERACTION */
LSMEANS water*color / ADJUST = TUKEY LINES PDIFF SLICE =(water color) ALPHA = 0.05 PLOTS = MEANPLOT(SLICEBY = water JOIN);
RUN; QUIT;

PROC SORT DATA=sas4;
BY water color;

PROC MEANS DATA = sas4 NOPRINT;
BY water color;
VAR height;
OUTPUT OUT=plotdata1 MEAN = MeanYield1;
GOPTIONS FTEXT="Arial";

PROC GPLOT DATA = plotdata1 ;
PLOT meanyield1*water = color ; *Or, PLOT meanyield*trt=seed ;
TITLE3 'Interaction Plot'; 
SYMBOL1 VALUE=circle CV=BLUE I=join L=1 W=2 H=2;
SYMBOL2 VALUE=dot    CV=RED I=join L=3 W=2 H=2;
SYMBOL3 VALUE=square CV=GREEN I=join L=8 W=2 H=2;
RUN; QUIT;

TITLE 'Split plot Assignment 4 Width';
/* Width */
PROC GLIMMIX DATA=sas4 NOBOUND PLOTS = RESIDUALPANEL;
CLASS rep water color; /* Block, Whole Plot, Sub Plot */
MODEL width = water | color / DDFM=SATTERTH; /*WP SP WP*SP */
RANDOM rep rep*water; /*WPBlock WPBlock*SP */ 
LSMEANS water color / LINES ADJUST = TUKEY PDIFF; /* N/A IF SIGNIFICANT INTERACTION */
LSMEANS water*color / ADJUST = TUKEY LINES PDIFF SLICE =(water color) ALPHA = 0.05 PLOTS = MEANPLOT(SLICEBY = water JOIN);
RUN; QUIT;

PROC SORT DATA=sas4;
BY water color;

PROC MEANS DATA = sas4 NOPRINT;
BY water color;
VAR width;
OUTPUT OUT=plotdata2 MEAN = MeanYield2;
GOPTIONS FTEXT="Arial";

PROC GPLOT DATA = plotdata2 ;
PLOT meanyield2*water = color ; *Or, PLOT meanyield*trt=seed ;
TITLE3 'Interaction Plot'; 
SYMBOL1 VALUE=circle CV=BLUE I=join L=1 W=2 H=2;
SYMBOL2 VALUE=dot    CV=RED I=join L=3 W=2 H=2;
SYMBOL3 VALUE=square CV=GREEN I=join L=8 W=2 H=2;
RUN; QUIT;
