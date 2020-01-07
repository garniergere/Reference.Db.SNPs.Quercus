################################################################################################
# structure.SD.CI.anyK.plot.K=2only.R: R script for STRUCTURE output Post-treatment
# P. Garnier-Géré (used in Lang et al. 2018 BioRxiv)
# Performs correct matching across replicates of inferred clusters (due to random number attribution in STRUCTURE)
# Functions A) and B) below work for any K (a priori cluster nb) and any replicate files available from STRUCTURE.
# The criteria used are the minimum differences among matrices of Q values or their bounds across replicates.
# So incorrect matching could still occur in the case of very weakly defined or redundant or badly represented clusters
# which are issues which would need to be addressed first.
# The script has been written with STRUCTURE version v2.3.3 (Falush et al. 2003) in mind for one argument of script B)=stru.out.2.ci :
# this argument is called lines.2.skip and can easily be changed

# A) Function stru.out.2.sd -> Imports Q values and computes standard deviations (sd) across replicate runs
# B) Function stru.out.2.ci -> Imports Q values and Bayesian credible intervals (CI) values, computes mean upper/lower bound values, or min/max bound values
#   of CI across STRUCTURE replicate runs, assumes that CI have been asked before running STRUCTURE, and that the minimum differences criteria across
# matrices allows to match inferred clusters and CI bounds.
#
# Input files for A) & B) = output files from STRUCTURE replicate runs with the "_f" or "_q" suffix, which must be in the same folder
# Output files: dataframes with mean Q values, and their sd or CI that can be further used for Plots using FUN C)

# C) Function stru.plot.sd.bci.k2: plots STRUCTURE results with the different types of "confidence" intervals defined above around mean Q values
    # implemented for k=2 only in this version

# usage: to reproduce the plots given on the website,
# download the zip with Structure output file examples under .../STRU-output and the R script structure.SD.CI.anyK.plot.K=2only.R
# open the program in a R editor from your working dir, run the FUN codes A), B) and C) below and apply them
# as in the following examples. The functions can be easily modified to be used as standalone R script.

# Example of usage for Function stru.out.2.sd (A) : just run one of 2 lines below
# mean.sd<-stru.out.2.sd(in.folder="STRU-output/541rand",res.id="new",k=2)
# mean.sd<-stru.out.2.sd(in.folder="STRU-output/1785-K3-rand",res.id="new",k=3) # mean.sd is the R dataframe returned by the script, also printed in the in.folder
        # Example of argument values (see details below within the FUN code):
        # in.folder="STRU-output/541rand";res.id="b";k=2
        # in.folder="STRU-output/1785-K3-rand";res.id="b";k=3

# Example of usage for Function stru.out.2.ci (A) : just run one of 2 lines below
# outci<-stru.out.2.ci(in.folder="STRU-output/541rand",bci.size=90,lines.2.skip=49,ind.nb=24,res.id="a",k=2)
# outci<-stru.out.2.ci(in.folder="STRU-output/1785-K3-rand",bci.size=90, lines.2.skip=49,ind.nb=24,res.id="a",k=3)
        # Example of argument values (see details below within the FUN code):
        # in.folder="STRU-output/541rand";res.id="b";k=2 ;bci.size=90; lines.2.skip=49;ind.nb=24
        # in.folder="STRU-output/1785-K3-rand";res.id="bn";k=3 ;bci.size=90; lines.2.skip=49;ind.nb=24

# Example of usage for Function stru.plot.sd.bci.k2 (C) :  run the line below
# ex.plot<-stru.plot.sd.bci(strudat=outci,plot.type="bci",mean.ci.bar=T,ind.nb=24,rep.nb=10,k=2,pol.nb=541,pol.type="SNPs",samp.set="random",ang.xlabel=45,col.title="black",col.cluster=c("blue","pink"),leg.pos=c(.8,.4),title.plot=T,hjust.val=0.5,vjust.val=NULL,hplot.out=4,wplot.out=6,silent=F)
        # the line above produces the pdf plot provided STRU.plot.bci.541.random.pdf
        # Example of argument values (see details below within the FUN code):
        # strudat=outci # outci is the R dataframe previously obtained with FUN stru.out.2.ci
        # for the other pdf example plot given: "strudat<-mean.sd" is used = output of FUN (A), with argument "plot.type<-"sd" and col.cluster=c("blue","green")

######################################################################
 # needed Libraries
 library("ggplot2")
 library("gtools")  # for permutations FUN
 library("plyr")
 library("reshape2")

### A) Function stru.out.2.sd
stru.out.2.sd<-function(in.folder,res.id="a",k=2) { 
   # Arguments:
   # in.folder = path for a folder below the working directory, for ex "STRU-output/rand541" where all output files from
   # STRUCTURE are located in the example provided
   # res.id = result dataset suffix, allows to use FUN in a loop & index res files if needed
   # result dataset are printed in the same in.folder

# 1) Identify list of _q files, load them in a list
 files<-list.files(in.folder, all.files=FALSE,full.names=FALSE, recursive=FALSE, pattern=paste("_q","$",sep=""))
 if (length(files)==0) { cat("ERR: in.folder needs to include STRUCTURE _q output files", "\n")
 } else {
 dat.list<-lapply(paste(in.folder,"/",files,sep=""), read.table, row.names=NULL, header=FALSE,sep="")
 # names(dat.list)<-files # rename each list element
 rep.nb<-length(dat.list)

# 2) permuting columns in replicate files for matching clusters if needed 
dat1<-dat.list[[1]][,-1]  # first replicate file to compare to all other replicates, removing ind column
                          # gives numbering of clusters
 if (rep.nb>1) {
   for (rep in 2:rep.nb) {  
     dat<-dat.list[[rep]][,-1]  
     cc<- paste("V",2:(k+1),sep="")                      # vec of cluster col names , depends on k
     ccol<-permutations(n=k,r=k,v=cc,repeats.allowed=F ) # picking all k col without replacement
     difvec<-NULL
     for (i in 1:dim(ccol)[1]) {                         # loop across possible combinations of column clusters
        difvec<-c(difvec, sum( abs(dat1-dat[,ccol[i,]]) ) )
     }
     cool.nb.ok<- which(difvec==min(difvec))             # identifying best combination and reshuffling if needed
     dat.list[[rep]]<-dat.list[[rep]][,c("V1",ccol[cool.nb.ok,])]  
     colnames(dat.list[[rep]])<-c("V1",colnames(dat1))   # renaming col to initial colnames matched to
   } 
 } else cat("only one replicate","\n")

# 3) in dat.list with matching cluster columns, compute mean Q values & sd per cluster col across ind 
 datall<-do.call(rbind,dat.list)  
  meanc<-ddply(datall,"V1",function(df)colMeans(df[,-1]))  
  # for plotting, need ad hoc adjustment across mean Qvalues so that the sum = 1,
   sumc<- ddply(meanc,"V1",function(df)sum(df[,-1])) # sums should be close to 1 (always the case for k=2), Warning if some values are not
   if  ( (max(abs(sumc$V1))-1) > (0.02*k) ) cat("WARNING: one or more mean Q_values sums depart(s) from 1 by more than",0.02*k,"\n")
   meanc.adj <-cbind("V1"=meanc$V1,as.data.frame(t(aaply(as.matrix(meanc[,-1]),2,function(df)(df-as.matrix((sumc-1)/k))))) )
   col.sd<-function(df) { sapply(df, function(df)  sd(df)  ) } 
   sdc<-ddply(datall,"V1",function(df)col.sd(df[,-1]))
   mean.sd<-merge(meanc.adj,sdc,by.x="V1",by.y="V1",all.x=T, all.y=T, sort=T)
   colnames(mean.sd)<-c("ind",paste("mQval.c",1:k,sep=""),paste("sd.Qval.c",1:k,sep=""))
 # save as text file
   outfile<-paste("m.sd-k",k,"-",rep.nb,"-",res.id,".txt",sep="")
      write.table(mean.sd,file=paste(in.folder,"/",outfile,sep=""),append=FALSE,quote=FALSE,sep="\t",col.names=TRUE, row.names=FALSE)
  return (mean.sd)
 }
}   # end FUN stru.out.2.sd

# B) Function stru.out.2.ci
stru.out.2.ci<-function(in.folder,bci.size=90,lines.2.skip=49,ind.nb=24,res.id="a",k=2) { 
 # Arguments:
 # in.folder = as in stru.out.2.sd function above
 # bci.size: given probability in % at which confidence intervals have been requested in STRUCTURE
 # ind.nb: nb of individuals, i.e. nb of lines to load after the ones skipped in _f STRUCTURE files
 # res.id = result dataset suffix, allows to use FUN in a loop & index res files
 # lines.2.skip: lines to skip in _f files apart from the ones corresponding to clusters, assumed to be 49 by default for STRUCTURE version v2.3.3 (Falush et al. 2003)
 # + a number of lines that depends on 2*k, to be checked when calling the FUN and to change if different.
 # The function returns a dataframe which is printed in the same in.folder

# 1) Identify list of _q/_f files from STRUCTURE and load them in a list

files.q<-list.files(in.folder, all.files=FALSE,full.names=FALSE, recursive=FALSE, pattern=paste("_q","$",sep=""))
files.f<-list.files(in.folder, all.files=FALSE,full.names=FALSE, recursive=FALSE, pattern=paste("_f","$",sep=""))
 if ( length(files.q)==0 | length(files.f)==0) {
 cat("ERROR: in.folder needs to include Both STRUCTURE _q and _f output files when using this function", "\n")
 } else {

# 2) load _q files & permuting columns in replicate files for matching clusters if needed 
  dat.list.q<-lapply(paste(in.folder,"/",files.q,sep=""), read.table, row.names=NULL, header=FALSE,sep="")
  #names(dat.list.q)<-files.q
  rep.nb.q<-length(dat.list.q)

  dat1<-dat.list.q[[1]][,-1]  
   if (rep.nb>1) {
    for (rep in 2:rep.nb) {
      dat<-dat.list.q[[rep]][,-1] 
      cc<- paste("V",2:(k+1),sep="") 
      ccol<-permutations(n=k,r=k,v=cc,repeats.allowed=F )
      difvec<-NULL   
      for (i in 1:dim(ccol)[1]) {
        difvec<-c(difvec, sum( abs(dat1-dat[,ccol[i,]]) ) )
      }
      cool.nb.ok<- which(difvec==min(difvec))
      dat.list.q[[rep]]<-dat.list.q[[rep]][,c("V1",ccol[cool.nb.ok,])]
      colnames(dat.list.q[[rep]])<-c("V1",colnames(dat1)) 
   }
 } else cat("only one replicate","\n")

# 3) Load _f files with scan in a list, clean & reformat
 dat.list.f<-lapply(paste(in.folder,"/",files.f,sep=""), scan, what=character(0), sep="\n",skip=(lines.2.skip+2*k),nlines=ind.nb,quiet=TRUE)
 rep.nb.f<-length(dat.list.f)

# 3a) Condition to check that nb of replicates is the same in _q and _f files
 if (rep.nb.f!=rep.nb.q) { cat("ERR: number of replicates from _q files differ from those from _f files", "\n")
 } else {
# 3b) cleaning list of df
 rem.semicol<-function(x) gsub(pattern=":", replacement="", x, fixed=TRUE)   # x is a vector
 rem.brack.left<-function(x) gsub(pattern="(", replacement="", x, fixed=TRUE)
 rem.brack.right<-function(x) gsub(pattern=")", replacement="", x, fixed=TRUE)
 rep.coma.ws<-function(x) gsub(pattern=",", replacement=" ", x, fixed=TRUE)
 dat.list2<-llply(dat.list.f,rem.semicol)
 dat.list3<-llply(dat.list2,rem.brack.left)
 dat.list4<-llply(dat.list3,rem.brack.right)
 dat.list5<-llply(dat.list4,rep.coma.ws)
 dat.list6<-llply(dat.list5,strsplit, split=" ")

 # reforming full list
   for (j in 1:length(dat.list6)) {
     datf[j]<-list( (ldply(dat.list6[[j]],remove.empty.str.in.vec))[,-1] )
   }

# 3c) Extract Bayesian CI from df list, convert values into numeric values & match CI of same inferred clusters among replicates…
 col.ci<-paste("V",((k+4):(3*k+3)),sep="") 
 datf.ci<-llply(datf,function(df) df[,c("V2", col.ci) ] ) 
 datf.ci.num<-llply(datf.ci,function(df1) sapply(df1[,-1], function(x) as.numeric(as.character(x)) ) )

 dat1<-datf.ci.num[[1]]  
 if (rep.nb.f>1) {
   for (rep in 2:rep.nb.f) {
     dat<-datf.ci.num[[rep]]  
     ccol<-permutations(n=2*k,r=2*k,v=col.ci,repeats.allowed=F )
     difvec<- NULL   # criteria for finding correct permutation
     for (i in 1:dim(ccol)[1]) { 
       difvec<-c(difvec, sum( abs(dat1-dat[,ccol[i,]]) ) )   
     }
     cool.nb.ok<- which(difvec==min(difvec)) # identifies correct matching combination of columns
     datf.ci.num[[rep]]<-datf.ci.num[[rep]][,ccol[cool.nb.ok,]]
     colnames(datf.ci.num[[rep]])<-colnames(dat1) # renaming col to initial colnames to match to
   }
 } else cat("only one replicate","\n")

 # 4) merge dat.list.q  & datf.ci.num with matching columns identifying clusters
 datall.ci<-cbind( do.call(rbind,dat.list.q) , do.call(rbind,datf.ci.num) )

 # 5) compute mean Qval, mean/min/max of lower/upper bounds of CI
 ccq<-paste("V",2:(k+1),sep="")  #k=3
 meanci<-ddply(datall.ci,"V1",function(df)colMeans(df[,-1][,ccq])) # since ccq here, no need lines below
 sumci<- ddply(meanci,"V1",function(df)sum(df[,-1]) ) # need to adjust the mean Qvalues so that the sum = 1 for plots,
                                                      #  Warning if sums are not close to 1
 if  ( (max(abs(sumci$V1))-1) > (0.02*k) ) cat("WARNING: one or more mean Q_values sums depart(s) from 1 by more than",0.02*k,"\n")
 meanci.adj <-cbind( "V1"=meanci$V1,as.data.frame(t(aaply(as.matrix(meanci[,-1]),2,function(df)(df-as.matrix((sumci-1)/k))))) )

   # mean of lower & upper bounds separately for renaming easily all col below
 mean.df<-function(df) { sapply(df, function(x)  mean(x)  ) }
 mean.lb<-ddply(datall.ci,"V1",function(df) mean.df(df[,-1][ col.ci[seq(1,length(col.ci),by=2)] ] ) )
 mean.ub<-ddply(datall.ci,"V1",function(df) mean.df(df[,-1][ col.ci[seq(2,length(col.ci),by=2)] ] ) )
 mean.lbub<-merge(mean.lb,mean.ub,by.x="V1",by.y="V1",all.x=T, all.y=T, sort=T)
   # min/max of lower & upper bounds for each individual across replicates in datall.ci
 min.df<-function(df) { sapply(df, function(x)  min(x)  ) }  #for test   df<-datall[which(datall$V1=="a"),][,-1]
 max.df<-function(df) { sapply(df, function(x)  max(x)  ) }
 min.lb<-ddply(datall.ci,"V1",function(df) min.df(df[,-1][ col.ci[seq(1,length(col.ci),by=2)] ] ) )
 max.ub<-ddply(datall.ci,"V1",function(df) max.df(df[,-1][ col.ci[seq(2,length(col.ci),by=2)] ] ) )
 minmax.lbub<-merge(min.lb,max.ub,by.x="V1",by.y="V1",all.x=T, all.y=T, sort=T)

 mmm.ci<-cbind(meanci.adj,mean.lbub[,-1],minmax.lbub[,-1] )
 colnames(mmm.ci)<-c("ind",paste("mQval.c",1:k,sep=""),paste("m",bci.size,".lbc",1:k,sep=""),paste("m",bci.size,".ubc",1:k,sep=""),
 paste("min",bci.size,".lbc",1:k,sep=""),paste("max",bci.size,".ubc",1:k,sep="") )

 # 6) save as text file
 outfile<-paste("mmm.ci-k",k,"-",rep.nb,"-",res.id,".txt",sep="")
 write.table(mmm.ci,file=paste(in.folder,"/",outfile,sep=""),append=FALSE,quote=FALSE,sep="\t",col.names=TRUE, row.names=FALSE)
 return (mmm.ci)
 } # end condition nb rep for _q files == that for _f files
 } # end cond empty file lists
} # end FUN stru.out.2.ci

# C) Function for plotting STRUCTURE results with different types of CI around mean Q values
stru.plot.sd.bci<-function(strudat=outci,plot.type=c("sd","bci"),mean.ci.bar=T,ind.nb=24,rep.nb=10,k=2,
pol.nb=1741,pol.type="SNPs",samp.set="same",ang.xlabel=45,col.title="black",col.cluster=c("blue","green"),
leg.pos=c(c(.85,.15),"none"),title.plot=T,hjust.val=0.5,vjust.val=NULL,hplot.out=4,wplot.out=6,silent=F) {

        # Arguments:
        # strudat: output dataframe (df) from stru.out.2.ci or stru.out.2.sd functions
        # plot.type: if "sd"/"bci" will assume that strudat is a stru.out.2.sd/ci df and as/bci around mean Q values are plotted
        # plots uses given individuals names from these df, or change them in df before
        # mean.ci.bar: if T (resp. F), BCI are plotted with mean upper & lower (resp. maximum upper & minimum lower) values across replicates, else
        # bci.size: % of credible interval considered
        # silent: F by default so comments might be printed on the screen, otherwise put silent=T
        # col.cluster=c("blue","green"): vector of colours for cluster list
        # leg.pos : position of legend for cluster colours / x & y axes, if "none", no legend will be printed
        # hplot.out=4: height of pdf plot output ex 4 cm
        # wplot.out=6: width of pdf plot output ex 6 cm
        # ang.xlabel: angle with which x axis label are printed on the plot, ex: 45°

        # all arguments below are used for the legend plot, they can easily be modified in the script
        # rep.nb: replicate number (for legend of the plot only)
        # pol.nb: number of polymorphisms used in STRUCTURE runs
        # pol.type: type of polymorphisms (for example: "SNPs", "Microsatellites", "SSRs" etc..., any character chain can be used)
        # samp.set: "same" is the default MCMC sampling in STRUCTURE when asking for replicates,
        # but other types such as genetic resampling among available markers as in the Lang et al. study can be used,
        # i.e. each replicate can be a random sample of polymorphisms across independent blocks

if (k==2) {
    ## 1) Plot of SD around mean Q values
  if (plot.type=="sd") {
   if (silent==F) {
     Sys.sleep(0.1); cat(" Plot of individuals mean Q_values with standard deviations across replicates,","\n","assumes input file is from stru.out.2.sd FUN","\n","and normal distribution of Q-values for 95% confidence intervals ","\n")
   flush.console() }
    
     # 1a) use "melt" to reformat sd data

   # mean.sd.sorted<-strudat[order(strudat[,2]*strudat[,3],strudat[,k]*strudat[k*1]),]
   # mean.sd.sorted<-strudat[order(strudat[,2]),]  # order / first cluster mean Q values
    sum.mQ<-colMeans(strudat[,c(2:(k+1))])
    mean.sd.sorted<-strudat[order(strudat[,(1+max(rank(sum.mQ)))],strudat[,max(rank(sum.mQ))]),]
    mq.sort<-mean.sd.sorted[,1:(k+1)]
    msd.sort<-mean.sd.sorted[,c(1,(k+2):(2*k+1))]
    melt.q<-melt(mq.sort,id=c("ind"))
    colnames(melt.q)<-c("ind","cluster","mean.Qvalue")

    # 1b) prep ggplot2 files & additions
    meltqsd<-merge(melt.q,msd.sort, by.x="ind",by.y="ind",all.x=T, all.y=T, sort=T)
    meltq.sd.sort<-meltqsd[order(meltqsd$cluster,meltqsd$mean.Qvalue),]
    if (k>2) {  # if k>2 replace ck sd cluster values in sd.Qval.c1 variable used for plot
      for (i in 2:(k-1)) { #i<-2
         meltq.sd.sort[which(meltq.sd.sort$cluster==paste("mQval.c",i,sep="")),"sd.Qval.c1"]<-
         meltq.sd.sort[which(meltq.sd.sort$cluster==paste("mQval.c",i,sep="")),paste("sd.Qval.c",i,sep="")]
      }
    }
    meltq.sd.sort[which(meltq.sd.sort$cluster==paste("mQval.c",k,sep="")),"sd.Qval.c1"]<-NA   # NA in the last cluster for sd values
    meltq.sd.sort<-meltq.sd.sort[,1:4]   # keep plotting variables
    meltq.sd.sort$ind<-factor(meltq.sd.sort$ind,levels=as.vector(mean.sd.sorted[,"ind"])) # fix the factor sorting for ggplot2

    # 1c) Plot with "ggplot2"  with 1.96*sd as geom_bar
    p<-ggplot(data=meltq.sd.sort, aes(x=ind, y=mean.Qvalue, fill=cluster)) + geom_bar(stat="identity") +
    geom_errorbar(aes(ymin = mean.Qvalue-1.96*sd.Qval.c1, ymax = mean.Qvalue+1.96*sd.Qval.c1),
    width=0.4, size=0.75) + scale_fill_manual(values=col.cluster)
    # Background and title setup
    my.background<-theme(panel.background = element_rect(fill = "transparent",colour = NA),panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),plot.background = element_rect(fill = "transparent",colour = NA))

    if (title.plot==T) {
    tit<-labs(title = paste(rep.nb," replicates, ",pol.nb," ",pol.type,", ",samp.set," sampling",sep=""))
    modif.tit<-theme(plot.title = element_text(size = rel(0.9), colour = col.title))  # Set title to 90% of the base font size + colour
    }
   # 1d) below Axes setup and if legend wanted
    if (ind.nb<=30) {
    my.xaxis<- theme(axis.ticks.x=element_blank(),axis.text.x = element_text(colour="black",angle=as.numeric(ang.xlabel),hjust=hjust.val,vjust=vjust.val,size = rel(0.85)),legend.position = leg.pos)
    } else if (ind.nb>30 & ind.nb<=60) {
    my.xaxis<- theme(axis.ticks.x=element_blank(),axis.text.x = element_text(colour="black",angle=as.numeric(ang.xlabel),hjust=hjust.val,vjust=vjust.val,size = rel(0.7)),legend.position = leg.pos)
    } else if (ind.nb>60 & ind.nb<=150) {
    my.xaxis<- theme(axis.ticks.x=element_blank(),axis.text.x = element_text(colour="black",angle=as.numeric(ang.xlabel),hjust=hjust.val,vjust=vjust.val,size = rel(0.5)),legend.position = leg.pos)
    }
   # 1e) final plot wrap up
   if (title.plot==T) {
   stru.plot<-p + xlab(" ") + my.background + my.xaxis + tit + modif.tit
   } else { stru.plot<-p+xlab(" ")+ my.background + my.xaxis
   }   
   ggsave(paste("STRU.plot.sd.",pol.nb,".",samp.set,".pdf",sep=""),plot=stru.plot,height=hplot.out, width=wplot.out)
  } # end condition plot.type=="sd"

   # 2) plot of bci mean or min/max around mean Q values
  if (plot.type=="bci") {
    if (silent==F) {
      Sys.sleep(0.1)
      cat("Plot of individuals mean Q_values with Bayesian credible intervals","\n","assumes input file is from stru.out.2.ci","\n")
    flush.console()}
   
    # 2a) use "melt" to reformat ci data
    mean.ci.sorted<-strudat[order(strudat[,(1+max(rank(sum.mQ)))],strudat[,max(rank(sum.mQ))]),]
    mqci.sort<-mean.ci.sorted[,1:(k+1)]               # extract "ind" + mQ values col for melting
    mci.sort<-mean.ci.sorted[,c(1,(k+2):(4*k+k+1))]   # extract "ind" + mean /min/max ci values , for all clusters
    melt.q<-melt(mqci.sort,id=c("ind"))
    colnames(melt.q)<-c("ind","cluster","mean.Qvalue")
    
    # 2b) prep ggplot2 files & additions
    meltq<-merge(melt.q,mci.sort, by.x="ind",by.y="ind",all.x=T, all.y=T, sort=T)  # sort by "ind"
    meltq.sort<-meltq[order(meltq$cluster,meltq$mean.Qvalue),] 
    colnames(meltq.sort)[c(4,6,8,10)]<-c("mean.lb.c1", "mean.ub.c1", "min.lb.c1", "max.ub.c1") # no need info bci.size here
    meltq.sort$ind<-factor(meltq.sort$ind,levels=as.vector(mean.ci.sorted[,"ind"]) ) # fix the sorting for ggplot2

    meltq.sort[which(meltq.sort$cluster=="mQval.c2"),c(4,6,8,10)]<-NA
    # case for ci for c1 here --> 4 more column parts to fill with NA  OK works!!
   
    # 2c) Plot with "ggplot2"  # at this stage, the legend with cluster and how it is filled is on the right

    # with m.ci as geom_bar         
    if (mean.ci.bar==T) {
p<-ggplot(data=meltq.sort, aes(x=ind, y=mean.Qvalue, fill=cluster)) +
geom_bar(stat="identity")+ geom_errorbar(aes(ymin =mean.lb.c1, ymax =mean.ub.c1 ), width=0.4, size=0.75) +
scale_fill_manual(values=col.cluster)

    } else { # with min/max.ci as geom_bar, only other possibility
p<-ggplot(data=meltq.sort, aes(x=ind, y=mean.Qvalue, fill=cluster)) +
geom_bar(stat="identity")+ geom_errorbar(aes(ymin = min.lb.c1, ymax = max.ub.c1), width=0.4, size=0.75) +
scale_fill_manual(values=col.cluster)   
    }
   # Background and title setup
my.background<-theme(panel.background = element_rect(fill = "transparent",colour = NA),panel.grid.minor = element_blank(), panel.grid.major = element_blank(),plot.background = element_rect(fill = "transparent",colour = NA))
  if (title.plot==T) {
tit<-labs(title = paste(rep.nb," replicates, ",pol.nb," ",pol.type,", ",samp.set," sampling",sep=""))
modif.tit<-theme(plot.title = element_text(size = rel(0.9), colour = col.title))  # Set title to 90% of the base font size + colour
  } 
   # 2d) below Axes setup and if legend wanted
if (ind.nb<=30) {        
my.xaxis<- theme(axis.ticks.x=element_blank(),axis.text.x = element_text(colour="black",angle=as.numeric(ang.xlabel),hjust=hjust.val,vjust=vjust.val,size = rel(0.85)),legend.position = leg.pos)
} else if (ind.nb>30 & ind.nb<=60) {
my.xaxis<- theme(axis.ticks.x=element_blank(),axis.text.x = element_text(colour="black",angle=as.numeric(ang.xlabel),hjust=hjust.val,vjust=vjust.val,size = rel(0.7)),legend.position = leg.pos)  
} else if (ind.nb>60 & ind.nb<=150) { 
my.xaxis<- theme(axis.ticks.x=element_blank(),axis.text.x = element_text(colour="black",angle=as.numeric(ang.xlabel),hjust=hjust.val,vjust=vjust.val,size = rel(0.5)),legend.position = leg.pos)  
}

   # 2e) final plot wrap up
   if (title.plot==T) {
stru.plot<-p + xlab(" ") + my.background + my.xaxis + tit + modif.tit  
   } else { stru.plot<-p+xlab(" ")+ my.background + my.xaxis
   }   

#print(stru.plot)
ggsave(paste("STRU.plot.bci.",pol.nb,".",samp.set,".pdf",sep=""),plot=stru.plot,height=hplot.out, width=wplot.out)
  } # end condition plot.type=="bci"
return(stru.plot)

} else { if (silent==F) {
         Sys.sleep(0.1); cat("Current implementation of plot script only available for k=2, please check later","\n")
         flush.console() }
       }
} # end FUN
