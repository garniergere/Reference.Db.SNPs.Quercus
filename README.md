## High quality SNP, Indel and SSR Resources for <i>Quercus petraea</i> & <i>Q. robur</i>

This page compiles information from a database of high-quality polymorphic loci (SNP, Indel, SSR) characterized across ~530 kb of sequence fragments from genic regions in two Quercus species (<i>Q. petraea</i> and <i>Q. robur</i>). 

In the post-genomics era, non-model species like most <i>Fagaceae</i> still lack operational diversity resources for population genomics studies. The quality of the data provided here and their representativity in terms of species genomic diversity make them useful for possible applications in medium-scale landscape  and molecular ecology projects. Moreover, they can serve as a reference resource for validation purposes in larger-scale re-sequencing projects. This type of project is preferentially recommended in oaks in contrast to SNP array development, given the large nucleotide variation and low levels of linkage disequilibrium revealed.

These data were first published in: <br/>

> Lang T, Abadie P, Léger V, Decourcelle T, Frigerio J-M, Burban C, Bodénès C, Guichoux E, Le Provost G, Robin C, Tani N, Léger P, Lepoittevin C, El Mujtar VA, Hubert F, Tibbits J, Paiva J, Franc A, Raspail F, Mariette S, Reviron M-P, Plomion C, Kremer A, Desprez-Loustau M-L, Garnier-Géré P (2018) High-quality SNPs from genic regions highlight introgression patterns among European white oaks (<i>Quercus petraea</i> and <i>Q. robur</i>).
<br /> available at  https://doi.org/10.1101/388447.

A new version of the manuscript is available at (add new BioRxiv link) (to be submitted to PCI Evolutionary Biology).

### Description of the data in summary

* Sanger sequences were produced from over 800 gene fragments covering ~530 kb across the genic partition of European oaks in a range-wide sampling of 25 individuals (11 <i>Q. petraea</i>, 13 <i>Q. robur</i>, one <i>Q. ilex</i> as an outgroup). 

* Regions targeted represented broad functional categories potentially involved in species ecological preferences, and a random set of genes.

* Using a high-quality dedicated pipeline (<A HREF="https://github.com/garniergere/SeqQual">SeqQual</A>), we obtained a detailed characterization of 852 independent genic regions, which include over 14500 polymorphisms, with ~12500 SNPs -218 being triallelic-, over 1500 insertion-deletions, and ~200 novel di- and tri-nucleotide SSR loci. 

* This catalog also provides various summary statistics within and among species, gene ontology information, and standard formats to assist loci choice for genotyping projects. The distribution of nucleotide diversity and differentiation across genic regions are also described for the first time in Lang et al. 2018 (mean nucleotide diversity close to ~0.0049 in <i>Q. petraea</i> and to ~0.0045 in <i>Q. robur</i> across random regions, and mean FST ~0.13 across SNPs). We observed robust patterns of slightly but significantly higher diversity in <i>Q. petraea</i>, across a random gene set and in the abiotic stress functional category, and a heterogeneous landscape of both diversity and differentiation. 

* These data allow to build an estimate across the genome of 41 to 51 million SNPs in both species. 

* <A HREF="STRUCTURE.files"> STRUCTURE.files </A> provide examples of data, parameter files, and R script for directly plotting Standard deviations or Bayesian Confidence Intervals around Q-values from the STRUCTURE software outputs (Falush <i>et al.</i> 2003, Genetics 164: 1567-1587), as used across the discovery panel of 24 individuals.

* See <A HREF="MREPS.parsing"> MREPS.parsing </A> for a R script that parses the output from the <A HREF="https://mreps.univ-mlv.fr/"> MREPS SSR detection software</A> into a dataframe .

### Data availability and links to other oak genomic resources

* Sanger original sequence data (.ab1 trace files) current link is <A HREF="https://datadryad.org/stash/share/klvEAfXP-GQytODunTk1m1g1BHc7HtTdETj7SlN-OfY"> here</A>. Each subfolder can contain more than one fragment from the same reference contig, in which case most fragments but not all are overlapping. More than 85% of the amplicons yielded at least 12 high-quality sequences. All subfolders contain at least one sequence that is of very good Sanger quality. 
* These sequences are amplicons obtained from genic regions associated with contigs from the original working assembly provided in <A HREF="Fasta"> Appendix.S2</A>. Consensus sequences for these original contigs (or singleton sequences) were used to design primers and perform functional annotations, and can be found in <A HREF="Fasta"> Appendix-S3.fas</A> (see also <A HREF="Tables.S1.to.S5"> Table S2</A>).
* Consensus sequences of the 852 genomic regions re-sequenced in this study after analyzing Sanger data are in <A HREF="Fasta"> Appendix-S4.fas</A>) for in <i>Q. petraea</i> and <i>Q. robur</i> and <A HREF="Fasta"> Appendix-S5.fas</A>) for <i>Q. ilex</i> (394 genic regions for one individual, heterozygote sites being indicated by IUPAC codes).
* <A HREF="Genes.and.SNPs"> Table S1 </A> describes amplicons for primer sequences, original candidate gene list, targeted biological functions (see references at the end of the Table), candidate gene type, fragment expected size and position in original assembly, preliminary results based nucleotide quality for obtained sequences and final decision after excluding paralog amplifications.
* <A HREF="Genes.and.SNPs"> Table S2 </A> lists functional annotations from Blast2GO (-A), comparison of BlastX best hits results (according to E-values) between consensus sequences of the original working assembly (<i>orict</i>) and the <i>ocv4</i> assembly (-B) from <A HREF="https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-015-1331-9"> Lesur <i>et al.</i> 2015 </A>, and comparisons of BlastN results of both orict and corresponding amplicon only to ocv4 (-C). 
* <A HREF="Genes.and.SNPs"> Table S3 </A> lists all single base variant positions exhaustively, with sample sizes, alleles, genotypes counts, various statistics, and generic format for genotyping essays input data. 
* <A HREF="Genes.and.SNPs"> Table S4 </A> is derived from Table S3 where contiguous polymorphic base positions and length are listed for complex polymorphisms including SSR. 
* Both Tables S3 and S4 Species samples exclude the 2 most introgressed individuals of the discovery panel, for Gst and Gst' statistics to be meaningful. A similar list is available here which excludes the 4 most introgressed individuals.
* <A HREF="Genes.and.SNPs"> Table S5 </A> lists SSR positions in consensus sequences and SSR patterns as detected from the <A HREF="https://mreps.univ-mlv.fr/"> MREPS </A> software. 

<A HREF="Genes.and.SNPs"> Tables S1 to S5 </A> correct and largely expand :
* the current Quercus Portal <A HREF="http://www.evoltree.eu/index.php/e-recources/databases/candidate-genes"> candidate genes database</A>. 
* the <A HREF="http://www.evoltree.eu/index.php/snp-db/"> Evoltree eLab SNP data </A> which are derived from these candidate genes (Click on "Refine data" then use "Fagaceae" and "Quercus petraea/robur" filter options, then "update" for online examination), or download them from <A HREF="http://www.evoltree.eu/et_extensions/elab-data/SNP_Database_Export.xls"> SNP_Database_Export</A>.

### Other Fagaceae transcriptomic and genomic resources
Quercus Portal and Q. robur genome to add...

fagaceae.org to add...

genome Q. alba and Q. suber to add...

transcriptome ... cf references Lang et al  to add...

### Contact 
Pauline Garnier-Géré ( pauline.garniergere@inrae.fr )

### Funding

EVOLTREE network of Excellence (EU contract n°016322); Agence Nationale de la Recherche, TRANSBIODIV project (contract 06-BDIV-003-04); Biodiversa LINKTREE project (contract n°2008-966); Agence Nationale de la Recherche, REALTIME project (contract N°59000256).
