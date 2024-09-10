##PERMANOVA for each cultivar##
##PERMANOVA Variables (perm. 999), Vegan package##
Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100
Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100
Drama_Terroir_Bacteria_Fruits_Merlot_100

#Agiorgitiko
mypermanova_Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100 <- adonis2(Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100@otu_table ~ Terroir_Unit + Cultivar + Vintage + Geographic_Loacation, method = "bray", data = data.frame(Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100@sam_data))

write.table(data.frame(mypermanova_Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100), file="mypermanova_Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100.txt", quote = F,col.names = NA, sep="\t")

#Cabernet_Sauvignon
mypermanova_Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100 <- adonis2(Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100@otu_table ~ Terroir_Unit + Cultivar + Vintage + Geographic_Loacation, method = "bray", data = data.frame(Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100@sam_data))

write.table(data.frame(mypermanova_Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100), file="mypermanova_Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100.txt", quote = F,col.names = NA, sep="\t")

#Merlot
mypermanova_Drama_Terroir_Bacteria_Fruits_Merlot_100 <- adonis2(Drama_Terroir_Bacteria_Fruits_Merlot_100@otu_table ~ Terroir_Unit + Cultivar + Vintage + Geographic_Loacation, method = "bray", data = data.frame(Drama_Terroir_Bacteria_Fruits_Merlot_100@sam_data))

write.table(data.frame(mypermanova_Drama_Terroir_Bacteria_Fruits_Merlot_100), file="mypermanova_Drama_Terroir_Bacteria_Fruits_Merlot_100.txt", quote = F,col.names = NA, sep="\t")
