################################################################################################
# mreps.parsing.R
# P. Garnier-Géré (used in Lang et al. 2018 BioRxiv)
# script for parsing one or more MREPS software output text files
# (MREPS allows the identification of SSR motifs according to various parameter values,
#  and uses fasta files as input  , see https://mreps.univ-mlv.fr )
# the output of the script is a text file which can easily be viewed in Xcell or OpenOffice named "mreps.df.txt",
# the first column identifying the name(s) of the MREPS output file(s)

# A) FUN rem.charel
       # removes char string elements organised in a vector, from a longer char string
       # corresponding to lines in a txt file for example

# B) FUN mreps.chvec.2.df
       # restructures simpler character strings from mreps output file into a df organized with
       # one line per sequence (with an identifier that must be unique in the input fasta file)
       # and per SSR detected motif

# C) wrap-up FUN which parses txt file output from mreps into dataframe which is easy to read
       # uses FUN A) & B)
       # loads and transforms txt file outputs from mreps (each corresponding to an input fasta file)
       # removes lines and line parts associated witth strings from a list
       # WARNING for special character use "\\ special char",

### How to use the script with the examples provided? see the readme online in the /MREPS.parsing folder

library("plyr")
##(A)
rem.charel<-function(x, rem.vec) {
       # x is a complex character string # x=don[[1]]
       # rem.vec = vector of char strings to remove from x
       # rem.char(x,rem.vec=rem.lines)   # for example rem.lines=c("--","\\*","RESULTS","Warning")
       yrem<-x
         for (i in 1:length(rem.vec)) {
          rem.match<-grep(rem.vec[i],yrem)
          yrem<-yrem[-rem.match]
         }
         return(yrem)
} #end FUN rem.charel

## (B)
mreps.chvec.2.df<-function(x,hed=header1.df,sepp=sep.ch.df) {
                     # x<-don.rem[[1]] # x = character vector in a list when dealing with output from the rem.charel FUN
                     # hed=header1.df is the character string appearing before each fasta sequence name,
                     # for ex "Processing sequence " in MREPS
                     # sepp is the separator appearing in the character vector, for example sepp="\t"
                     # mreps.chvec.2.df(x,hed=header1.df,sepp=sep.ch.df)

        # extract contig/fasta sequence name info
              contig<-x[grep(hed,x)]
              ct.id<-sub(pattern=header1.df, replacement="", contig, fixed=TRUE) # x is an element of a matrix here or a vector
              ct.id2<-gsub(pattern="\'", replacement="", ct.id, fixed=T)

        # create df structure
         dfi<-data.frame(matrix(NA,nrow=0,ncol=8))
         colnames(dfi)<-c("contig","from.to","size","period","exponent","error.rate","dum","sequence.repeat")
         for (i in 1:(length(contig)-1) ) {  # i<-1
              cx<-x[grep(contig[i],x,fixed=T):(grep(contig[i+1],x,fixed=T)-1)]
              if (length(cx)>2) {
                 cxx<-cx[-c(1:2)];dfx<-data.frame(cxx)
                 dfxx<-read.table(text=as.character(dfx$cxx),sep=sepp)
                 dfxx2<-cbind(ct.id2[i],dfxx)
                 colnames(dfxx2)<-c("contig", "from.to","size","period","exponent","error.rate","dum","sequence.repeat")
              } else { cxx<-c(rep(NA,7));dfxx2<-cbind(ct.id2[i],t(data.frame(cxx)))
                 colnames(dfxx2)<-c("contig","from.to","size","period","exponent","error.rate","dum","sequence.repeat")
              }
           dfi<-rbind(dfi,dfxx2)
         }

       #  deal with the last sequence processed
              cx<-x[grep(contig[length(contig)],x,fixed=T):length(x)]
              if (length(cx)>2) {
                 cxx<-cx[-c(1:2)];dfx<-data.frame(cxx)
                 dfxx<-read.table(text=as.character(dfx$cxx),sep=sepp)
                 dfxx2<-cbind(ct.id2[i],dfxx)
                 colnames(dfxx2)<-c("contig", "from.to","size","period","exponent","error.rate","dum","sequence.repeat")
              } else { cxx<-c(rep(NA,7));dfxx2<-cbind(ct.id2[length(ct.id2)],t(data.frame(cxx)))
                 colnames(dfxx2)<-c("contig","from.to","size","period","exponent","error.rate","dum","sequence.repeat")
                 rownames(dfxx2)<-NULL
              }

      dfi<-rbind(dfi,dfxx2)
      return(dfi)
     } # end fun mreps.chvec.2.df

## (C)
mreps.parse<-function(txt.folder=getwd(),ext=".txt", rem.lines=c("--","\\*","RESULTS","Warning"), header1.df="Processing sequence ", sep.ch.df="\t",to.print=T) {
     # 1)
     txt.files<-list.files(txt.folder, all.files=F,full.names=F, recursive=F, pattern=paste(ext,"$",sep=""))
     don<-lapply(paste(txt.folder,"/",txt.files,sep=""), scan, what=character(0), sep="\n", quiet=T,skip=0)
   # don --> list of txt files transformed into char vectors with names list elements as txt files names
     names(don)<-txt.files
     # 2)  use simpler function rem.char & llply
     don.rem<-llply(don, rem.charel,rem.vec=rem.lines)
   # don.rem --> list of char vec simplified
     # 3) apply mreps.chvec.2.df to the list
         don.df.list<-llply(don.rem,mreps.chvec.2.df, hed=header1.df,sepp=sep.ch.df)
     # 4) option to write data frames corresponding to the don.df.list with col .id as txt files names
       if (to.print==T) {
        don.df<-ldply(don.rem,mreps.chvec.2.df, hed=header1.df,sepp=sep.ch.df)
        write.table(don.df, file=paste(txt.folder,"/","mreps.df.txt",sep=""),append=F,quote=F,sep="\t",col.names=T, row.names=F)
       }
  return(don.df.list)
} # end FUN mreps.parse

# launching mreps.parse
mreps.out.list<-mreps.parse(txt.folder=getwd(),ext=".txt",rem.lines=c("--","\\*","RESULTS","Warning"),header1.df="Processing sequence ", sep.ch.df="\t",to.print=T)
