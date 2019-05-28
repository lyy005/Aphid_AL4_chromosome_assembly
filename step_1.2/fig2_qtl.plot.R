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
chr1 = read.table("julie.chr2.blast.out.filtered.same.loci.combined", header = T)
chr2 = read.table("julie.chr1.blast.out.filtered.same.loci.combined", header = T)
chr3 = read.table("julie.chr4.blast.out.filtered.same.loci.combined", header = T)
chrx = read.table("julie.chr3.blast.out.filtered.same.loci.combined", header = T)

p1 <- ggplot(chr1, aes(x=-1*scaffold_position/1000000, y=cM)) + 
  xlim(-164,0) + 
  ylim(0,120) + 
  geom_point(color="#0073C2") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank(),
        text = element_text(size=20))
p2 <- ggplot(chr2, aes(x=scaffold_position/1000000, y=cM)) + 
  ylim(0,120) + 
  geom_point(color="#868686") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank(),
        text = element_text(size=20))
p3 <- ggplot(chr3, aes(x=scaffold_position/1000000, y=cM)) + 
  ylim(0,120) + 
  geom_point(color="#CD534C") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank(),
        text = element_text(size=20))
px <- ggplot(chrx, aes(x=scaffold_position/1000000, y=cM)) + 
  ylim(0,120) + 
  geom_point(color="#EFC000") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank(),
        text = element_text(size=20))

grid.arrange(p1, p2, p3, px, nrow = 2)
