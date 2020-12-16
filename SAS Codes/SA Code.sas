DM 'LOG; CLEAR; ODSRESULTS; CLEAR; ';
DATA sas2; INPUT coating wear @@;
LABEL coating ='Layers of Coating' wear='Wear';
DATALINES;
0 21.0434 1 17.0270 2 13.2604 3 13.2798 4 13.9394
0 23.7164 1 15.1824 2 16.0983 3 14.6028 4 09.0165
0 26.3993 1 16.1865 2 15.1277 3 12.7176 4 15.5906
0 25.5745 1 15.2647 2 14.3230 3 11.7969 4 11.2414
0 23.2901 1 14.7997 2 14.5364 3 10.6507 4 10.0621
0 26.6883 1 16.0777 2 16.0863 3 14.3297 4 10.4367
0 24.8230 1 14.5333 2 13.7632 3 09.4774 4 13.6440
;
TITLE "ANOVA, Control Vs Rest, Tukey  Comparison, Trend Analysis, CI: 0.02";
PROC GLM DATA = sas2 PLOTS = NONE;
CLASS coating;
MODEL wear = coating;
/* Simultaneous Contrast: Method 1.1: SS != SSH0*/
CONTRAST '1 = 2'		 		coating 0 1 -1 0 0;  
CONTRAST '1 + 2 = 2*3'			coating 0 1 0 -1 0;
CONTRAST '1 + 2 + 3 = 3*4'		coating 0 1 0 0 -1;
/* Simultaneous Contrast: Method 1.2 (~ Method 1.1)*/
CONTRAST 'M1.2: 1 = 2 = 3 = 4 ' 		coating 0 1 -1 0 0,  
    									coating 0 1 0 -1 0,
			         					coating 0 1 0 0 -1;

/* Simultaneous Contrast: Method 2.1: SS = SSH0*/
CONTRAST '1 = 2'		 		coating 0 1 -1 0 0;  
CONTRAST '1 + 2 = 2*3'			coating 0 1 1 -2 0;
CONTRAST '1 + 2 + 3 = 3*4'		coating 0 1 1 1 -3;
/* Simultaneous Contrast: Method 2.2 (~ Method 2.1)*/
CONTRAST ' M2.2: 1 = 2 = 3 = 4 ' 		coating 0 1 -1 0 0,  
    									coating 0 1 1 -2 0,
			         					coating 0 1 1 1 -3;
TITLE3 'Simultaneous Contrast: Single Test, mean difference, Non Control Trts';
RUN; QUIT;
PROC GLM DATA = sas2 PLOTS = (BOXPLOT);
CLASS coating;
MODEL wear = coating;
/* Tukey Comparison of the Means */
MEANS coating / ALPHA = 0.02 LINES TUKEY CLDIFF;
/* Trend Values from Book Page 740. t = 5 */
CONTRAST "Linear Trend (x1)"	 		coating 	-2 -1 0 1 2;
CONTRAST "Quadratic Trend (x2)" 		coating 	2 -1 -2 -1 2;
CONTRAST "Cubic Trend (x3)" 			coating		-1 2 0 -2 1;
CONTRAST "Quartic Trend/LoF (x4)"		coating		1 -4 6 -4 1;
LSMEANS coating /STDERR;
TITLE3 ' Tukey Comparison of Mean and Trend Analysis'; RUN; QUIT;
PROC GPLOT DATA = sas2;
PLOT wear*coating / VAXIS = 8 12 16 20 24 28 HAXIS = 0 1 2 3 4; 
SYMBOL1 VALUE = # CV = RED I = NONE;
TITLE2 ' Trend Analysis Using GPLOT'; RUN; QUIT;

PROC SGPLOT DATA = sas2;
SCATTER Y = wear X = coating;
TITLE2 "SGPLOT option for Statistical Graphing"; RUN; QUIT;
