####Bar plots##
##top 12 most abundant ASVs at Phylum and Order level# 

Drama_Terroir_Fungi_Fruits_Phylum <- tax_glom(Drama_Terroir_Fungi_Fruits, taxrank = "Phylum")

Drama_Terroir_Fungi_Fruits_Phylum_100 <- transform_sample_counts(Drama_Terroir_Fungi_Fruits_Phylum, function(OTU) 100*OTU/sum(OTU))

Drama_Terroir_Fungi_Fruits_Order <- tax_glom(Drama_Terroir_Fungi_Fruits, taxrank = "Order")

Drama_Terroir_Fungi_Fruits_Order_100 <- transform_sample_counts(Drama_Terroir_Fungi_Fruits_Order, function(OTU) 100*OTU/sum(OTU))

##top 12 most abundant ASVs at Phylum level
myTaxa11_Drama_Terroir_Fungi_Fruits_Phylum_100 <- names(sort(taxa_sums(Drama_Terroir_Fungi_Fruits_Phylum_100), decreasing = TRUE)[1:12])  

Top11_Drama_Terroir_Fungi_Fruits_Phylum_100 <- prune_taxa(myTaxa11_Drama_Terroir_Fungi_Fruits_Phylum_100, Drama_Terroir_Fungi_Fruits_Phylum_100)

taxa_names(Top11_Drama_Terroir_Fungi_Fruits_Phylum_100)

- - - - - - - -- - -?? ASVs ??? plot -  -- - -- - --
  
  mytax11_Drama_Terroir_Fungi_Fruits_Phylum_100 <- data.frame(tax_table(Top11_Drama_Terroir_Fungi_Fruits_Phylum_100), stringsAsFactors = F)

# For ITS - Remove letter from taxonomy
for (i in c(1:nrow(mytax11_Drama_Terroir_Fungi_Fruits_Phylum_100))) {
  for(j in c(1:ncol(mytax11_Drama_Terroir_Fungi_Fruits_Phylum_100))) {
    mytax11_Drama_Terroir_Fungi_Fruits_Phylum_100[i,j] <- gsub("[a-z]__","",mytax11_Drama_Terroir_Fungi_Fruits_Phylum_100[i,j])
  }
}

mytxplot11_Drama_Terroir_Fungi_Fruits_Phylum_100 <- data.frame(OTU = row.names(mytax11_Drama_Terroir_Fungi_Fruits_Phylum_100), 
                                                               txplt = paste(row.names(mytax11_Drama_Terroir_Fungi_Fruits_Phylum_100), " ", mytax11_Drama_Terroir_Fungi_Fruits_Phylum_100$Phylum,  ":", mytax11_Drama_Terroir_Fungi_Fruits_Phylum_100$Phylum,  sep = ""))

row.names(mytxplot11_Drama_Terroir_Fungi_Fruits_Phylum_100) <- mytxplot11_Drama_Terroir_Fungi_Fruits_Phylum_100$Phylum

taxa_names(Top11_Drama_Terroir_Fungi_Fruits_Phylum_100) <- mytxplot11_Drama_Terroir_Fungi_Fruits_Phylum_100[taxa_names(Top11_Drama_Terroir_Fungi_Fruits_Phylum_100),"txplt"]

pdf(file = "L.pdf", width = 14, height = 7)

plot_bar(Top11_Drama_Terroir_Fungi_Fruits_Phylum_100, x="ID", fill="Phylum", title = "") + facet_grid(cols = vars(Cultivar), rows = vars(Vintage)) + geom_col() + scale_fill_manual(values = mycols)

plot_bar(Top11_Drama_Terroir_Fungi_Fruits_Phylum_100, x="ID", fill="Phylum", title = "") + facet_grid(rows = vars(Vintage)) + geom_col() + scale_fill_manual(values = mycols)

##top 12 most abundant ASVs at Order level
myTaxa11_Drama_Terroir_Fungi_Fruits_Order_100 <- names(sort(taxa_sums(Drama_Terroir_Fungi_Fruits_Order_100), decreasing = TRUE)[1:12])  

Top11_Drama_Terroir_Fungi_Fruits_Order_100 <- prune_taxa(myTaxa11_Drama_Terroir_Fungi_Fruits_Order_100, Drama_Terroir_Fungi_Fruits_Order_100)

taxa_names(Top11_Drama_Terroir_Fungi_Fruits_Order_100)

- - - - - - - -- - -?? ASVs ??? plot -  -- - -- - --
  
  mytax11_Drama_Terroir_Fungi_Fruits_Order_100 <- data.frame(tax_table(Top11_Drama_Terroir_Fungi_Fruits_Order_100), stringsAsFactors = F)

# For ITS - Remove letter from taxonomy
for (i in c(1:nrow(mytax11_Drama_Terroir_Fungi_Fruits_Order_100))) {
  for(j in c(1:ncol(mytax11_Drama_Terroir_Fungi_Fruits_Order_100))) {
    mytax11_Drama_Terroir_Fungi_Fruits_Order_100[i,j] <- gsub("[a-z]__","",mytax11_Drama_Terroir_Fungi_Fruits_Order_100[i,j])
  }
}

mytxplot11_Drama_Terroir_Fungi_Fruits_Order_100 <- data.frame(OTU = row.names(mytax11_Drama_Terroir_Fungi_Fruits_Order_100), 
                                                              txplt = paste(row.names(mytax11_Drama_Terroir_Fungi_Fruits_Order_100), " ", mytax11_Drama_Terroir_Fungi_Fruits_Order_100$Order,  ":", mytax11_Drama_Terroir_Fungi_Fruits_Order_100$Order,  sep = ""))

row.names(mytxplot11_Drama_Terroir_Fungi_Fruits_Order_100) <- mytxplot11_Drama_Terroir_Fungi_Fruits_Order_100$Order

taxa_names(Top11_Drama_Terroir_Fungi_Fruits_Order_100) <- mytxplot11_Drama_Terroir_Fungi_Fruits_Order_100[taxa_names(Top11_Drama_Terroir_Fungi_Fruits_Order_100),"txplt"]

pdf(file = "L.pdf", width = 14, height = 7)

plot_bar(Top11_Drama_Terroir_Fungi_Fruits_Order_100, x="ID", fill="Order", title = "") + facet_grid(cols = vars(Cultivar), rows = vars(Vintage)) + geom_col() + scale_fill_manual(values = mycols)

DONE