run_analysis <- function() {
  ########################
  #### Common Section ###
  ########################
  ### Read Files ###
  col_heads <- read.table("features.txt",sep = " ")
  act_labels <- read.table("activity_labels.txt",sep = " ")
  
  ### Determine index of mean and std columns, excluding meanFreq ###
  meanlocs <- grep("-mean()",col_heads[,2])
  stdlocs <- grep("-std()",col_heads[,2])
  freqlocs <- grep("-meanFreq()",col_heads[,2])
  bothlocs <- union(meanlocs,stdlocs)
  bothlocs <- setdiff(bothlocs,freqlocs)
  #######################
  ## Test File section ##
  #######################
  
  ### Read Files ###
  data_file <- read.table("test\\x_test.txt")
  y_file <- read.table("test\\y_test.txt")
  sbj_file <- read.table("test\\subject_test.txt")
  
  ###Establish column names on all files ###
  colnames(data_file) <- col_heads[,2]
  colnames(y_file) <- c("Activity_Number")
  colnames(act_labels) <- c("Activity_Number","Activity_Name")
  colnames(sbj_file) <- c("Subject")
  
  ###Trim file to the just the columns we care about (mean,std) ###
  data_file_trim <- data_file[,bothlocs]
  
  ###Column bind file with activities and subjects ###
  data_file_cat <- cbind(y_file,sbj_file,data_file_trim)
  
  #Merge in descriptive activity labels ###
  data_file_merged_test <- merge(act_labels,data_file_cat,by.x = "Activity_Number",by.y= "Activity_Number")
  head(data_file_merged_test)
  
  ###########################
  ## Training File Section ##
  ###########################
  data_file <- read.table("train\\x_train.txt")
  y_file <- read.table("train\\y_train.txt")
  sbj_file <- read.table("train\\subject_train.txt")
  
  ### Establish column names on all files ###
  colnames(data_file) <- as.character(col_heads[,2])
  colnames(y_file) <- c("Activity_Number")
  colnames(sbj_file) <- c("Subject")
  
  ### Trim file to the just the files we care about ###
  data_file_trim <- data_file[,bothlocs]
  ### Column bind file with activities and subjects ###
  data_file_cat <- cbind(y_file,sbj_file,data_file_trim)
  
  ### Merge ###
  data_file_merged_train <- merge(act_labels,data_file_cat,by.x = "Activity_Number",by.y= "Activity_Number")
  
  ###Combine Test and Train ###
  data_file_merged <- rbind(data_file_merged_test,data_file_merged_train)
  
  ############################
  ### Summarize and Output ###
  ############################
  
  data_file_meaned <- aggregate(x=data_file_merged[4:69],
                                    by = list(data_file_merged$Activity_Number,
                                              data_file_merged$Activity_Name,
                                              data_file_merged$Subject),
                                    FUN = "mean")
  colnames(data_file_meaned)[1:3] <- c("Activity_Number","Activity_Name","Subject")
  write.table(data_file_meaned, file = "WearableComputing.txt",row.name=FALSE)
}