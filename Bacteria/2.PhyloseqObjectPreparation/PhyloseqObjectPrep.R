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
path1 <- ("~/ex.Bacteria")

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
filtFs <- file.path("filtered_bac_wd", paste(sample.names, "_F_filt.fastq.gz", sep = ""))
filtRs <- file.path("filtered_bac_wd", paste(sample.names, "_R_filt.fastq.gz", sep = ""))

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
write.table(track, file = "readQC_bac_wd.txt", col.names = NA, sep = "\t", quote = FALSE)

##taxonomically classify the sequences##
taxa <-assignTaxonomy(seqs = seqtab.nochim, minBoot = 80, refFasta = "/mnt/4abcb8af-e2eb-47e2-86d6-eed71f6d5304/00_home_guests_do_not_move/fotisbs/wshp_foldrs/dbs/silva_nr99_v138.1_train_set.fa.gz", multithread=TRUE, tryRC = TRUE)

write.table(taxa, file = "taxa.txt", col.names = NA, sep = "\t", quote = F)
......
##add species assignment##
taxa2 <- addSpecies(taxa, "/mnt/4abcb8af-e2eb-47e2-86d6-eed71f6d5304/00_home_guests_do_not_move/fotisbs/wshp_foldrs/dbs/old_dep/silva_species_assignment_v138.fa.gz")

write.table(taxa2, file = "taxa2.txt", col.names = NA, sep = "\t", quote = F)

##proceed with analysis, load the phyloseq package##
library(phyloseq); packageVersion("phyloseq")

##load the ggplot2 package, for plotting functions##
# load the experimental design data##
samdf <- read.table(file ="design", header = T, row.names = 1, sep = "\t", check.names = F, quote = "", comment.char = "")

##construct the phyloseq object## 
Drama_Terroir_Bacteria_Fruits <- phyloseq(otu_table(seqtab.nochim, taxa_are_rows=FALSE) 
                                       ,sample_data(samdf) 
                                       ,tax_table(taxa2))

##replace the taxon names (the sequences of each ASV with something easier to read and save the sequence info in the object)##
##load the Biostrings and stringr packages##
library("Biostrings")

sequences <- Biostrings::DNAStringSet(taxa_names(ps_Bacteria))
names(sequences) <- taxa_names(Drama_Terroir_Bacteria_Fruits)

ps <- merge_phyloseq(Drama_Terroir_Bacteria_Fruits, sequences)

Drama_Terroir_Bacteria_Fruits <- ps

library(stringr)
taxa_names(Drama_Terroir_Bacteria_Fruits) <- paste("ASV",str_pad(1:length(taxa_names(Drama_Terroir_Bacteria_Fruits)),4, pad = "0"),sep = "")

##Create table,and check number of features for each phyla##
table(tax_table(Drama_Terroir_Bacteria_Fruits)[, "Kingdom"], exclude = NULL)
table(tax_table(Drama_Terroir_Bacteria_Fruits)[, "Phylum"], exclude = NULL) 
table(tax_table(Drama_Terroir_Bacteria_Fruits)[, "Class"], exclude = NULL) 
table(tax_table(Drama_Terroir_Bacteria_Fruits)[, "Order"], exclude = NULL)
table(tax_table(Drama_Terroir_Bacteria_Fruits)[, "Family"], exclude = NULL)
table(tax_table(Drama_Terroir_Bacteria_Fruits)[, "Genus"], exclude = NULL)

##save phyloseq object and continue with the last steps of cleaning the object before the statistical analysis scripts##

saveRDS(Drama_Terroir_Bacteria_Fruits, file = "Drama_Terroir_Bacteria_Fruits.RDS")

##Continue the analysis Drama Terroir by uploading the phyloseq object constructed in the previous steps, otherwise upload the .RDS object supplied in the file## 
Drama_Terroir_Bacteria_Fruits <- readRDS(".........../Drama_Terroir_Bacteria_Fruits.RDS")

Drama_Terroir_Bacteria_Fruits

##Firstly remove taxa without taxonomy assignment at Kingdom and Phylum level and remove all the other Kingdoms beside Bacteria
table(tax_table(Drama_Terroir_Bacteria_Fruits)[, "Kingdom"], exclude = NULL)

Drama_Terroir_Bacteria_Fruits.Cl <- subset_taxa(Drama_Terroir_Bacteria_Fruits, !is.na(Kingdom) & !Kingdom %in% (c("", "Eukaryota","Archaea")))

table(tax_table(Drama_Terroir_Bacteria_Fruits.Cl)[, "Kingdom"], exclude = NULL)

table(tax_table(Drama_Terroir_Bacteria_Fruits.Cl)[, "Phylum"], exclude = NULL)

Drama_Terroir_Bacteria_Fruits.Cl2 <- subset_taxa(Drama_Terroir_Bacteria_Fruits.Cl, !is.na(Phylum))

table(tax_table(Drama_Terroir_Bacteria_Fruits.Cl2)[, "Phylum"], exclude = NULL)
                                                 
                                                 
Drama_Terroir_Bacteria_Fruits.Cl2 <- prune_taxa(taxa_sums(Drama_Terroir_Bacteria_Fruits.Cl2)>0,Drama_Terroir_Bacteria_Fruits.Cl2)

##Remove also Mitochondria and Chloroplasts
Drama_Terroir_Bacteria_Fruits.Cl2

Drama_Terroir_Bacteria.Cl3 <- subset_taxa(Drama_Terroir_Bacteria_Fruits.Cl2, !Family %in% c("Mitochondria"))

Drama_Terroir_Bacteria.Cl3 <- prune_taxa(taxa_sums(Drama_Terroir_Bacteria.Cl3)>0,Drama_Terroir_Bacteria.Cl3)

##4b Remove Chloroplast##
Drama_Terroir_Bacteria.Cl4 <- subset_taxa(Drama_Terroir_Bacteria.Cl3, !Order %in% c("Chloroplast"))

Drama_Terroir_Bacteria.Cl4 <- prune_taxa(taxa_sums(Drama_Terroir_Bacteria.Cl4)>0,Drama_Terroir_Bacteria.Cl4)

Drama_Terroir_Bacteria.Cl4
##Assign ASVs without taxonomy to the previous level
Drama_Terroir_Bacteria.Cl4.An <- Drama_Terroir_Bacteria.Cl4 

for(i in 1:nrow(tax_table(Drama_Terroir_Bacteria.Cl4.An))){
  for(j in 2:ncol(tax_table(Drama_Terroir_Bacteria.Cl4.An))){
    if(is.na(tax_table(Drama_Terroir_Bacteria.Cl4.An)[i,j])){
      tax_table(Drama_Terroir_Bacteria.Cl4.An)[i,j] <- tax_table(Drama_Terroir_Bacteria.Cl4.An)[i,j-1]
    }
  }
}                 


#

#Drama Fruits#
Drama_Terroir_Bacteria_Fruits <- Drama_Terroir_Bacteria.Cl4.An

Drama_Terroir_Bacteria_Fruits

#Continue with each file script separately to reproduce the analysis figures
