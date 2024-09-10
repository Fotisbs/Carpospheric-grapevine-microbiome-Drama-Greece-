##NMDS analysis for each Cultivar
##Seperate Cultivars (Agiorgitiko, Cabernet Sauvignon, Merlot)##
##Agiorgitiko  
Drama_Terroir_Bacteria_Fruits_Agiorgitiko <- subset_samples(Drama_Terroir_Bacteria_Fruits, Cultivar=="Agiorgitiko")

Drama_Terroir_Bacteria_Fruits_Agiorgitiko <- prune_taxa(taxa_sums(Drama_Terroir_Bacteria_Fruits_Agiorgitiko)>0,Drama_Terroir_Bacteria_Fruits_Agiorgitiko)

saveRDS(Drama_Terroir_Bacteria_Fruits_Agiorgitiko, file = "Drama_Terroir_Bacteria_Fruits_Agiorgitiko.RDS")

Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100 <- transform_sample_counts(Drama_Terroir_Bacteria_Fruits_Agiorgitiko, function(OTU) 100*OTU/sum(OTU))

saveRDS(Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100, file = "Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100.RDS")

##NMDS Agiorgitiko
##ordination matrix
ord.nmds.bray2 <- ordinate(Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100, method="NMDS", distance="bray")
##Vintage
plot_ordination(Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100, ord.nmds.bray2, color="Vintage", shape ="", label = "", title=paste("NMDS (stress ",round(ord.nmds.bray2$stress, 2),")", sep = "")) + geom_point(size = 4) + scale_color_manual(values=c("#984EA3","#FF7F00"))
##Geographic_Location
plot_ordination(Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100, ord.nmds.bray2, color="Geographic_Location", shape ="", label = "", title=paste("NMDS (stress ",round(ord.nmds.bray2$stress, 2),")", sep = "")) + geom_point(size = 4) + scale_color_manual(values=c("#984EA3","#FF7F00","#33A02C","#80b1d3","Blue","Black"))
##Terroir_Unit
plot_ordination(Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100, ord.nmds.bray2, color="Terroir_Unit", shape ="", label = "", title=paste("NMDS (stress ",round(ord.nmds.bray2$stress, 2),")", sep = "")) + geom_point(size = 4) + scale_color_manual(values=c("hotpink2","gold2","olivedrab3"))


##Cabernet_Sauvignon  
Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon <- subset_samples(Drama_Terroir_Bacteria_Fruits, Cultivar=="Cabernet_Sauvignon")

Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon <- prune_taxa(taxa_sums(Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon)>0,Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon)

saveRDS(Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon, file = "Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon.RDS")

Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100 <- transform_sample_counts(Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon, function(OTU) 100*OTU/sum(OTU))

saveRDS(Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100, file = "Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100.RDS")

##NMDS Cabernet_Sauvignon
##ordination matrix
ord.nmds.bray3 <- ordinate(Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100, method="NMDS", distance="bray")
##Vintage
plot_ordination(Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100, ord.nmds.bray3, color="Vintage", shape ="", label = "", title=paste("NMDS (stress ",round(ord.nmds.bray3$stress, 2),")", sep = "")) + geom_point(size = 4) + scale_color_manual(values=c("#984EA3","#FF7F00"))
##Geographic_Location
plot_ordination(Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100, ord.nmds.bray3, color="Geographic_Location", shape ="", label = "", title=paste("NMDS (stress ",round(ord.nmds.bray3$stress, 2),")", sep = "")) + geom_point(size = 4) + scale_color_manual(values=c("#984EA3","#FF7F00","#33A02C","#80b1d3","Blue","Black"))
##Terroir_Unit
plot_ordination(Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100, ord.nmds.bray3, color="Terroir_Unit", shape ="", label = "", title=paste("NMDS (stress ",round(ord.nmds.bray3$stress, 2),")", sep = "")) + geom_point(size = 4) + scale_color_manual(values=c("hotpink2","gold2"))


##Merlot  
Drama_Terroir_Bacteria_Fruits_Merlot <- subset_samples(Drama_Terroir_Bacteria_Fruits, Cultivar=="Merlot")

Drama_Terroir_Bacteria_Fruits_Merlot <- prune_taxa(taxa_sums(Drama_Terroir_Bacteria_Fruits_Merlot)>0,Drama_Terroir_Bacteria_Fruits_Merlot)

saveRDS(Drama_Terroir_Bacteria_Fruits_Merlot, file = "Drama_Terroir_Bacteria_Fruits_Merlot.RDS")

Drama_Terroir_Bacteria_Fruits_Merlot_100 <- transform_sample_counts(Drama_Terroir_Bacteria_Fruits_Merlot, function(OTU) 100*OTU/sum(OTU))

saveRDS(Drama_Terroir_Bacteria_Fruits_Merlot_100, file = "Drama_Terroir_Bacteria_Fruits_Merlot_100.RDS")

##NMDS Merlot
##ordination matrix
ord.nmds.bray4 <- ordinate(Drama_Terroir_Bacteria_Fruits_Merlot_100, method="NMDS", distance="bray")
##Vintage
plot_ordination(Drama_Terroir_Bacteria_Fruits_Merlot_100, ord.nmds.bray4, color="Vintage", shape ="", label = "", title=paste("NMDS (stress ",round(ord.nmds.bray4$stress, 2),")", sep = "")) + geom_point(size = 4) + scale_color_manual(values=c("#984EA3","#FF7F00"))
##Geographic_Location
plot_ordination(Drama_Terroir_Bacteria_Fruits_Merlot_100, ord.nmds.bray4, color="Geographic_Location", shape ="", label = "", title=paste("NMDS (stress ",round(ord.nmds.bray4$stress, 2),")", sep = "")) + geom_point(size = 4) + scale_color_manual(values=c("#984EA3","#FF7F00","#33A02C","#80b1d3","Blue","Black"))
##Terroir_Unit
plot_ordination(Drama_Terroir_Bacteria_Fruits_Merlot_100, ord.nmds.bray4, color="Terroir_Unit", shape ="", label = "", title=paste("NMDS (stress ",round(ord.nmds.bray4$stress, 2),")", sep = "")) + geom_point(size = 4) + scale_color_manual(values=c("#FF7F00","hotpink2","gold2"))

##Pairwise-permanova for each Cultivar (RA% object)##
library(pairwiseAdonis)
Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100
Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100
Drama_Terroir_Bacteria_Fruits_Merlot_100

##Agiorgitiko
mycmpfactor2_Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100 <- interaction(data.frame(Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100@sam_data)$Vintage, data.frame(Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100@sam_data)$Vintage) 

mympairwiseperm2_Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100 <- pairwise.adonis(Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100@otu_table, mycmpfactor2_Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100, sim.function = "vegdist", sim.method = "bray", p.adjust.m = "BH")##vintage vs vintage

mycmpfactor3_Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100 <- interaction(data.frame(Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100@sam_data)$Geographic_Location, data.frame(Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100@sam_data)$Geographic_Location) 

mympairwiseperm3_Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100 <- pairwise.adonis(Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100@otu_table, mycmpfactor3_Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100, sim.function = "vegdist", sim.method = "bray", p.adjust.m = "BH")##Geographic_Location vs Geographic_Location

mycmpfactor4_Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100 <- interaction(data.frame(Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100@sam_data)$Terroir_Unit, data.frame(Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100@sam_data)$Terroir_Unit) 

mympairwiseperm4_Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100 <- pairwise.adonis(Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100@otu_table, mycmpfactor4_Drama_Terroir_Bacteria_Fruits_Agiorgitiko_100, sim.function = "vegdist", sim.method = "bray", p.adjust.m = "BH")#Terroir_Unit vs Terroir_Unit

##Cabernet Sauvignon
mycmpfactor2_Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100 <- interaction(data.frame(Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100@sam_data)$Vintage, data.frame(Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100@sam_data)$Vintage) 

mympairwiseperm2_Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100 <- pairwise.adonis(Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100@otu_table, mycmpfactor2_Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100, sim.function = "vegdist", sim.method = "bray", p.adjust.m = "BH")##vintage vs vintage

mycmpfactor3_Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100 <- interaction(data.frame(Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100@sam_data)$Geographic_Location, data.frame(Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100@sam_data)$Geographic_Location) 

mympairwiseperm3_Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100 <- pairwise.adonis(Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100@otu_table, mycmpfactor3_Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100, sim.function = "vegdist", sim.method = "bray", p.adjust.m = "BH")##Geographic_Location vs Geographic_Location

mycmpfactor4_Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100 <- interaction(data.frame(Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100@sam_data)$Terroir_Unit, data.frame(Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100@sam_data)$Terroir_Unit) 

mympairwiseperm4_Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100 <- pairwise.adonis(Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100@otu_table, mycmpfactor4_Drama_Terroir_Bacteria_Fruits_Cabernet_Sauvignon_100, sim.function = "vegdist", sim.method = "bray", p.adjust.m = "BH")#Terroir_Unit vs Terroir_Unit

##Merlot
mycmpfactor2_Drama_Terroir_Bacteria_Fruits_Merlot_100 <- interaction(data.frame(Drama_Terroir_Bacteria_Fruits_Merlot_100@sam_data)$Vintage, data.frame(Drama_Terroir_Bacteria_Fruits_Merlot_100@sam_data)$Vintage) 

mympairwiseperm2_Drama_Terroir_Bacteria_Fruits_Merlot_100 <- pairwise.adonis(Drama_Terroir_Bacteria_Fruits_Merlot_100@otu_table, mycmpfactor2_Drama_Terroir_Bacteria_Fruits_Merlot_100, sim.function = "vegdist", sim.method = "bray", p.adjust.m = "BH")##vintage vs vintage

mycmpfactor3_Drama_Terroir_Bacteria_Fruits_Merlot_100 <- interaction(data.frame(Drama_Terroir_Bacteria_Fruits_Merlot_100@sam_data)$Geographic_Location, data.frame(Drama_Terroir_Bacteria_Fruits_Merlot_100@sam_data)$Geographic_Location) 

mympairwiseperm3_Drama_Terroir_Bacteria_Fruits_Merlot_100 <- pairwise.adonis(Drama_Terroir_Bacteria_Fruits_Merlot_100@otu_table, mycmpfactor3_Drama_Terroir_Bacteria_Fruits_Merlot_100, sim.function = "vegdist", sim.method = "bray", p.adjust.m = "BH")##Geographic_Location vs Geographic_Location

mycmpfactor4_Drama_Terroir_Bacteria_Fruits_Merlot_100 <- interaction(data.frame(Drama_Terroir_Bacteria_Fruits_Merlot_100@sam_data)$Terroir_Unit, data.frame(Drama_Terroir_Bacteria_Fruits_Merlot_100@sam_data)$Terroir_Unit) 

mympairwiseperm4_Drama_Terroir_Bacteria_Fruits_Merlot_100 <- pairwise.adonis(Drama_Terroir_Bacteria_Fruits_Merlot_100@otu_table, mycmpfactor4_Drama_Terroir_Bacteria_Fruits_Merlot_100, sim.function = "vegdist", sim.method = "bray", p.adjust.m = "BH")#Terroir_Unit vs Terroir_Unit

DONE