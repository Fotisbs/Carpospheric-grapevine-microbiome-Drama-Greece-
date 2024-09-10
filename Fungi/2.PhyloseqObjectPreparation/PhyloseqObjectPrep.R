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
