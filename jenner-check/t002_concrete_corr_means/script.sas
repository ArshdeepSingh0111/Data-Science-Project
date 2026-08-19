/* Adapted from "Project final draft code.sas" (ArshdeepSingh0111/Data-Science-Project).
   PROC IMPORT of Concrete_Strength.xls is replaced with an inline sample of the same
   nine columns. Everything from the "author's original logic" marker down is the
   author's own code, unmodified: the age-quartile flag (Q), the log-transform (lop),
   the correlation matrix across all mix components + Q + lop, and PROC MEANS with
   the exact statistics list they requested (mean std stderr clm min p25 p50 p75 max n). */

data Concrete_Strength;
  input Cement__component_1__kg_in_a_m_3
        Blast_Furnace_Slag__component_2_
        Fly_Ash__component_3__kg_in_a_m_
        Water___component_4__kg_in_a_m_3
        Superplasticizer__component_5__k
        Coarse_Aggregate___component_6__
        Fine_Aggregate__component_7__kg_
        Age__day_
        Concrete_compressive_strength_MP;
  datalines;
540.0 0.0 0.0 162.0 2.5 1040.0 676.0 28 79.99
332.5 142.5 0.0 228.0 0.0 932.0 594.0 270 40.27
332.5 142.5 0.0 228.0 0.0 932.0 594.0 365 41.05
198.6 132.4 0.0 192.0 0.0 978.4 825.5 360 44.30
266.0 114.0 0.0 228.0 0.0 932.0 670.0 90 47.03
380.0 95.0 0.0 228.0 0.0 932.0 594.0 365 36.45
380.0 95.0 0.0 228.0 0.0 932.0 594.0 28 39.29
266.0 114.0 0.0 228.0 0.0 932.0 670.0 28 44.28
475.0 0.0 0.0 228.0 0.0 932.0 594.0 28 33.40
198.6 132.4 0.0 192.0 0.0 978.4 825.5 90 32.85
159.1 186.7 0.0 175.6 11.3 989.6 788.9 91 43.70
190.0 190.0 0.0 228.0 0.0 932.0 670.0 28 38.02
304.0 76.0 0.0 228.0 0.0 932.0 670.0 28 42.13
139.6 209.4 0.0 192.0 0.0 1047.0 806.9 180 42.62
342.0 38.0 0.0 228.0 0.0 932.0 670.0 270 41.68
374.0 0.0 0.0 190.0 0.0 1013.0 730.0 56 33.02
159.1 186.7 0.0 175.6 11.3 989.6 788.9 28 41.68
183.9 122.6 0.0 203.5 0.0 958.2 800.1 91 27.42
251.4 0.0 118.3 188.5 6.4 1028.4 757.7 28 21.86
425.0 106.3 0.0 151.4 18.6 936.0 803.7 3 15.34
;
run;

/* --- author's original logic below, unmodified --- */
data s1;
set Concrete_Strength;
Q=0;
if Age__day_ >=(91)<=183then Q=1;
if Age__day_  >=184<=274 then Q=2;
if Age__day_ >=275<=365 then Q=3;
lop=log(Concrete_compressive_strength_MP);
run;
Title 'Corr matrix for Stregnth';
proc corr;
var Cement__component_1__kg_in_a_m_3 Blast_Furnace_Slag__component_2_ Fly_Ash__component_3__kg_in_a_m_ Water___component_4__kg_in_a_m_3 Superplasticizer__component_5__k Coarse_Aggregate___component_6__ Fine_Aggregate__component_7__kg_ Age__day_ Concrete_compressive_strength_MP Q lop ;
run;
PROC MEANS mean std stderr clm min p25 p50 p75 max n;
RUN;
