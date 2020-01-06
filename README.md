## High quality SNP, Indel and SSR Resources for <i>Quercus petraea</i> & <i>Q. robur</i>

This page compiles information from a database of high-quality polymorphic loci (SNP, Indel, SSR) characterized across ~530 kb of sequence fragments from genic regions in two Quercus species (<i>Q. petraea</i> and <i>Q. robur</i>). 

In the post-genomics era, non-model species like most Fagaceae still lack operational diversity resources for population genomics studies. The quality of the data provided here and their representativity in terms of species genomic diversity make them useful for possible applications in medium-scale landscape  and molecular ecology projects. Moreover, they can serve as a reference resource for validation purposes in larger-scale re-sequencing projects. This type of project is preferentially recommended in oaks in contrast to SNP array development, given the large nucleotide variation and low levels of linkage disequilibrium revealed.

These data were first published in: <br/>

> Lang T, Abadie P, Léger V, Decourcelle T, Frigerio J-M, Burban C, Bodénès C, Guichoux E, Le Provost G, Robin C, Tani N, Léger P, Lepoittevin C, El Mujtar VA, Hubert F, Tibbits J, Paiva J, Franc A, Raspail F, Mariette S, Reviron M-P, Plomion C, Kremer A, Desprez-Loustau M-L, Garnier-Géré P (2018) High-quality SNPs from genic regions highlight introgression patterns among European white oaks (<i>Quercus petraea</i> and <i>Q. robur</i>).
<br /> available at  https://doi.org/10.1101/388447.

A new version of the manuscript is available at (add new BioRxiv link) (to be submitted to PCI Evolutionary Biology).

### Description of the data in summary

* Sanger sequences were produced from over 800 gene fragments covering ~530 kb across the genic partition of European oaks in a range-wide sampling of 25 individuals (11 <i>Q. petraea</i>, 13 <i>Q. robur</i>, one <i>Q. ilex</i> as an outgroup). 

* Regions targeted represented broad functional categories potentially involved in species ecological preferences, and a random set of genes.

* Using a high-quality dedicated pipeline (<A HREF="https://github.com/garniergere/SeqQual">SeqQual</A>), we obtained a detailed characterization of 852 independent genic regions, which include over 14500 polymorphisms, with ~12500 SNPs -218 being triallelic-, over 1500 insertion-deletions, and ~200 novel di- and tri-nucleotide SSR loci. 

* This catalog also provides various summary statistics within and among species, gene ontology information, and standard formats to assist loci choice for genotyping projects. The distribution of nucleotide diversity and differentiation across genic regions are also described for the first time in those species (mean nucleotide diversity close to ~0.0049 in <i>Q. petraea</i> and to ~0.0045 in <i>Q. robur</i> across random regions, and mean FST ~0.13 across SNPs), with an estimate across the genome of 41 to 51 million SNPs expected in both species. We observed robust patterns of slightly but significantly higher diversity in <i>Q. petraea</i>, across a random gene set and in the abiotic stress functional category, and a heterogeneous landscape of both diversity and differentiation. 

* <A HREF="STRUCTURE.files"> STRUCTURE.files </A> provide examples of data, parameter files, and R script for directly plotting Standard deviations or Bayesian Confidence Intervals around Q-values from the STRUCTURE software outputs (Falush <i>et al.</i> 2003, Genetics 164: 1567-1587), as used across the discovery panel of 24 individuals.

* See <A HREF="MREPS.parsing"> MREPS.parsing </A> for a R script that parses mreps output into a dataframe for SSR detection.

### Data availability and links to other oak genomic resources

* Sanger original sequence data (.ab1 trace files) current link is <A HREF="https://datadryad.org/stash/share/klvEAfXP-GQytODunTk1m1g1BHc7HtTdETj7SlN-OfY"> here</A>. Each subfolder can contain more than one fragment from the same reference contig, in which case most fragments but not all are overlapping. More than 85% of the amplicons yielded at least 12 high-quality sequences. All subfolders contain at least one sequence that is of very good Sanger quality. 
* Consensus sequences for original contigs used to design primers and perform functional annotation can be found here in Appendix.S3.fas (see also <A HREF="Tables.S1.to.S5"> Table S2 </A>)
* Consensus sequences for the genomic sequences obtained are in <A HREF="Appendix"> Appendix.S4.qpqr.fas</A>) for in Q. petraea and Q. robur and <A HREF="Appendix"> Appendix.S5.qi.fas</A>) for Q. ilex.
* These sequences are amplicons for genic regions associated with 759 reference contigs from the original working assembly provided in <A HREF="Appendix"> Appendix.S2</A> of the lang <i>et al.</i> BioRxiv manuscript. 
* <A HREF="Tables.S1.to.S5"> Table S1 </A> describes amplicons for primer sequences, original candidate gene list, targeted biological functions (see references at the end of the Table), candidate gene type, fragment expected size and position in original assembly, preliminary results based nucleotide quality for obtained sequences and final decision after excluding paralog amplifications.
* <A HREF="Tables.S1.to.S5"> Table S2 </A> lists functional annotations from Blast2GO (-A), comparison of BlastX best hits results (according to E-values) between consensus sequences of the original working assembly (<i>orict</i>) and the <i>ocv4</i> assembly (-B) from <A HREF="https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-015-1331-9"> Lesur <i>et al.</i> 2015 </A>, and comparisons of BlastN results of both orict and corresponding amplicon only to ocv4 (-C). 
* <A HREF="Tables.S1.to.S5"> Table S3 </A> lists all variants single base positions, with sample sizes, alleles, genotypes counts, various statistics, and generic format for genotyping essays input data. Species samples exclude the 2 most introgressed individuals. 
* <A HREF="Tables.S1.to.S5"> Table S4 </A> is derived from Table S3 where contiguous polymorphic base positions and length are listed for complex polymorphisms5 for SSR positions). 
* <A HREF="Tables.S1.to.S5"> Table S5 </A> lists SSR positions in consensus sequences and SSR patterns as detected from the <A HREF="https://mreps.univ-mlv.fr/"> MREPS </A> software. 



Tables S1 and S2 correct and extend and the oak Candidate Genes Database of the Quercus Portal (www.evoltree.eu/index.php/e-recources/databases/candidate-genes). SNPs, indels and SSRs catalogs and positions within genomic consensus sequences, and ready-to-use format for genotyping essays are provided in Tables S3 to S5 (Supporting information) and at https://github.com/garniergere/Reference.Db.SNPs.Quercus. 


More information and examples of parameter files and scripts for STRUCTURE analyses and parsing MREPS software are given at https://github.com/garniergere/Reference.Db.SNPs.Quercus

Appendix S3 Sequences of chosen contigs consensus and singletons sequences for functional annotation analyses. 
Appendix S4 Consensus sequences of 852 genomic regions obtained in this study for Quercus petraea and Q. Robur individuals. “(N)9” : represents a low-quality fragment of a length below ~1 kb separating Forward and Reverse amplicons; “n” position with a majority of nucleotides with phd score below 30. “(-)x”: insertion is a minor allele at that position.
Appendix S5 Nucleotide sequence data of 394 gene regions for one Quercus ilex individual, heterozygote sites being indicated by IUPAC codes. 




The published data correct and largely expand :
* the current Quercus Portal <A HREF="www.evoltree.eu/index.php/e-recources/databases/candidate-genes"> candidate genes database  </A> 
* the previous SNP dataset currently available at the eLab from Evoltree www.evoltree.eu/index.php/snp-db/ which are directly derived from these candidate genes. This previous set of SNP can be examined online using the "Fagaceae" & "Quercus petraea/robur" filter options and then "update", and they can also be downloaded in batch from http://www.evoltree.eu/et_extensions/elab-data/SNP_Database_Export.xls

Polymorphic loci lists and additional information are available as Supplementary information of the above reference at the following BioRxiv link:

These include:
* Fragment lists with links to previous assembly ID, Functional annotation, published genetic maps, and Quercus robur unigene
* Exhaustive variant list with summary statistics in both <i>Q. petraea</i> and <i>Q. robur</i> (as identified when excluding the 2 most introgressed individuals of the discovery panel)
* On this repositary, you can also find the same list when excluding the 4 most introgressed individuals (...to be added soon)


### Other Fagaceae transcriptomic and genomic resources
Quercus Portal and Q. robur genome
fagaceae.org
genome Q. alba and Q. suber
transcriptome ... cf references Lang et al to link to

### Contact 
Pauline Garnier-Géré ( pauline.garniergere@inrae.fr )

### Funding

EVOLTREE network of Excellence (EU contract n°016322); Agence Nationale de la Recherche, TRANSBIODIV project (contract 06-BDIV-003-04); Biodiversa LINKTREE project (contract n°2008-966); Agence Nationale de la Recherche, REALTIME project (contract N°59000256).
