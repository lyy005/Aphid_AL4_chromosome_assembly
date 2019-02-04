library(ggplot2)
library(gridExtra)
kaks = read.table("distanceKaKs.table", header = T)

# Subset the genes on different long scaffolds (chromosomes)
chrx = subset(kaks, gene1_scaf == "Scaffold_21773" & distance > 0 & Ks <= 2.0) # chr x
chr2 = subset(kaks, gene1_scaf == "Scaffold_21967" & distance > 0 & Ks <= 2.0) # chr 2
chr1 = subset(kaks, gene1_scaf == "Scaffold_20849" & distance > 0 & Ks <= 2.0) # chr 1
chr3 = subset(kaks, gene1_scaf == "Scaffold_21646" & distance > 0 & Ks <= 2.0) # chr 3

###
# Plot Ks histogram by chr
###
ggplot(chrx, aes(x=Ks)) + 
#  ylim(0,200) + 
  scale_x_continuous(limits=c(0,2), breaks=0:2) + 
geom_histogram(binwidth=1, boundary = 0, fill='#EFC000', closed = "left") + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())

ggplot(chrx, aes(x=Ks)) + 
  xlim(0,2) + #ylim(0,65) + 
  geom_histogram(binwidth=0.1, fill='#EFC000', boundary = 0, closed = "left") + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())

p1 <- ggplot(chrx, aes(x=Ks)) + 
  xlim(0,2) + ylim(0,65) + 
  geom_histogram(binwidth=0.01, fill='#EFC000', boundary = 0, closed = "left") + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())
p2 <- ggplot(chr1, aes(x=Ks)) + 
  xlim(0,2) + ylim(0,65) + 
  geom_histogram(binwidth=0.01, fill='#0073C2', boundary = 0, closed = "left") + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"),
        axis.title.x=element_blank(), axis.title.y=element_blank())
p3 <- ggplot(chr2, aes(x=Ks)) + 
#  xlim(0,2) + ylim(0,65) + 
  geom_histogram(binwidth=0.01, fill = '#868686', boundary = 0, closed = "left") + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())
p4 <- ggplot(chr3, aes(x=Ks)) + 
  xlim(0,2) + ylim(0,65) + 
  geom_histogram(binwidth=0.01, fill = '#CD534C', boundary = 0, closed = "left")+ 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())
grid.arrange(p2, p3, p4, p1, nrow = 2) 


###
# Ks plot of genes on different scaffolds
###
diff = subset(kaks, distance < 0) # different scafs
pall <- ggplot(kaks, aes(Ks)) + 
  xlim(0,2) + 
  geom_histogram(binwidth=0.02) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())
pdiff <- ggplot(diff, aes(Ks)) + 
  xlim(0,2) + 
  geom_histogram(binwidth=0.02) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())

# Ks plot of genes on different big scaffolds
diff_2chrs = read.table("distanceKaKs.table.2chrs", header = T)
diff_1chr1short = read.table("distanceKaKs.table.1chr1short", header = T)
diff_2shorts = read.table("distanceKaKs.table.2shorts", header = T)

pdiff_2chrs <- ggplot(diff_2chrs, aes(Ks)) + 
  xlim(0,2) + ylim(0, 150) + 
  geom_histogram(binwidth=0.02, fill='darkblue') + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())

pdiff_1chr1short <- ggplot(diff_1chr1short, aes(Ks)) + 
  xlim(0,2) + ylim(0, 150) + 
  geom_histogram(binwidth=0.02, fill='#999999') + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())

pdiff_2shorts <- ggplot(diff_2shorts, aes(Ks)) + 
  xlim(0,2) + ylim(0, 150) + 
  geom_histogram(binwidth=0.02, fill = '#E69F00') + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())

grid.arrange(pall, pdiff, pdiff_2chrs, pdiff_1chr1short, pdiff_2shorts,ncol = 2) 


###
# 
###
# Subset the genes on different long scaffolds (chromosomes)
chrx = subset(diff_1chr1short, gene1_scaf == "Scaffold_21773" | gene2_scaf == "Scaffold_21773") # chr x
chr2 = subset(diff_1chr1short, gene1_scaf == "Scaffold_21967" | gene2_scaf == "Scaffold_21967") # chr 2
chr1 = subset(diff_1chr1short, gene1_scaf == "Scaffold_20849" | gene2_scaf == "Scaffold_20849")# chr 1
chr3 = subset(diff_1chr1short, gene1_scaf == "Scaffold_21646" | gene2_scaf == "Scaffold_21646") # chr 3

p1 <- ggplot(chrx, aes(x=Ks)) + 
  xlim(0,2) + ylim(0,60) + 
  geom_histogram(binwidth=0.01, fill='darkblue') + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())
p2 <- ggplot(chr1, aes(x=Ks)) + 
  xlim(0,2) + ylim(0,60) + 
  geom_histogram(binwidth=0.01, fill='#999999') + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"),
        axis.title.x=element_blank(), axis.title.y=element_blank())
p3 <- ggplot(chr2, aes(x=Ks)) + 
  xlim(0,2) + ylim(0,60) + 
  geom_histogram(binwidth=0.01, fill = '#E69F00') + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())
p4 <- ggplot(chr3, aes(x=Ks)) + 
  xlim(0,2) + ylim(0,60) + 
  geom_histogram(binwidth=0.01, fill = '#56B4E9')+ 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())
grid.arrange(p1, p2, p3, p4, nrow = 2) 

###
# scatter plot distance vs. Ks
###
# alternative scales: http://www.moeding.net/2011/10/metric-prefixes-for-ggplot2-scales/

library(sitools)
library(scales)
library(ggforce)
library(units)
p1 <- ggplot(chrx, aes(x=Ks, y=distance / 1000000)) + 
  geom_point(shape=1, color='#EFC000') + 
  xlim(0,2) + #ylim(0, 500000) + 
  scale_y_continuous(labels=comma) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())
p2 <- ggplot(chr1, aes(x=Ks, y=distance / 1000000)) + 
  geom_point(shape=1, color = '#0073C2') + 
  xlim(0,2) + #ylim(0, 500000) + 
  scale_y_continuous(labels=comma) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())
p3 <- ggplot(chr2, aes(x=Ks, y=distance / 1000000)) + 
  geom_point(shape=1, color = '#868686') + 
  xlim(0,2) + #ylim(0, 500000) + 
  scale_y_continuous(labels=comma) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())
p4 <- ggplot(chr3, aes(x=Ks, y=distance / 1000000)) + 
  geom_point(shape=1, color = '#CD534C') + 
  xlim(0,2) + #ylim(0, 500000) + 
  scale_y_continuous(labels=comma) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())
grid.arrange(p2, p3, p4, p1, nrow = 2)

# plot 2 histogram together
kaks2 = read.table("distanceKaKs.table.acyr", header = T)
kaks$genome <- "AL4"
kaks2$genome <- "Acyr"
all <- rbind(kaks, kaks2)

p1 <- ggplot(kaks, aes(Ks)) + 
  xlim(0,2) + ylim(0,500) +
  geom_histogram(binwidth=0.02) 

p2 <- ggplot(kaks2, aes(Ks)) + 
  xlim(0,2) + ylim(0,500) +
  geom_histogram(binwidth=0.02) 
grid.arrange(p1, p2, nrow = 1)

+ 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())


ggplot(all, aes(Ks, color = genome, fill = genome)) + 
  xlim(0,2) + 
  geom_histogram(binwidth=0.03, alpha = 0.5, position = 'identity') 
+ 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"), 
        axis.title.x=element_blank(), axis.title.y=element_blank())

