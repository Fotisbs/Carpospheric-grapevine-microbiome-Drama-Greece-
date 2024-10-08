##Quality Control, classification and phyloseq object construction##
##install the necessary packages##
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("dada2")

##load the package##
library(dada2); packageVersion("dada2")

mymultthread <- 56

##input file path and storing in variables##
##change to the directory containing the fastq files after unzipping##
path1 <- ("~/ex.Fungi")

##lists files in a path##
list.files(path1)

##set the variables containing all the forward and the reverse paths to the files of interest with the list.files command##
fnFs <- sort(list.files(path1, pattern="_R1.fastq", full.names = TRUE))
fnRs <- sort(list.files(path1, pattern="_R2.fastq", full.names = TRUE))

##Extract sample names, assuming filenames have format: SAMPLENAME_XXX.fastq##
sample.names <- gsub("_.+","",basename(fnFs))

##Plot the per-base qualities## 
plotQualityProfile(c(fnFs[1],fnRs[1]))

pdf("Initial Quality Files_fun_wd.pdf",onefile=T)
for (i in c(1:length(fnFs))) {
  print(i)
  plot1 <- plotQualityProfile(fnFs[i])
  print(plot1)
  plot2 <- plotQualityProfile(fnRs[i])
  print(plot2)
}
dev.off() 

##sequence quality filtering and control, error modelling, and dereplication##
##set the file paths where the quality controlled sequences are going to be saved##
filtFs <- file.path("filtered_fun_wd", paste(sample.names, "_F_filt.fastq.gz", sep = ""))
filtRs <- file.path("filtered_fun_wd", paste(sample.names, "_R_filt.fastq.gz", sep = ""))

##filter the sequences and save then in the folders provided above and get their statistics in a table##
out <- filterAndTrim(fnFs, filtFs, fnRs, filtRs, trimLeft = 11,
                     maxN=0, maxEE=c(2,2), truncLen = c(230,230), truncQ=2, rm.phix=TRUE,
                     compress=TRUE, multithread=mymultthread, matchIDs=TRUE)
head(out)

##learns error rates using a machine learning algorithm##
errF <- learnErrors(filtFs, multithread=mymultthread)
plotErrors(errF, nominalQ=TRUE)
errR <- learnErrors(filtRs, multithread=mymultthread)
plotErrors(errR, nominalQ=TRUE)

##dereplication of each one of the red pairs to unique sequences (collapsing of the identical sequences for each pair per sample)##
derepFs <- derepFastq(filtFs, verbose=TRUE)
derepRs <- derepFastq(filtRs, verbose=TRUE)

##Name the derep-class objects by the sample names##
names(derepFs) <- sample.names
names(derepRs) <- sample.names

##sample composition inference after read correction##
dadaFs <- dada(derepFs, err=errF, multithread=mymultthread)
dadaRs <- dada(derepRs, err=errR, multithread=mymultthread)

##merge read pairs retaining the per sequence sample information##
mergers <- mergePairs(dadaFs, derepFs, dadaRs, derepRs, verbose=TRUE)

##construct the sequence table, remove the chimeras, and create a summary##
##construct sequence table##
seqtab <- makeSequenceTable(mergers)

##chimera removal (consensus)##
seqtab.nochim <- removeBimeraDenovo(seqtab, method="consensus", multithread=mymultthread, verbose=TRUE)

##dimensions of seqtab.nochim##
dim(seqtab.nochim)

##record the portion of good sequences out of the total prior the chimera removal##
sum(seqtab.nochim)/sum(seqtab)  

##track reads through the pipeline##
getN <- function(x) {sum(getUniques(x))}
track <- cbind(out, sapply(dadaFs, getN), sapply(dadaRs, getN), sapply(mergers, getN), rowSums(seqtab.nochim))

colnames(track) <- c("input", "filtered", "denoisedF", "denoisedR", "merged", "nonchim")
rownames(track) <- sample.names

head(track)

##save the read quality control data##
write.table(track, file = "readQC_fun_wd.txt", col.names = NA, sep = "\t", quote = FALSE)

##taxonomically classify the sequences##
taxa <- assignTaxonomy(seqtab.nochim, minBoot = 80, "wshp_foldrs/dbs/UNITE_general_release_s_all_04.02.2020/sh_general_release_dynamic_s_all_04.02.2020.fasta", tryRC = T, multithread=mymultthread)

##proceed with analysis, load the phyloseq package##
library(phyloseq); packageVersion("phyloseq")

##load the ggplot2 package, for plotting functions##
# load the experimental design data##
samdf <- read.table(file ="design", header = T, row.names = 1, sep = "\t", check.names = F, quote = "", comment.char = "")

##construct the phyloseq object## 
Drama_Terroir_Fungi_Fruits <- phyloseq(otu_table(seqtab.nochim, taxa_are_rows=FALSE) 
                     ,sample_data(samdf) 
                     ,tax_table(taxa))

##replace the taxon names (the sequences of each ASV with something easier to read and save the sequence info in the object)##
##load the Biostrings and stringr packages##
library("Biostrings")

sequences <- Biostrings::DNAStringSet(taxa_names(ps_fungi))
names(sequences) <- taxa_names(Drama_Terroir_Fungi_Fruits)

ps <- merge_phyloseq(Drama_Terroir_Fungi_Fruits, sequences)

Drama_Terroir_Fungi_Fruits <- ps

library(stringr)
taxa_names(Drama_Terroir_Fungi_Fruits) <- paste("ASV",str_pad(1:length(taxa_names(Drama_Terroir_Fungi_Fruits)),4, pad = "0"),sep = "")

##Create table,and check number of features for each phyla##
table(tax_table(Drama_Terroir_Fungi_Fruits)[, "Kingdom"], exclude = NULL)
table(tax_table(Drama_Terroir_Fungi_Fruits)[, "Phylum"], exclude = NULL) 
table(tax_table(Drama_Terroir_Fungi_Fruits)[, "Class"], exclude = NULL) 
table(tax_table(Drama_Terroir_Fungi_Fruits)[, "Order"], exclude = NULL)
table(tax_table(Drama_Terroir_Fungi_Fruits)[, "Family"], exclude = NULL)
table(tax_table(Drama_Terroir_Fungi_Fruits)[, "Genus"], exclude = NULL)

##save phyloseq object and continue with the last steps of cleaning the object before the statistical analysis scripts##

saveRDS(Drama_Terroir_Fungi_Fruits, file = "Drama_Terroir_Fungi_Fruits.RDS")


##Continue the analysis Drama Terroir by uploading the phyloseq object constructed in the previous steps, otherwise upload the .RDS object supplied in the file## 
Drama_Terroir_Fungi_Fruits <- readRDS(".........../Drama_Terroir_Fungi_Fruits.RDS")

Drama_Terroir_Fungi_Fruits

##Firstly remove taxa without taxonomy assignment at Kingdom and Phylum level and select only Phylum of p__Ascomycota and p__Basidiomycota
table(tax_table(Drama_Terroir_Fungi_Fruits)[, "Kingdom"], exclude = NULL)

Drama_Terroir_Fungi_Fruits.Cl <- subset_taxa(Drama_Terroir_Fungi_Fruits, !is.na(Kingdom))

table(tax_table(Drama_Terroir_Fungi_Fruits.Cl)[, "Kingdom"], exclude = NULL)


table(tax_table(Drama_Terroir_Fungi_Fruits.Cl)[, "Phylum"], exclude = NULL)

Drama_Terroir_Fungi_Fruits.Cl2 <- subset_taxa(Drama_Terroir_Fungi_Fruits.Cl, !is.na(Phylum) & Phylum %in% (c("p__Ascomycota", "p__Basidiomycota")))

Drama_Terroir_Fungi_Fruits.Cl2 <- prune_taxa(taxa_sums(Drama_Terroir_Fungi_Fruits.Cl2)>0,Drama_Terroir_Fungi_Fruits.Cl2)


##Assign ASVs without taxonomy to the previous level
Drama_Terroir_Fungi.Cl.2.An <- Drama_Terroir_Fungi_Fruits.Cl2 

for(i in 1:nrow(tax_table(Drama_Terroir_Fungi.Cl.2.An))){
  for(j in 2:ncol(tax_table(Drama_Terroir_Fungi.Cl.2.An))){
    if(is.na(tax_table(Drama_Terroir_Fungi.Cl.2.An)[i,j])){
      tax_table(Drama_Terroir_Fungi.Cl.2.An)[i,j] <- tax_table(Drama_Terroir_Fungi.Cl.2.An)[i,j-1]
    }
  }
}                 


#

#Drama Fruits#
Drama_Terroir_Fungi_Fruits <- Drama_Terroir_Fungi.Cl.2.An

Drama_Terroir_Fungi_Fruits

#Continue with each file script separately to reproduce the analysis figures
