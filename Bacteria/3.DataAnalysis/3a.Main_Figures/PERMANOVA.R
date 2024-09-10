##PERMANOVA##
##PERMANOVA Variables (perm. 999), Vegan package##
Drama_Terroir_Bacteria_Fruits_100##RA %

mypermanova_Drama_Terroir_Bacteria_Fruits_100 <- adonis2(Drama_Terroir_Bacteria_Fruits_100@otu_table ~ Terroir_Unit + Cultivar + Vintage + Geographic_Loacation, method = "bray", data = data.frame(Drama_Terroir_Bacteria_Fruits_100@sam_data))

write.table(data.frame(mypermanova_Drama_Terroir_Bacteria_Fruits_100), file="mypermanova_Drama_Terroir_Bacteria_Fruits_100.txt", quote = F,col.names = NA, sep="\t")