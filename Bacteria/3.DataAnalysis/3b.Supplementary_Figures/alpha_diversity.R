##ALPHADIVERSITY FULL ANALYSIS
adiv <- plot_richness(Drama_Terroir_Bacteria_Fruits, measures=c("Shannon", "Fisher", "Observed", "ACE", "InvSimpson")) 


## calculate Good's coverage estimate as well
install.packages("entropart")
library(entropart)

good <- MetaCommunity(t(Drama_Terroir_Bacteria_Fruits@otu_table))$SampleCoverage.communities

good_tbl <- data.frame(samples = names(good), variable = rep("coverage",length(good)), value=good)

alpha_long <- rbind(adiv$data[,c("samples", "variable", "value")], good_tbl)

# convert long to wide
library(reshape2)
alpha_wide <- dcast(alpha_long, samples ~ variable, value.var="value")
row.names(alpha_wide) <- alpha_wide$samples

alpha_wide <- alpha_wide[,c("Shannon", "Fisher", "Observed", "ACE", "InvSimpson")]

colnames(alpha_wide) <- c("Shannon", "Fisher", "Observed", "ACE", "InvSimpson")

alpha_wide_fact <- merge(alpha_wide, data.frame(sample_data(Drama_Terroir_Bacteria_Fruits)), by = "row.names")

row.names(alpha_wide_fact) <- alpha_wide_fact$Row.names
alpha_wide_fact <- alpha_wide_fact[-which(colnames(alpha_wide_fact)%in%"Row.names")]


#alpha_wide_fact$mynms <- factor(alpha_wide_fact$mynms)

library("agricolae")
#### perform anova or equivalent for the alpha diversity indices ----

##### from
mytestvars <- colnames(alpha_wide)[5:1]


#library("agricolae")
#library("dplyr")

mystatsout <- list()

##edo orizo tous factors sto sigkekrimeno paradeigma exo petaxei exo ton 2 kai 3 kai arxizo apo ton 6 afou prin einai ta alpha diversity indexes##
mytestfacts <- colnames(alpha_wide_fact[,6:ncol(alpha_wide_fact)])[-c(2:3)]

#mytestfacts<- alpha_wide_fact%>%
# select(stage)

for(mytestfact in mytestfacts){
  cairo_pdf(paste("alpha_div_plot_",mytestfact,"TTT.pdf", sep = ""), height = 5, width = 9, onefile = T)
  par(mfrow = c(2,3))
  for(mytestvar in mytestvars) {
    
    
    
    # create the aov matrix
    myaovmatrix <- alpha_wide_fact
    
    # run a shapiro wilk test to select parametric or non parametric analysis
    shap_out <- shapiro.test(myaovmatrix[,mytestvar])
    mystatsout[[paste(mytestvar, sep = " // ")]][["shap"]] <- shap_out
    
    # run the parametric or non-parametric analysis according to the shapiro.test results
    if(shap_out$p.value < 0.05){
      # non-parametric
      mykrusk <- kruskal(myaovmatrix[,mytestvar], myaovmatrix[,mytestfact], group = T, p.adj = "BH")
      
      mystatsout[[paste(mytestvar, sep = " // ")]][["krusk"]] <- mykrusk
      # prepare the barplot
      #mytestvarord <- c("Control","Karla","MC2","MC12","Karla + MC12")
      myaovmatrix[,mytestfact] <- factor(myaovmatrix[,mytestfact])
      mytestvarord <- levels(myaovmatrix[,mytestfact])
      par(mar = c(2,10,4,2))
      barerrplt <- bar.err(mykrusk$means[mytestvarord[length(mytestvarord):1],], variation="SE", xlim=c(0,1.2*max(mykrusk$means[mytestvarord[length(mytestvarord):1],1] + mykrusk$means[mytestvarord[length(mytestvarord):1],3])),horiz=TRUE, bar=T, col="grey60", space=1, main= paste(mytestvar), las=1)
      #mypltmt <- data.frame(myHSDtest$means[mytestvarord,1:2],sigletters = myHSDtest$groups[mytestvarord,"groups"], check.names = F)
      
      # delete the significance group letters in the case that the anova was not significant
      par(xpd = T)
      if(mykrusk$statistics$p.chisq <= 0.05){
        if(all(mykrusk$groups[mytestvarord[length(mytestvarord):1],2] == "a")){
          mykrusk$groups[mytestvarord[length(mytestvarord):1],2] <- ""
        }
        text(x = mykrusk$means[mytestvarord[length(mytestvarord):1],1] + mykrusk$means[mytestvarord[length(mytestvarord):1],3]/sqrt(mykrusk$means$r), barerrplt$x,labels = mykrusk$groups[mytestvarord[length(mytestvarord):1],2], pos = 4, font = 3)
        par(xpd = F)
      }
    } else { 
      # perform the parametric
      
      # select the alphadiv matrix and design rows
      myform <- as.formula(paste("`",mytestvar,"` ~ ",mytestfact, sep = ""))
      mymod <- aov(myform, data = myaovmatrix)
      mysumaov <- summary(mymod)
      
      mystatsout[[paste(mytestvar, sep = " // ")]][["ANOVA"]] <- mysumaov
      
      # order the matrices etc
      mytestvarord <- levels(factor(myaovmatrix[,mytestfact]))
      
      # run the Tukey test
      myHSDtest <- HSD.test(mymod, mytestfact, group=T)
      
      mystatsout[[paste(mytestvar, sep = " // ")]][["HSD test"]] <- myHSDtest
      
      # prepare the barplot
      par(mar = c(2,10,4,2))
      barerrplt <- bar.err(myHSDtest$means[mytestvarord[length(mytestvarord):1],], variation="SE", xlim=c(0,1.2*max(myHSDtest$means[mytestvarord[length(mytestvarord):1],1] + myHSDtest$means[mytestvarord[length(mytestvarord):1],2])),horiz=TRUE, bar=T, col="grey60", space=1, main= paste(mytestvar), las=1)
      #mypltmt <- data.frame(myHSDtest$means[mytestvarord,1:2],sigletters = myHSDtest$groups[mytestvarord,"groups"], check.names = F)
      
      # delete the significance group letters in the case that the anova was not significant
      par(xpd = T)
      if(mysumaov[[1]]$`Pr(>F)`[1] <= 0.05){
        if(all(myHSDtest$groups[mytestvarord[length(mytestvarord):1],2] == "a")){
          myHSDtest$groups[mytestvarord[length(mytestvarord):1],2] <- ""
        }
        text(x = myHSDtest$means[mytestvarord[length(mytestvarord):1],1] + myHSDtest$means[mytestvarord[length(mytestvarord):1],2]/sqrt(myHSDtest$means$r), barerrplt$x,labels = myHSDtest$groups[mytestvarord[length(mytestvarord):1],2], pos = 4)
        par(xpd = F)
      }
    }
    
    
  }
  dev.off()
}

capture.output(mystatsout,file = paste("alpha_div_stats_",mytestfact,".txt", sep = ""))


DONE