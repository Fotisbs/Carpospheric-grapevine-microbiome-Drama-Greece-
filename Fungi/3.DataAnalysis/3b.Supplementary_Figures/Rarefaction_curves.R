##Rarefaction curves for fungi 
Drama_Terroir_Fungi_Fruits

a <- data.frame(t(otu_table(Drama_Terroir_Fungi_Fruits)))

rarecurve(a, step=50, cex=0.5, label = F, xlim=c(0,1500))