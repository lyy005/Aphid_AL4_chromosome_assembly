library(ggplot2)
library(ggsci)

# setwd("/YourWorkingDirectory/") # set the working directory
qtl = read.table("all.combined.scaffold_name", header = T) # read the combined table

# replace scaffold names with chromosome IDs
qtl$chr <- sub("scaffold_21967", "chr2", qtl$scaffold)
qtl$chr <- sub("scaffold_20849", "chr1", qtl$chr)
qtl$chr <- sub("scaffold_21646", "chr3", qtl$chr)
qtl$chr <- sub("scaffold_21773", "chrX", qtl$chr)

# Subset the genes on different long scaffolds (chromosomes)
chrx = subset(qtl, chr == "chrX") # chr x
chr1 = subset(qtl, chr == "chr1") # chr 1
chr2 = subset(qtl, chr == "chr2") # chr 2
chr3 = subset(qtl, chr == "chr3") # chr 3

p1 <- ggplot(chrx, aes(x=scaffold_position/1000000, y=cM)) + 
  xlim(0,126) + ylim(0,120) + 
  geom_point(color="#EFC000") + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())
p2 <- ggplot(chr1, aes(x=-1*scaffold_position/1000000, y=cM)) + 
  xlim(-164,0) + ylim(0,120) + 
  geom_point(color="#0073C2") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"),
        axis.title.x=element_blank(), axis.title.y=element_blank())
p3 <- ggplot(chr2, aes(x=scaffold_position/1000000, y=cM)) + 
  xlim(0,110) + ylim(0,120) + 
  geom_point(color="#868686") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())
p4 <- ggplot(chr3, aes(x=scaffold_position/1000000, y=cM)) + 
  xlim(0,42) + ylim(0,120) + 
  geom_point(color="#CD534C") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())
grid.arrange(p2, p3, p4, p1, nrow = 2) 
