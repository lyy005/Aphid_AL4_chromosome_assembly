#library(phytools)
library(ggplot2)
#library(ggExtra)
#library(plotly)
#library(ggrepel)
library(cowplot)
library(ggpubr)
library(RColorBrewer)
library(ggsci)

setwd("/Users/yy/Work/local/Projects/aphid/r_scripts/")


##
# Ref: http://www.sthda.com/english/articles/24-ggpubr-publication-ready-plots/78-perfect-scatter-plots-with-correlation-and-marginal-histograms/
###
# 12 colors
all <- read.table("depthHeteroSNPcombined.table.sorted.filtered.500k", header = F)
all <- read.table("depthHeteroSNPcombined.table.sorted.filtered.500k_plus3", header = F)
all <- read.table("depthHeteroSNPcombined.table.sorted.filtered", header = F)

tb <- table(all$V1) 
all$V1 <- factor(all$V1, 
                 levels = names(tb[order(tb, decreasing = TRUE)])) 
sp <- ggscatter(all, x = "V20", y = "V23",
                color = "V1", palette = "jco",
                size = 2, alpha = 0.3, ggtheme = theme_bw(), xlab = "Male/Female Sequencing Depth Ratio", ylab = "Difference of Number Heterozygous SNPs in Females - in Males") 
#  +  scale_fill_manual(values = colorRampPalette(brewer.pal(12, "Accent"))(colourCount)) 
# Marginal boxplot of x (top panel) and y (right panel)
xplot <- ggviolin(all, x = "V1", y = "V20", 
                  color = "V1", fill = "V1", palette = "jco",
                  alpha = 0.5, ggtheme = theme_bw(), trim = T) + rotate()
yplot <- ggviolin(all, x = "V1", y = "V23",
                  color = "V1", fill = "V1", palette = "jco",
#                  ylim = c(-10, 10),
#                  add = "boxplot",
                  alpha = 0.5, ggtheme = theme_bw(), trim = T)

# Cleaning the plots
sp <- sp + rremove("legend")
yplot <- yplot + clean_theme() + rremove("legend")
xplot <- xplot + clean_theme() + rremove("legend")
# Arranging the plot using cowplot
plot_grid(xplot, NULL, sp, yplot, ncol = 2, align = "hv", 
          rel_widths = c(2, 1), rel_heights = c(1, 2))

# estimate median and SD
chr1 = subset(all, V1 == "Scaffold_20849;HRSCAF=22316") # chr 1
chr2 = subset(all, V1 == "Scaffold_21967;HRSCAF=25451") # chr 2
chr3 = subset(all, V1 == "Scaffold_21646;HRSCAF=24477") # chr 3
chrx = subset(all, V1 == "Scaffold_21773;HRSCAF=24826") # chr X

others = subset(all, V1 != "Scaffold_21773;HRSCAF=24826" & 
                  V1 != "Scaffold_21646;HRSCAF=24477"&
                  V1 != "Scaffold_21967;HRSCAF=25451"&
                  V1 != "Scaffold_20849;HRSCAF=22316") # other scaffolds

others$V1 <- "others"

chr_123 = rbind(chr1, chr2, chr3)
chr_123$V1 <- "autosomes"
chrx$V1 <- "chrX"

chr_all = rbind(chr_123, chrx, others)
ggplot(chr_all, aes(chr_all$V20)) + geom_histogram(binwidth=0.01) + 
  xlim(0,2)
ggplot(chrx, aes(chrx$V20)) + geom_histogram(binwidth=0.01) + xlim(0,2)


ggplot(chr_all, aes(V20, color = V1, fill = V1)) + 
  #  xlim(0,1500)+
  scale_x_continuous(name="Male Depth / Female Depth",lim = c(0, 1.5), breaks = seq(0, 1.5, by = 0.1)) +
  scale_y_continuous(name="Number of Windows")+
  #  geom_histogram(binwidth=1) + 
  geom_histogram(alpha=0.55, binwidth=0.011, alpha = 0.5, position = 'identity') + 
  #  geom_histogram(alpha=0.55, binwidth=10) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))


ggplot(chr_all, aes(chr_all$V20)) + geom_histogram(binwidth=0.01) + xlim(0,2)
ggplot(chrx, aes(chrx$V20)) + geom_histogram(binwidth=0.01) + xlim(0,2)
ggplot(others, aes(V20)) + geom_histogram(binwidth=0.01) + xlim(0,2)

# plot depth only
ggviolin(others, x = "V1", y = "V20", xlim=c(0,1),
         color = "V1", fill = "V1", palette = "jco",
         alpha = 0.5, ggtheme = theme_bw(), trim = T) + rotate()

ggplot(others, aes(x=others$V1, y=others$V20)) + geom_violin() + 
  scale_y_continuous(limits=c(0, 3)) + coord_flip()

median(chr_123$V20)
sd(chr_123$V20)

###
# customer color with 50 colors
###
# https://quantdev.ssri.psu.edu/sites/qdev/files/Tutorial_ColorR_2.html
library(rstudioapi)
library(fBasics)
library(grDevices)

current_path <- getSourceEditorContext()$path
setwd(dirname(current_path))
pal <- topo.colors(n = 50)
par(mar = rep(0, 4))
pie(rep(1, length(pal)), col = pal)

r_orig <- col2rgb(pal)[1,]
r_orig
g_orig <- col2rgb(pal)[2]
g_orig
b_orig <- col2rgb(pal)[3,]
b_orig
r <- c(76, 0, 0, 0, 0, 255, 255, 255, 255, 230, 209, 
       189, 168, 148, 128, 107, 87, 66, 46, 26)

g <- c(0, 67, 158, 211, 229, 237, 243, 249, 255, 255, 
       255, 255, 255, 255, 255, 255, 255, 255, 255, 255)

b <- c(255, 255, 255, 255, 255, 36, 24, 12, 0, 0, 0, 0, 
       0, 0, 0, 0, 0, 0, 0, 0)

beach <- function (n, name = c("beach.colors")) 
{
  beach.colors = rgb(r,g,b,maxColorValue = 255)
  name = match.arg(name)
  orig = eval(parse(text = name))
  rgb = t(col2rgb(orig))
  temp = matrix(NA, ncol = 3, nrow = n)
  x = seq(0, 1, , length(orig))
  xg = seq(0, 1, , n)
  for (k in 1:3) {
    hold = spline(x, rgb[, k], n = n)$y
    hold[hold < 0] = 0
    hold[hold > 255] = 255
    temp[, k] = round(hold)
  }
  palette = rgb(temp[, 1], temp[, 2], temp[, 3], maxColorValue = 255)
  palette
}

pal2 <- beach(n=50)
par(mar = rep(0, 4))
pie(rep(1, length(pal2)), col = pal2)

all <- read.table("depthHeteroSNPcombined.table.sorted.filtered.100k", header = F)
#all$V1 <- reorder(all$V1,all$V1,FUN=length)
#levels(all$V1)

tb <- table(all$V1) 
all$V1 <- factor(all$V1, 
                   levels = names(tb[order(tb, decreasing = TRUE)])) 

sp <- ggscatter(all, x = "V20", y = "V22",
                color = "V1", palette = "pal2",
                size = 3, alpha = 0.6, ggtheme = theme_bw(), xlab = "Male/Female Seq. Depth Ratio", ylab = "Max Number of SNPs in males") 
# Marginal boxplot of x (top panel) and y (right panel)
xplot <- ggviolin(all, x = "V1", y = "V20", 
                   color = "V1", fill = "V1", palette = "pal2",
                   alpha = 0.5, ggtheme = theme_bw(), trim = T)+
  rotate()
yplot <- ggviolin(all, x = "V1", y = "V22",
                   color = "V1", fill = "V1", palette = "pal2",
                   alpha = 0.5, ggtheme = theme_bw(), trim = T)
# Cleaning the plots
sp <- sp + rremove("legend")
yplot <- yplot + clean_theme() + rremove("legend")
xplot <- xplot + clean_theme() + rremove("legend")
# Arranging the plot using cowplot
plot_grid(xplot, NULL, sp, yplot, ncol = 2, align = "hv", 
          rel_widths = c(2, 1), rel_heights = c(1, 2))




