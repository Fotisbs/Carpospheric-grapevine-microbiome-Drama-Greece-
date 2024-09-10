##NMDS#
##Relative abundance transformation 100%
Drama_Terroir_Bacteria_Fruits_100 <- transform_sample_counts(Drama_Terroir_Bacteria_Fruits, function(OTU) 100*OTU/sum(OTU))

saveRDS(Drama_Terroir_Bacteria_Fruits_100, file = "Drama_Terroir_Bacteria_Fruits_100.RDS")


##ordination matrix
ord.nmds.bray1 <- ordinate(Drama_Terroir_Bacteria_Fruits_100, method="NMDS", distance="bray")
#Cultivar
plot_ordination(Drama_Terroir_Bacteria_Fruits_100, ord.nmds.bray1, color="Cultivar", shape ="", label = "", title=paste("NMDS (stress ",round(ord.nmds.bray1$stress, 2),")", sep = "")) + geom_point(size = 4) + scale_color_manual(values=c("#984EA3","#FF7F00","#33A02C"))
##Vintage
plot_ordination(Drama_Terroir_Bacteria_Fruits_100, ord.nmds.bray1, color="Vintage", shape ="", label = "", title=paste("NMDS (stress ",round(ord.nmds.bray1$stress, 2),")", sep = "")) + geom_point(size = 4) + scale_color_manual(values=c("#984EA3","#FF7F00"))
##Geographic_Location
plot_ordination(Drama_Terroir_Bacteria_Fruits_100, ord.nmds.bray1, color="Geographic_Location", shape ="", label = "", title=paste("NMDS (stress ",round(ord.nmds.bray1$stress, 2),")", sep = "")) + geom_point(size = 4) + scale_color_manual(values=c("#984EA3","#FF7F00","#33A02C","#80b1d3","Blue","Black"))
##Terroir_Unit
plot_ordination(Drama_Terroir_Bacteria_Fruits_100, ord.nmds.bray1, color="Terroir_Unit", shape ="", label = "", title=paste("NMDS (stress ",round(ord.nmds.bray1$stress, 2),")", sep = "")) + geom_point(size = 4) + scale_color_manual(values=c("#FF7F00","hotpink2","gold2","olivedrab3"))


##Pairwise-permanova (RA% object)##
library(pairwiseAdonis)

mycmpfactor_Drama_Terroir_Bacteria_Fruits_100 <- interaction(data.frame(Drama_Terroir_Bacteria_Fruits_100@sam_data)$Cultivar, data.frame(Drama_Terroir_Bacteria_Fruits_100@sam_data)$Cultivar) 

mympairwiseperm_Drama_Terroir_Bacteria_Fruits_100 <- pairwise.adonis(Drama_Terroir_Bacteria_Fruits_100@otu_table, mycmpfactor_Drama_Terroir_Bacteria_Fruits_100, sim.function = "vegdist", sim.method = "bray", p.adjust.m = "BH")##cultivar vs cultivar

mycmpfactor2_Drama_Terroir_Bacteria_Fruits_100 <- interaction(data.frame(Drama_Terroir_Bacteria_Fruits_100@sam_data)$Vintage, data.frame(Drama_Terroir_Bacteria_Fruits_100@sam_data)$Vintage) 

mympairwiseperm2_Drama_Terroir_Bacteria_Fruits_100 <- pairwise.adonis(Drama_Terroir_Bacteria_Fruits_100@otu_table, mycmpfactor2_Drama_Terroir_Bacteria_Fruits_100, sim.function = "vegdist", sim.method = "bray", p.adjust.m = "BH")##vintage vs vintage

mycmpfactor3_Drama_Terroir_Bacteria_Fruits_100 <- interaction(data.frame(Drama_Terroir_Bacteria_Fruits_100@sam_data)$Geographic_Location, data.frame(Drama_Terroir_Bacteria_Fruits_100@sam_data)$Geographic_Location) 

mympairwiseperm3_Drama_Terroir_Bacteria_Fruits_100 <- pairwise.adonis(Drama_Terroir_Bacteria_Fruits_100@otu_table, mycmpfactor3_Drama_Terroir_Bacteria_Fruits_100, sim.function = "vegdist", sim.method = "bray", p.adjust.m = "BH")##Geographic_Location vs Geographic_Location

mycmpfactor4_Drama_Terroir_Bacteria_Fruits_100 <- interaction(data.frame(Drama_Terroir_Bacteria_Fruits_100@sam_data)$Terroir_Unit, data.frame(Drama_Terroir_Bacteria_Fruits_100@sam_data)$Terroir_Unit) 

mympairwiseperm4_Drama_Terroir_Bacteria_Fruits_100 <- pairwise.adonis(Drama_Terroir_Bacteria_Fruits_100@otu_table, mycmpfactor4_Drama_Terroir_Bacteria_Fruits_100, sim.function = "vegdist", sim.method = "bray", p.adjust.m = "BH")#Terroir_Unit vs Terroir_Unit

DONE