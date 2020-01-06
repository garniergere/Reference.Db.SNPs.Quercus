## High quality SNP, Indel and SSR Resources for <i>Quercus petraea</i> & <i>Q. robur</i>

This page compiles information from a database of high-quality polymorphic loci (SNP, Indel, SSR) characterized across ~530 kb of sequence fragments from genic regions in two Quercus species (<i>Q. petraea</i> and <i>Q. robur</i>). 

In the post-genomics era, non-model species like most Fagaceae still lack operational diversity resources for population genomics studies. The quality of the data provided here and their representativity in terms of species genomic diversity make them useful for possible applications in medium-scale landscape  and molecular ecology projects. Moreover, they can serve as a reference resource for validation purposes in larger-scale re-sequencing projects. This type of project is preferentially recommended in oaks in contrast to SNP array development, given the large nucleotide variation and low levels of linkage disequilibrium revealed.

These data were first published in: <br/>

> Lang T, Abadie P, Léger V, Decourcelle T, Frigerio J-M, Burban C, Bodénès C, Guichoux E, Le Provost G, Robin C, Tani N, Léger P, Lepoittevin C, El Mujtar VA, Hubert F, Tibbits J, Paiva J, Franc A, Raspail F, Mariette S, Reviron M-P, Plomion C, Kremer A, Desprez-Loustau M-L, Garnier-Géré P (2018) High-quality SNPs from genic regions highlight introgression patterns among European white oaks (<i>Quercus petraea</i> and <i>Q. robur</i>).
<br /> available at  https://doi.org/10.1101/388447.

A new version of the manuscript is available at ... and has been submitted to PCI Evolutionary Biology.

### Description of the data in summary

* Sanger sequences were produced from over 800 gene fragments covering ~530 kb across the genic partition of European oaks in a range-wide sampling of 25 individuals (11 <i>Q. petraea</i>, 13 <i>Q. robur</i>, one <i>Q. ilex</i> as an outgroup). 

* Regions targeted represented broad functional categories potentially involved in species ecological preferences, and a random set of genes.

* Using a high-quality dedicated pipeline (SeqQual at https://github.com/garniergere/SeqQual), we obtained a detailed characterization of 852 independent genic regions, which include over 14500 polymorphisms, with ~12500 SNPs -218 being triallelic-, over 1500 insertion-deletions, and ~200 novel di- and tri-nucleotide SSR loci. 

* This catalog also provides various summary statistics within and among species, gene ontology information, and standard formats to assist loci choice for genotyping projects. The distribution of nucleotide diversity and differentiation across genic regions are also described for the first time in those species (mean nucleotide diversity close to ~0.0049 in <i>Q. petraea</i> and to ~0.0045 in <i>Q. robur</i> across random regions, and mean FST ~0.13 across SNPs), with an estimate across the genome of 41 to 51 million SNPs expected in both species. We observed robust patterns of slightly but significantly higher diversity in <i>Q. petraea</i>, across a random gene set and in the abiotic stress functional category, and a heterogeneous landscape of both diversity and differentiation. 

### Data availability and link to other oak genomic resources
* Sanger original data current link https://datadryad.org/stash/share/klvEAfXP-GQytODunTk1m1g1BHc7HtTdETj7SlN-OfY 
* The Original assembly for selecting contigs is in Appendix S2 of the paper (Supporting information). For Sanger trace files (with data on at least 2 individuals), see the Dryad repository (the https://doi.org/10.5061/dryad.4mw6m906j link will be available once data have been curated, 

https://datadryad.org/stash/dataset/doi:10.5061/dryad.4mw6m906j

Consensus sequences are respectively in Supporting information appendices S1 (used to design primers), S5 (used for functional annotation), and S6 (genomic sequences obtained). Tables S1 and S2 correct and extend and the oak Candidate Genes Database of the Quercus Portal (www.evoltree.eu/index.php/e-recources/databases/candidate-genes). SNPs, indels and SSRs catalogs and positions within genomic consensus sequences, and ready-to-use format for genotyping essays are provided in Tables S3 to S5 (Supporting information) and at https://github.com/garniergere/Reference.Db.SNPs.Quercus. 
Bioperl scripts from the SeqQual pipeline are given at https://github.com/garniergere/SeqQual. Examples of parameter files and scripts for STRUCTURE analyses and parsing MREPS software are given at https://github.com/garniergere/Reference.Db.SNPs.Quercus





The published data correct and largely expand :
* the previous oak candidate genes database of the Quercus Portal at https://arachne.pierroton.inra.fr/QuercusPortal/
* the previous SNP dataset currently available at the eLab from Evoltree www.evoltree.eu/index.php/snp-db/ which are directly derived from these candidate genes. This previous set of SNP can be examined online using the "Fagaceae" & "Quercus petraea/robur" filter options and then "update", and they can also be downloaded in batch from http://www.evoltree.eu/et_extensions/elab-data/SNP_Database_Export.xls

Polymorphic loci lists and additional information are available as Supplementary information of the above reference at the following BioRxiv link:

These include:
* Fragment lists with links to previous assembly ID, Functional annotation, published genetic maps, and Quercus robur unigene
* Exhaustive variant list with summary statistics in both <i>Q. petraea</i> and <i>Q. robur</i> (as identified when excluding the 2 most introgressed individuals of the discovery panel)
* On this repositary, you can also find the same list when excluding the 4 most introgressed individuals (...to be added soon)

See <A HREF="STRUCTURE.files"> STRUCTURE.files </A> for examples of data, parameter files, and R script for plotting Standard deviations or Bayesian Confidence Intervals around Q-values provided by the STRUCTURE software (Falush <i>et al.</i> 2003, Genetics 164: 1567-1587)

See <A HREF="MREPS.parsing"> MREPS.parsing </A> for a R script that parses mreps output into a dataframe for SSR detection.

### Contact 
Pauline Garnier-Géré ( pauline.garniergere@inrae.fr )

### Funding

EVOLTREE network of Excellence (EU contract n°016322); Agence Nationale de la Recherche, TRANSBIODIV project (contract 06-BDIV-003-04); Biodiversa LINKTREE project (contract n°2008-966); Agence Nationale de la Recherche, REALTIME project (contract N°59000256).
