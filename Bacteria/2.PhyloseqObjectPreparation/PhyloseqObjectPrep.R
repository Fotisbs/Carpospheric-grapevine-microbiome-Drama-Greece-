##Start the analysis Drama Terroir by uploading the phyloseq object
Drama_Terroir_Bacteria_Fruits.rds

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