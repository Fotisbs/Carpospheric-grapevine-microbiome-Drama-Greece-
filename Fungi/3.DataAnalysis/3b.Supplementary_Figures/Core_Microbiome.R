##Core microbiome
library(microbiome) # data analysis and visualisation
library(phyloseq) # also the basis of data object. Data analysis and visualisation
library(RColorBrewer) # nice color options
library(ggpubr) # publication quality figures, based on ggplot2
library(dplyr) # data handling



####### Core microbiota anlaysis
##load phyloseq object##

Drama_Terroir_Fungi_Fruits_Genus <- tax_glom(Drama_Terroir_Fungi_Fruits, taxrank = "Genus")

Drama_Terroir_Fungi_Fruits_Genus_Agiorgitiko <- subset_samples(Drama_Terroir_Fungi_Fruits_Genus, Cultivar=="Agiorgitiko")

Drama_Terroir_Fungi_Fruits_Genus_Agiorgitiko <- prune_taxa(taxa_sums(Drama_Terroir_Fungi_Fruits_Genus_Agiorgitiko)>0,Drama_Terroir_Fungi_Fruits_Genus_Agiorgitiko)

Drama_Terroir_Fungi_Fruits_Genus_Agiorgitiko

Drama_Terroir_Fungi_Fruits_Genus_Agiorgitiko_100 <- transform_sample_counts(Drama_Terroir_Fungi_Fruits_Genus_Agiorgitiko, function(OTU) 100*OTU/sum(OTU))



Drama_Terroir_Fungi_Fruits_Genus_Cabernet_Sauvignon <- subset_samples(Drama_Terroir_Fungi_Fruits_Genus, Cultivar=="Cabernet_Sauvignon")

Drama_Terroir_Fungi_Fruits_Genus_Cabernet_Sauvignon <- prune_taxa(taxa_sums(Drama_Terroir_Fungi_Fruits_Genus_Cabernet_Sauvignon)>0,Drama_Terroir_Fungi_Fruits_Genus_Cabernet_Sauvignon)

Drama_Terroir_Fungi_Fruits_Genus_Cabernet_Sauvignon

Drama_Terroir_Fungi_Fruits_Genus_Cabernet_Sauvignon_100 <- transform_sample_counts(Drama_Terroir_Fungi_Fruits_Genus_Cabernet_Sauvignon, function(OTU) 100*OTU/sum(OTU))



Drama_Terroir_Fungi_Fruits_Genus_Merlot <- subset_samples(Drama_Terroir_Fungi_Fruits_Genus, Cultivar=="Merlot")

Drama_Terroir_Fungi_Fruits_Genus_Merlot <- prune_taxa(taxa_sums(Drama_Terroir_Fungi_Fruits_Genus_Merlot)>0,Drama_Terroir_Fungi_Fruits_Genus_Merlot)

Drama_Terroir_Fungi_Fruits_Genus_Merlot

Drama_Terroir_Fungi_Fruits_Genus_Merlot_100 <- transform_sample_counts(Drama_Terroir_Fungi_Fruits_Genus_Merlot, function(OTU) 100*OTU/sum(OTU))


##Subset DataSet 
Drama_Terroir_Fungi_Fruits_Genus_Agiorgitiko
Drama_Terroir_Fungi_Fruits_Genus_Cabernet_Sauvignon
Drama_Terroir_Fungi_Fruits_Genus_Merlot
# Remove samples that don't belong to the cultivar Roditis #
##subset samples##
Fungi1920_vine_R <- Drama_Terroir_Fungi_Fruits_Genus_Agiorgitiko
Fungi1920_vine_R <- Drama_Terroir_Fungi_Fruits_Genus_Cabernet_Sauvignon
Fungi1920_vine_R <- Drama_Terroir_Fungi_Fruits_Genus_Merlot

# Calculate compositional version of the data#
# (relative abundances) #
Fungi1920_vine_R.rel <- microbiome::transform(Fungi1920_vine_R, "compositional")

##agglomerate in Genus level##
Fungi1920_vine_R.rel_Gglomed


#Check for the core ASVs
core.taxa.standard <- core_members(Fungi1920_vine_R.rel, detection = 0.01, prevalence = 70/100)

print(core.taxa.standard)

saveRDS(Fungi1920_vine_R.rel_Gglomed, file = "Fungi1920_vine_R.rel_Gglomed.RDS")

