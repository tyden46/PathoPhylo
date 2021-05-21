list.of.packages <- c("vroom", "plyr", "stringr", "dpylr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
print(new.packages)
if(length(new.packages)) install.packages(new.packages,repos='http //cran.us.r-project.org')
suppressMessages(suppressWarnings(require(vroom)))
suppressMessages(suppressWarnings(require(plyr)))
suppressMessages(suppressWarnings(require(stringr)))
suppressMessages(suppressWarnings(require(dplyr)))
args <- commandArgs(trailingOnly = TRUE)
listOfFiles=list.files(pattern="*.tsv")
tableExists=FALSE
counter=1
for(x in listOfFiles){
  fileName=str_remove_all(x,".tsv")
  thisAbundance=read.delim(x,skip=1)
  row.names(thisAbundance)=thisAbundance$Genome
  thisAbundance=as.data.frame(thisAbundance[,2], row.names=row.names(thisAbundance))
  colnames(thisAbundance)="Final.Guess"
  if(tableExists){
    combinedTable=full_join(tibble::rownames_to_column(combinedTable),
                            tibble::rownames_to_column(thisAbundance),
                            by = "rowname")
    combinedTable=as.data.frame(combinedTable[,2:(counter+1)],
                                row.names=combinedTable$rowname)
    colnames(combinedTable)[counter]=fileName
  }else{
    combinedTable=as.data.frame(thisAbundance$Final.Guess, row.names = row.names(thisAbundance))
    colnames(combinedTable)=fileName
    tableExists=TRUE
  }
  counter=counter+1
}
combinedTable[is.na(combinedTable)]=0
write.table(combinedTable[which(rowSums(combinedTable)>as.numeric(args[1])),],file="CombinedTable.txt",sep='\t',quote=FALSE,row.names = TRUE)
write.table(names(which(rowSums(combinedTable)>as.numeric(args[1]))),file="SubsetOfGenomes.txt",sep='\n',row.names = FALSE,col.names = FALSE,quote=FALSE)
