##Bar plots##
##top 12 most abundant ASVs# 
myTaxa11_Drama_Terroir_Fungi_Fruits_100 <- names(sort(taxa_sums(Drama_Terroir_Fungi_Fruits_100), decreasing = TRUE)[1:12])  

Top11_Drama_Terroir_Fungi_Fruits_100 <- prune_taxa(myTaxa11_Drama_Terroir_Fungi_Fruits_100, Drama_Terroir_Fungi_Fruits_100)

taxa_names(Top11_Drama_Terroir_Fungi_Fruits_100)

- - - - - - - -- - -?? ASVs ??? plot -  -- - -- - --
  
  mytax11_Drama_Terroir_Fungi_Fruits_100 <- data.frame(tax_table(Top11_Drama_Terroir_Fungi_Fruits_100), stringsAsFactors = F)

# For ITS - Remove letter from taxonomy
for (i in c(1:nrow(mytax11_Drama_Terroir_Fungi_Fruits_100))) {
  for(j in c(1:ncol(mytax11_Drama_Terroir_Fungi_Fruits_100))) {
    mytax11_Drama_Terroir_Fungi_Fruits_100[i,j] <- gsub("[a-z]__","",mytax11_Drama_Terroir_Fungi_Fruits_100[i,j])
  }
}

mytxplot11_Drama_Terroir_Fungi_Fruits_100 <- data.frame(OTU = row.names(mytax11_Drama_Terroir_Fungi_Fruits_100), 
                                                        txplt = paste(row.names(mytax11_Drama_Terroir_Fungi_Fruits_100), " ", mytax11_Drama_Terroir_Fungi_Fruits_100$Genus,  ":", mytax11_Drama_Terroir_Fungi_Fruits_100$Species,  sep = ""))

row.names(mytxplot11_Drama_Terroir_Fungi_Fruits_100) <- mytxplot11_Drama_Terroir_Fungi_Fruits_100$OTU

taxa_names(Top11_Drama_Terroir_Fungi_Fruits_100) <- mytxplot11_Drama_Terroir_Fungi_Fruits_100[taxa_names(Top11_Drama_Terroir_Fungi_Fruits_100),"txplt"]

pdf(file = "L.pdf", width = 14, height = 7)

plot_bar(Top11_Drama_Terroir_Fungi_Fruits_100, x="ID", fill="OTU", title = "") + facet_grid(cols = vars(Cultivar), rows = vars(Vintage)) + geom_col() + scale_fill_manual(values = mycols)


DONE