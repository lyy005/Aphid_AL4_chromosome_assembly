source("https://bioconductor.org/biocLite.R")
biocLite("ggbio")

biocLite("Sushi")
browseVignettes("Sushi")
library(ggbio)
library(Sushi)

# LdcA genes
#ldca = read.table("LdcA_all.fasta.blast.curated.bed", header = T)
ldca = read.table("LdcA1.fasta.blast.curated.bed", header = T)
chrom = "Scaffold_20849"
chromstart = 12813648
chromend = 12818604

plot1 <- plotGenes(ldca, chrom, chromstart, chromend, types="exon", 
                   #                   colorby=log10(caro1$score+0.001),
                   colorbycol= SushiColors(5),colorbyrange=c(0,1.0),
                   labeltext=F,fontsize=1,
                   maxrows=50,height=0.2,plotgenetype="arrow")
labelgenome(chrom, chromstart,chromend,n=3,scale="Mb", chromfont=0.5)

# BCR
bcr = read.table("BCR_ShigenobuStern2013.fasta.blast.curated.bed", header = T)
chrom = "Scaffold_20849"
chromstart = 96381175
chromend = 96468883

plot1 <- plotGenes(bcr, chrom, chromstart, chromend, types="exon", 
                   #                   colorby=log10(caro1$score+0.001),
                   colorbycol= SushiColors(5),colorbyrange=c(0,1.0),
                   labeltext=F,fontsize=1,
                   maxrows=50,height=0.2,plotgenetype="arrow")
labelgenome(chrom, chromstart,chromend,n=3,scale="Mb", chromfont=0.5)

# RlpA
rlpa = read.table("RlpA.fasta.blast.curated.bed", header = T)
chrom = "Scaffold_20849"
chromstart = 127903327
chromend = 127961517

plot1 <- plotGenes(rlpa, chrom, chromstart, chromend, types="exon", 
                   #                   colorby=log10(caro1$score+0.001),
                   colorbycol= SushiColors(5),colorbyrange=c(0,1.0),
                   labeltext=F,fontsize=1,
                   maxrows=50,height=0.2,plotgenetype="arrow")
labelgenome(chrom, chromstart,chromend,n=3,scale="Mb", chromfont=0.5)


# other genes
# BCR
bcr = read.table("BCR_ShigenobuStern2013.fasta.blast.curated.bed", header = T)
chrom = "Scaffold_20849"
chromstart = 96381175
chromend = 96468883

plot1 <- plotGenes(bcr, chrom, chromstart, chromend, types="exon", 
                   #                   colorby=log10(caro1$score+0.001),
                   colorbycol= SushiColors(5),colorbyrange=c(0,1.0),
                   labeltext=F,fontsize=1,
                   maxrows=50,height=0.2,plotgenetype="arrow")
labelgenome(chrom, chromstart,chromend,n=3,scale="Mb", chromfont=0.5)

other = read.table("BCR_ShigenobuStern2013.fasta.blast.curated.bed", header = T)
chrom = "Scaffold_20849"
chromstart = 1006436
chromend = 127944028

plot1 <- plotGenes(other, chrom, chromstart, chromend, types="exon", 
                   #                   colorby=log10(caro1$score+0.001),
                   colorbycol= SushiColors(5),colorbyrange=c(0,1.0),
                   labeltext=F,fontsize=0.2,
                   maxrows=50,height=0.2,plotgenetype="arrow")
labelgenome(chrom, chromstart,chromend,n=3,scale="Mb", chromfont=0.5)

# carotenoid genes

caro = read.table("caro.blast.bed.rename1", header = T)
caro = read.table("caro.blast.bed.rename2", header = T)
caro = read.table("caro.blast.bed.rename3", header = T)
caro = read.table("caro.blast.bed.rename4", header = T)
caro = read.table("caro.blast.bed.rename5", header = T)
caro = read.table("caro.blast.bed.rename6", header = T)
caro = read.table("caro.blast.bed.rename7", header = T)
caro = read.table("caro.blast.bed.rename8", header = T)


#chrom = "Scaffold_20849;HRSCAF=22316"
chrom = "Scaffold_20849"
chromstart = 110005055
chromend = 110209032

plot1 <- plotGenes(caro, chrom, chromstart, chromend, types="exon", 
#                   colorby=log10(caro1$score+0.001),
                   colorbycol= SushiColors(5),colorbyrange=c(0,1.0),
                   labeltext=TRUE,fontsize=1,
                   maxrows=50,height=0.2,plotgenetype="arrow")
labelgenome(chrom, chromstart,chromend,n=3,scale="Mb", chromfont=0.5)


chrom = "chr15"
chromstart = 72965000
chromend = 72990000
pg = plotGenes(Sushi_transcripts.bed,chrom,chromstart,chromend ,
                 types = Sushi_transcripts.bed$type,
                 colorby=log10(Sushi_transcripts.bed$score+0.001),
                 colorbycol= SushiColors(5),colorbyrange=c(0,1.0),
                 labeltext=TRUE,maxrows=50,height=0.4,plotgenetype="box")
labelgenome( chrom, chromstart,chromend,n=3,scale="Mb")
addlegend(pg[[1]],palette=pg[[2]],title="log10(FPKM)",side="right",
            bottominset=0.4,topinset=0,xoffset=-.035,labelside="left",
            width=0.025,title.offset=0.055)


library(Sushi)
Sushi_data = data(package = 'Sushi')
data(list = Sushi_data$results[,3])
head(Sushi_ChIPSeq_pol2.bed)
chrom = "chr11"
chromstart = 2281200
chromend = 2282200

plotBed(beddata = Sushi_ChIPSeq_pol2.bed,chrom = chrom,chromstart = chromstart,
        chromend =chromend,colorby = Sushi_ChIPSeq_pol2.bed$strand,
        colorbycol = SushiColors(2),row = "auto",wiggle=0.001)

