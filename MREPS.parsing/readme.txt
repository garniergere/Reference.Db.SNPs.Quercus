Utilization of the script mreps.parsing.R with the example provided:

# 1) download the out.mr20seq-A.txt & out.mr20seq-B.txt (output files processing 20 sequences each, extracted from Appendix-S4.fas, 
# & obtained with MREPS so input files for MREPS were AppS4-ext-20cons-n+del.as.polyC-A.fas and ...-B.fas, with the constraint that the "c"
# character replaces poly"n" & deletions in fas sequence for MREPS to work, so these will be detected in the MREPS outputs as homopolymers)
# 2) Copy them in your working dir with the R script mreps.parsing.r
# 3) download the R script and run it in command line with the input files given as examples in the same directory (alternatively, change the "txt.folder" argument of the mreps.parse FUN in the script where MREPS output txt files would be copied)).
# or open the script in an R editor and run it from there.

# mreps.df.txt is the script output which can be seen in Xcell or OpenOffice
# Arguments other than folder name can also be changed in the script, see within the script for more information on the arguments.
