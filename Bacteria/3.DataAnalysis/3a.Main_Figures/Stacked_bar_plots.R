##Bar plots##
##top 18 most abundant ASVs at Genus Level#

Drama_Terroir_Bacteria_Fruits_100

Drama_Terroir_Bacteria_Fruits_100_Genus <- tax_glom(Drama_Terroir_Bacteria_Fruits_100, taxrank = "Genus") 

myTaxa18_Drama_Terroir_Bacteria_Fruits_100_Genus <- names(sort(taxa_sums(Drama_Terroir_Bacteria_Fruits_100_Genus), decreasing = TRUE)[1:18]) 

Top18_Drama_Terroir_Bacteria_Fruits_100_Genus <- prune_taxa(myTaxa18_Drama_Terroir_Bacteria_Fruits_100_Genus, Drama_Terroir_Bacteria_Fruits_100_Genus) 

write.table(data.frame(sample_data(Top18_Drama_Terroir_Bacteria_Fruits_100_Genus)), file="Top18_Drama_Terroir_Bacteria_Fruits_100_Genus.txt", quote = F,col.names = NA, sep="\t")

pdf(file = "L.pdf", width = 14, height = 7)

plot_bar(Top18_Drama_Terroir_Bacteria_Fruits_100_Genus, x="ID", fill="Genus", title = "") + facet_grid(cols = vars(Cultivar), rows = vars(Vintage)) + geom_col() + scale_fill_manual(values = mycols)

dev.off()

DONE
