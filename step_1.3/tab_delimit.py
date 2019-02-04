#!usr/bin/env python3

def main():
	infile = open("freebayes_qual20-AB-MQM-DP-prim-removehighdepth-SNP.vcf", "r")
	outstring = ""
	for line in infile: 
		line = line.split()
		line = "\t".join([str(x) for x in line])
		line += "\n"
		outstring += line
	infile.close()
	outfile = open("./freebayes_qual20-AB-MQM-DP-prim-removehighdepth-SNP-tab.vcf", "w")
	outfile.write(outstring)
	outfile.close()

if __name__ == "__main__":
	main()
