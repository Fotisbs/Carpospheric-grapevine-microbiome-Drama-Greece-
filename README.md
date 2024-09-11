# ***Vintage and terroir are the strongest determinants of grapevine carposphere microbiome in the viticultural zone of Drama, Greece***

### By Bekris F. <sup>1</sup>, Papadopoulou E. <sup>1</sup>, Vasileiadis S. <sup>1</sup>, Karapetsas N.<sup>2</sup>, Theocharis S. <sup>3</sup>, Alexandridis T.K. <sup>2</sup>, Koundouras S.<sup>3</sup>, Karpouzas D.G <sup>1*</sup>

### (\* corr. author)

<sup>1</sup> University of Thessaly, Department of Biochemistry and Biotechnology, Laboratory of Plant and Environmental Biotechnology, 41500 Viopolis – Larissa, Greece

<sup>2</sup> Aristotle University of Thessaloniki, Department of Hydraulics, Soil Science and Agricultural Engineering, School of Agriculture, Laboratory of Remote Sensing, Spectroscopy and Geographic Information Systems, 54124 Thessaloniki, Greece

<sup>3</sup> Aristotle University of Thessaloniki, Department of Horticulture, School of Agriculture, Laboratory of Viticulture, 54124 Thessaloniki, Greece


## The provided material includes the code used in the statistical analysis of the study.

For obtaining the code the users need to open a terminal and having the [GitHub tools](https://github.com/git-guides/install-git), git-clone or download the repository, and enter the base folder. E.g:

```
$ git clone https://github.com/Fotisbs/Carpospheric-grapevine-microbiome-Drama-Greece-.git
```

In the case of the computational methods, with the "Carpospheric-grapevine-microbiome-Drama-Greece-" folder as working directory, and assuming that the necessary software and R packages are installed, the used code can be executed as described in this Readme.md file. The necessary datasets for performing all sequencing based analysis can be downloaded implementing the code provided in the corresponding repository folders as explained below.

## Description of the order of executed scripts.

Steps 0-2 concern the data retrieval from NCBI and preprocessing, while step 3 and the subfolders concern the actual data analysis for total fungi and bacteria. 

0) First, it is necessary to download the sequencing data.
To do so, you need to enter the "0.DownloadData" subfolder of "Fungi" and "Bacteria" folders accordingly and execute the "fetch_data.sh" bash script for each batch (01-02), this assumes that you are located at the working directory "Carpospheric-grapevine-microbiome-Drama-Greece-"). The NCBI submitted amplicons are includes at those 2 batch/files.The script is based on the SRR accession numbers for each batch file and can be found in the 0.DownloadData folder as a.txt file.
Once the download is done, you need to combine all forward reads to a single file and all reverse reads to another file as well.
```
for i in {01....02}
do
	cd Fungi/0.DownloadData/batch${i}
	sh -x fetch_data.sh
	cat *_1.fastq | gzip > forward.fastq.gz
	cat *_2.fastq | gzip > reverse.fastq.gz
	cd ../../../
	cd Bacteria/0.DownloadData/batch${i}
	sh -x fetch_data.sh
	cat *_1.fastq | gzip > forward.fastq.gz
	cat *_2.fastq | gzip > reverse.fastq.gz
	cd ../../../
done
```

1) Then you need to demultiplex the data according to our own demultiplexing method using our in-house script.
This requires Flexbar v3.0.3 to be installed.
A detailed description of our in-house multiplexing approach is provided in our [previous work] (https://github.com/SotiriosVasileiadis/mconsort_tbz_degr#16s).
You need to enter the folder Fungi/1.Demultiplex and run the following commands (change the MY_PROCS variable to whatever number of logical processors you have available and want to devote).
the following commands are going to save the demultiplexed files in the Fungi(or Bacteria)/1.Demultiplex/demux_out folder.
```
MY_WORKING_DIR_BASE=`pwd`
for i in {01....02}
do
  cd Fungi/1.Demultiplex
  MY_PROCS=56
  bash DemuxOwnBCsys_absPATH.sh demux_out${i} ${MY_WORKING_DIR_BASE}/Fungi/0.DownloadData/batch${i}/forward.fastq.gz ${MY_WORKING_DIR_BASE}/Fungi/0.DownloadData/batch${i}/reverse.fastq.gz fun${i}_map_file.txt ${MY_PROCS}
  cd demux_out${i}/analysis_ready
  gunzip *.gz # unzips files skipped by the Demux script
  cd ../../../../
  cd Bacteria/1.Demultiplex
  MY_PROCS=56
  bash DemuxOwnBCsys_absPATH.sh demux_ou${i} ${MY_WORKING_DIR_BASE}/Fungi/0.DownloadData/batch${i}/forward.fastq.gz ${MY_WORKING_DIR_BASE}/Fungi/0.DownloadData/batch${i}/reverse.fastq.gz bac${i}_map_file.txt ${MY_PROCS}
  cd demux_out${i}/analysis_ready
  gunzip *.gz # unzips files skipped by the Demux script
  cd ../../../../
done

cd Fungi/1.Demultiplex
mkdir -p demux_out/analysis_ready
cp demux_out[0-9]/analysis_ready/*.fastq demux_out/analysis_ready/
cd ../../

cd Bacteria/1.Demultiplex
mkdir -p demux_out/analysis_ready
cp demux_out[0-9]/analysis_ready/*.fastq demux_out/analysis_ready/
cd ../../
```
2) Following, the "Drama Carpospheric grapevine microbiome PhyloseqObjectPrep.R" script of the Fungi(or Bacteria)/2.PhyloseqObjectPerp folder is run in order to prepare the final phyloseq object to be used in the data analysis described below. Before running the script make sure that the necessary reference databases are found in the same folder. The raw phyloseq object for fungi and bacteria should be constructed following the guidelines from the previous steps and before Phyloseq Object Preparation, the Phyloseq Object along with samdf file are also supplied in the PhyloseqObjectPerp folder for convenient.
```
cd Fungi/2.PhyloseqObjectPrep
# fetch the database s
wget https://files.plutof.ut.ee/public/orig/1D/B9/1DB95C8AC0A80108BECAF1162D761A8D379AF43E2A4295A3EF353DD1632B645B.gz
# run the R script
Fungi Drama Carpospheric grapevine microbiome PhyloseqObjectPrep.R.r
cd ../../
cd Bacteria/2.PhyloseqObjectPrep
# fetch the databases
wget https://zenodo.org/record/4587955/files/silva_nr99_v138.1_train_set.fa.gz
wget https://zenodo.org/record/4587955/files/silva_nr99_v138.1_wSpecies_train_set.fa.gz
tar vxf *.gz
# run the R script
Bacteria Drama Carpospheric grapevine microbiome PhyloseqObjectPrep.R.r
cd ../../
```
3) Data analysis folder include subfolders for each analysis graphs supplied at the researched article "Vintage and terroir are the strongest determinants of grapevine carposphere microbiome in the viticultural zone of Drama, Greece". The subfolders are seperated to main and supplementary figures and tables. Subfolders contain the R script to be executed for "Fungi" and "Bacteria" accordingly. 
```
3a) Main Figures

Run Stacked bar plots analysis script........

Run NMDS and Pairwise-PERMANOVA  analysis script........

Run PERMANOVA analysis script........ 

Run Differential abundance heatmaps analysis script.........

3b) Supplementary Figures

Run Rarefaction curves analysis script......

Run Stacked bar plots analysis script........

Run alpha diversity analysis script........

Run NMDS and Pairwise-PERMANOVA  analysis script........

Run PERMANOVA analysis script.....

Run core microbiome analysis script.....

## Code Usage disclaimer<a name="disclaimer"></a>

The following is the disclaimer that applies to all scripts, functions, one-liners, etc. This disclaimer supersedes any disclaimer included in any script, function, one-liner, etc.

You running this script/function means you will not blame the author(s) if this breaks your stuff. This script/function is provided **AS IS** without warranty of any kind. Author(s) disclaim all implied warranties including, without limitation, any implied warranties of merchantability or of fitness for a particular purpose. The entire risk arising out of the use or performance of the sample scripts and documentation remains with you. In no event shall author(s) be held liable for any damages whatsoever (including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or inability to use the script or documentation. Neither this script/function, nor any part of it other than those parts that are explicitly copied from others, may be republished without author(s) express written permission. Author(s) retain the right to alter this disclaimer at any time. This disclaimer was copied from a version of the disclaimer published by other authors in https://ucunleashed.com/code-disclaimer and may be amended as needed in the future.
