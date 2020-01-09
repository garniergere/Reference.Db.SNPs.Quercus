## How to use the structure.SD.CI.anyK.plot.K=2only.R script and reproduce the plots given online, based on STRUCTURE results 
## with Qvalues SD or BCI (Bayesian confidence Intervals?

# 1) download the zip with Structure output file examples under .../STRU-output and the R script structure.SD.CI.anyK.plot.K=2only.R
# 2) unzip them and copy them in a subfolder of the same name (or modify the script for in.folder arguments)
# 3) Open the program in a R editor from your working dir (above .../STRU-output folder), and run the script.

# alternatively, run FUN codes A), B) and C) and apply them as in the following examples. 
# (The functions can be easily modified so that the script is used as standalone with trailing arguments)

# Example of use for stru.out.2.sd FUN (A) : just run one of 2 lines below
# mean.sd<-stru.out.2.sd(in.folder="STRU-output/541rand",res.id="new",k=2)
# mean.sd<-stru.out.2.sd(in.folder="STRU-output/1785-K3-rand",res.id="new",k=3) # mean.sd is the R dataframe returned by the script,
# also printed in the in.folder
        # Example of argument values (see details within the FUN code):
        # in.folder="STRU-output/541rand";res.id="b";k=2
        # in.folder="STRU-output/1785-K3-rand";res.id="b";k=3

# Example of use for Function stru.out.2.ci (B) FUN : just run one of 2 lines below
outci<-stru.out.2.ci(in.folder="STRU-output/541rand",bci.size=90,lines.2.skip=49,ind.nb=24,res.id="a",k=2)
# outci<-stru.out.2.ci(in.folder="STRU-output/1785-K3-rand",bci.size=90, lines.2.skip=49,ind.nb=24,res.id="a",k=3)
        # Example of argument values (see details below within the FUN code):
        # in.folder="STRU-output/541rand";res.id="b";k=2 ;bci.size=90; lines.2.skip=49;ind.nb=24
        # in.folder="STRU-output/1785-K3-rand";res.id="bn";k=3 ;bci.size=90; lines.2.skip=49;ind.nb=24

# Example of usage for Function stru.plot.sd.bci.k2 (C) :  
# run the line below for a plot using outci = the R dataframe previously obtained with FUN (B) stru.out.2.ci above
ex.plot<-stru.plot.sd.bci(strudat=outci,plot.type="bci",mean.ci.bar=T,ind.nb=24,rep.nb=10,k=2,pol.nb=541,pol.type="SNPs",samp.set="random",ang.xlabel=45,col.title="black",col.cluster=c("blue","pink"),leg.pos=c(.8,.4),title.plot=T,hjust.val=0.5,vjust.val=NULL,hplot.out=4,wplot.out=6,silent=F)
# the line above produces the pdf plot provided online STRU.plot.bci.541.random.pdf 
# for the other pdf example, run the line for function (C) above with arguments: "strudat<-mean.sd" is used = output of FUN (A), 
# "plot.type<-"sd" and col.cluster=c("blue","green").
