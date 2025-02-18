library(tidyverse)
library(data.table)
options(scipen=999)
gtf_head <-read.csv("GCF_002263795.1_ARS-UCD1.2_genomic.gtf", sep="\t", nrows=4, header=F)
gtf <- fread("GCF_002263795.1_ARS-UCD1.2_genomic.gtf", sep="\t", skip=4, header=F, fill = TRUE)
gtf <- gtf %>% filter(!str_detect(V9,'gene_id ""'))
gtf <- gtf %>% separate(V9, c("V10","V11","V12","V13","V14","V15","V16","V17","V18","V19",
                              "V20","V21","V22","V23","V24","V25","V26","V27","V28","V29",
                              "V30","V31","V32","V33","V34","V35","V36","V37","V38","V39"), sep=";")
gtf <- gtf %>% mutate(V11b = case_when(!str_detect(V11, "transcript") ~ paste0(' transcript_id "unknown_transcript_',seq_len(nrow(gtf)),'";', V11),
                                        str_detect(V11, "transcript") ~ V11))
gtf <- gtf %>% select(-V11) %>% relocate(V11b, .before=V12) 
gtf <- gtf %>% unite(V9, V10:V39, sep=";")
gtf$V9  <- gsub(";NA","",gtf$V9)

final <- bind_rows(gtf_head,gtf)
final[is.na(final)] <- ""
write.table(final, "GCF_002263795.1_ARS-UCD1.2_genomic.mod.gtf", quote=F, sep="\t", row.names = F, col.names = F)
