if (getRversion() >= "2.15.1") {
    utils::globalVariables(c("maxRow", "maxCol", "useIdx", "vldExt", "fmtVrI", "fmtAdC", "fmtAdR", "fmtFsC", "hlpCrt", "hlpArC", "hlpL2W", "hlpMrg",
                             "hlpRpl", "hlpSrc", "hlpSrt", "hlpW2L", "hlpXfV", "hlpXps", "genSep", "genNSS", "genNSA", "dtlSep", "dtlNSS", "dtlNSA"))
}

# variable definitions
maxRow <- 10
maxCol <- 10
useIdx <- FALSE
vldExt <- c("omv", "csv", "tsv", "rdata", "rda", "rds", "sav", "zsav", "dta", "sas7bdat", "sd2", "sd7", "xpt", "stx", "stc")

# message formatting for sprintf
fmtVrI <- "<strong>Variables in the Output Data Set</strong> (%d variables in %d rows): %s"
fmtAdC <- "There are %d more colums in the data set not shown here. A complete list of variables can be found in \"Variables in the Output Data Set\" above this table."
fmtAdR <- "There are %d more rows in the data set not shown here."
fmtFsC <- "The column%s %s %s shown first in this preview. In the created data set, the variable order is as shown in \"Variables in the Output Data Set\" above this table."

# help messages
hlpCrt <-   paste("Pressing the <strong>\"Create\"-button opens the modified data set</strong> in a new jamovi window.")

hlpArC <-   paste("Please assign the variables in their desired order to \"Desired Order of Variables\". By ticking \"Add Remaining Variables at the",
                  "End\", variables that are not contained in \"Desired order of variables\") are appended.")
hlpL2W <- c(paste("Please assign the variables that identify participant (or another measurement unit; e.g., a number or an ID) to \"Variables that",
                  "identify the same unit\", and those that are unique to an unit but not an identifier (e.g., gender, age group) to \"Variables NOT",
                  "to be Transformed\". \"Variables That Differentiate Within a Unit\" typically contain different (e.g., experimental) conditions,",
                  "and \"Variables To Be Transformed\" are the actual measurements (e.g., responses, reaction times, etc.)."),
                  "For an example about a typical long-to-wide-transformation, see the last paragraph in \"Details\" underneath the output tables.")
hlpMrg <- c(paste("Please assign one or more variables that appear in all data sets (e.g., a participant code) to \"Variable(s) to Match the",
                  "Data Sets by\". Afterwards, either write the name of (one or more) file(s) to be merged under \"Data Set(s) to Add\" (separate",
                  "mulitiple file names with semicolons), or use \"Browse...\" to select input file(s)."),
                  "For a more comprehensive explanation regarding the types of merging operations, see \"Details\" underneath the preview table.")
hlpRpl <- c(paste("Please type the original value and the replacement into the entry fields. If you want to have several pairs of original and",
                  "replacment values, use separate lines. To replace partial matches, unset the tick box \"Whole Word\" (e.g., for orginal: 24 and",
                  "replacement: 34, 241 will be changed into 341)."),
            paste("The <strong>\"Include / Exclude\"</strong> collapse box permits to specifically select in which column types, for which measurement",
                  "type, and in which variables <strong>to replace values</strong>. Ticking the check boxes includes that variable or measurement type.",
                  "When selecting individual variables using the variable input, set the radio button to either only include the selected variables or",
                  "to exclude them."))
hlpSrc <- c(paste("Please type the term to be search for into the text box. If you want that partial matches (i.e., the search term appears within",
                  "values) are found, leave the tick box \"Whole Word\" unset."),
            paste("The <strong>\"Include / Exclude\"</strong> collapse box permits to specifically select in which column and measurement types the",
                  "<strong>search</strong> shall be conducted. Ticking the check boxes includes that variable or measurement type."))
hlpSrt <-   paste("Please assign one or more variables to the variable box \"Variable(s) to be Sorted After\". The order in which the",
                  "variables appear in the variable box determines after which variable is sorted first (one could, e.g., first sort",
                  "after gender and afterwards after age). Variables are sorted in \"Ascending\" order (as default), but you can change",
                  "the order if desired.")
hlpW2L <-   paste("When transforming a data set from wide to long format, you first need determine how the name of the variables that you would like",
                  "to transform is build up: It can either contain the different (e.g., experimental) conditions in the name and those conditions",
                  "are separated by a specific character (e.g., \"cond1_condA_conda\" with \"_\" being that character) or the names either don't contain",
                  "all conditions or no separating character. Depending on the structure of the variable names, choose one of the tabs (\"Non-sep.",
                  "(simple)\" permit only one condition / index variable, \"Non-sep. (advanced)\" several conditions and target variables. More detailed",
                  "instructions are given in the next paragraph and you can check using the two output tables (the first containing a data preview,",
                  "the second an overview over how the repeated measurement levels - i.e., the original variables - were converted).")
hlpXfV <- c(paste("Please assign at least one variable to at least one of the variable boxes indicating what (approximate) degree (moderate, strong, extreme",
                  "and kind (postive or negative) of skewness this variable has. For moderately skewed variables, a square-root-transformation is used, for",
                  "strongly skewed variables, a logarithic transformation, and for severly skewed variables an inversion. If necessary, a constant is added",
                  "(automatically) in order to avoid the transformation returning NA-values."),
                  "NB: The transformations work only for numeric variables (integer or decimal); please adjust the measure / data type if necessary.")
hlpXps <-   paste("Please assign up to one variable to the variable box \"Column Names for the Output\" (this variable might contain names of trials",
                  "or questionnaire items). If you leave the box empty, generic variable names are generated (\"V_...\"). The variables to become rows",
                  "in your output data set have to be assigned to \"Variables To Be Transposed\".")
genSep <- c(paste("Please assign the variables that identify participant (or another measurement unit; e.g., a number or an ID) to \"Variables that",
                  "Identify the Same Unit\", and those that are unique to an unit but not an identifier (e.g., gender, age group) to \"Variables NOT",
                  "To Be Transformed\". If no variable that identifies a participant is given, such variable will be created (and named \"ID\"). Then",
                  "assign all variables to be converted from wide to long (columns to rows) to \"Variables To Be Transformed\". The different conditions",
                  "in those variable names are separated by a character that has to be assigned to \"Separator\" (e.g., in cond1_condA_conda, the",
                  "separator is \"_\") and the prefix for the conditions can be given under \"Prefix\" (in the previous example, there would be three",
                  "different conditions, and hence the columns in the resulting data set would be [Prefix]1, [Prefix]2 and [Prefix]3, with [Prefix]",
                  "replaced by whatever was given as string in \"Prefix\"). Finally, if one level contains a variable name that should be kept, this",
                  "level can be excluded via \"Exclude Level\" (e.g., for var1_cond1_condA_conda, put \"1\" there, or use \"4\" for cond1_condA_conda_var1."),
                  "For an example about a typical wide-to-long-transformation, see the last paragraph in \"Details\" underneath the preview table.")
genNSS <-   paste("Please assign the variables (columns) of the original data set that you would like to convert from long (rows) to wide (columns)",
                  "and assign them to \"Variables To Be Transformed\". If there exists (one or more) variables that identify a participant (or another",
                  "measurement unit; e.g., a number or an ID) it can be assigned to \"Variables that Identify the same Unit\", otherwise such variable",
                  "will be created (and named \"ID\"). Variables that are not to be converted (e.g., personal characteristics such as gender, or age",
                  "group) should be assigned to \"Variables NOT To Be Transformed\". The text field \"Name of the Target Variable\" defines the name of",
                  "the variable (in long format) that is created; the text field \"Index for Repeated Measures Levels\" defines an index that contains",
                  "the number of the original columns / variables after the transformation. That is, for each of the variables assigned to \"Variables",
                  "To Be Transformed\" (originally columns) the index indicates which column the value in the target variable is coming from.")
genNSA <-   paste("Please create a new long variable for each of your target variables, and assign the respective selection of original variables",
                  "(columns) from the original data set that you want to convert into different long format variables under \"Variables To Be",
                  "Transformed\" : For each long format variable that you want to create, there is is a text field for the name of that variable and",
                  "a field where you can drag or assign the original variables that \"belong\" (are to be converted to) this variable. Please note that",
                  "all (original) variable lists assigned to the target variables need to contain the same number of variables. Afterwards, you need",
                  "to define one or more index variables for these variable lists under \"Index Variables (Can Be Nested)\". If you multiply the number",
                  "of levels (\"N levels\") the result needs to be equal to the length of the variable lists under \"Variables To Be transformed\". The",
                  "first index variable is successive (1, 2, 3, ...), higher index variables go to the next step once all levels on the lower index",
                  "variables went through a complete sequence (e.g., 1-1, 2-1, 3-1, 1-2, 2-2, 3-2, ...). You can use the second output table to check",
                  "whether the levels of the index variables were assigned correctly. If there exists (one or more) variables that identify a",
                  "participant (or another measurement unit; e.g., a number or an ID) it can be assigned to \"Variables that identify the same unit\",",
                  "otherwise such variable will be created (and named \"ID\"). Variables that are not to be converted (e.g., personal characteristics",
                  "such as gender, or age group) should be assigned to \"Variables NOT To Be Transformed\".")
dtlSep <- c(paste("\"Variables That Identify the Same Unit\" is an ID variable (e.g., a participant code). This code needs to be unique (i.e., there",
                  "can't be two participants, or other units, with the same ID)."),
            paste("\"Variables To Be Transformed\" are the so-called target variables, i.e., variables that exist as many columns in the input data set",
                  "and are going to be transformed, creating different steps of one or more time-varying variable resulting in the output.The number",
                  "of variables that are created is determined by how many parts the variable name has (the parts are split by the character defined",
                  "as \"Separator\") and how many steps / different values exist within each part. If we had a variable with 4 parts, each with two steps",
                  "per separated part, this would result in four columns (starting with the string defined as \"Prefix\" and ending with 1, 2, 3, and 4).",
                  "The number of rows would be increased by the number of all possible combinations of steps (in the example above 2 * 2 * 2 * 2 = 16,",
                  "mulitiplied by the number of rows in the input data set, e.g., 50 rows becoming 50 * 16 = 800 rows)."),
            paste("\"Variables NOT To Be Transformed\" are variables that \"characterize\" a participant (or another unit), often also called",
                  "between-subjects variables, e.g., age or sex. However, they are not unique (and thus no ID variables; there may be several",
                  "participants with the same age or sex)."),
            paste("\"Separator\" defines which character(s) should be placed between the target variable and the steps of the time-varying variable /",
                  "conditions when assembling the variable names (e.g., VAR_COND)."),
            paste("Often, an input data set contains different types of measures (e.g., whether a response was correct and the reaction time) that",
                  "make up a part of the variable name. Typically, one wants to keep those different measures as separate columns in the output data",
                  "set. \"Exclude Level\" permits to exclude one (or more) part (and the steps in it) from being transformed from wide to long. If the",
                  "kinds of measurement were the first part of the variable name, 1 would have to be put into this field. If all levels are to be",
                  "transformed, the field needs to be blank."),
                  " ",
            paste("The principle of the transformation from long to wide can perhaps easiest be understood by looking at example4jtWide2Long from",
                  "the Data Library of this module. It contains results from a Stroop experiment (in wide format) with fifty variables: ID (identifies",
                  "the participant), sex (of the participant), and afterwards 48 variables that represent a combination of the measurement (first part",
                  "of the variable name, rspCrr - whether the response was correct - or rspTme - reaction time), the experimental condition / congruency",
                  "(second part; either cong[ruent], incong[ruent] or neutral), the colour the word was written with (third part; BLUE, GREEN, RED or",
                  "YELLOW) and which repetition of a particular combination of experimental conditions the variable represents (fourth part, 1 or 2).",
                  "These variables have to be assigned to the following fields: ID to \"Variables That Identify the Same Unit\" (it is an unique identifier",
                  "of each participant); sex to \"Variables NOT To Be Transformed\" (sex is a between-subjects variable that doesn't change between",
                  "experimental conditions; however, it is not unique and thus not suited as ID variable); and the remaining variables (i.e., all",
                  "variables starting with rspCrr_... or rspTme... to \"Variables To Be Transformed\". Under \"Prefix\" it can be determined how the name for",
                  "the different conditions shall start (a number would be added if there is more than one condition)."))
dtlNSS <- c(paste("\"Variables That Identify the Same Unit\" is an ID variable (e.g., a participant code). This code needs to be unique (i.e., there",
                  "can't be two participants, or other units, with the same ID)."),
            paste("\"Variables To Be Transformed\" are the so-called target variables, i.e., variables that exist as many columns in the input data set",
                  "and are going to be transformed, creating different steps of one or more time-varying variable resulting in the output."),
            paste("\"Variables NOT To Be Transformed\" are variables that \"characterize\" a participant (or another unit), often also called",
                  "between-subjects variables, e.g., age or sex. However, they are not unique (and thus no ID variables; there may be several",
                  "participants with the same age or sex)."),
            paste("\"Index for Repeated Measures Levels\" permits to define the name of the index variable (the index might be the different items in a",
                  "questionnaire or the different experimental conditions in the data set), and \"Name of the Target Variable\" permits to set the name",
                  "to the target variable (which is to be created from the list of \"Variables To Be Transformed\")."))
dtlNSA <- c(paste("\"Variables That Identify the Same Unit\" is an ID variable (e.g., a participant code). This code needs to be unique (i.e., there",
                  "can't be two participants, or other units, with the same ID)."),
            paste("\"Variables To Be Transformed\" are the so-called target variables, i.e., variables that exist as many columns in the input data set",
                  "and are going to be transformed, creating different steps of one or more time-varying variable resulting in the output. This input is",
                  "organized as a combination of the name of the target variable (top line) and the original variables that are to be transformed into",
                  "this target variable (as a variable list underneath the top line). If there are several target variables, those can be added using the",
                  "\"Add New Long Variable\" button. Have a look at the explanation of an example data set, and how to assign variables to it in the example",
                  "in the last paragraph of the \"Details\" section."),
            paste("\"Variables NOT To Be Transformed\" are variables that \"characterize\" a participant (or another unit), often also called",
                  "between-subjects variables, e.g., age or sex. However, they are not unique (and thus no ID variables; there may be several",
                  "participants with the same age or sex)."),
            paste("\"Index Variables\" are used to index how each step in the different conditions / target variables matches up with an original (to be",
                  "transformed) variable. If there are several conditions, those can be nested. The lowest index variable goes one step up from one original",
                  "variable to the next. Have a look at the explanation of an example data set, and how to create index variables in the next paragraph."),
                  " ",
            paste("The principle of the transformation from long to wide can perhaps easiest be understood by looking at example4jtWide2Long from",
                  "the Data Library of this module. It contains results from a Stroop experiment (in wide format) with fifty variables: ID (identifies",
                  "the participant), sex (of the participant), and afterwards 48 variables that represent a combination of the measurement (first part",
                  "of the variable name, rspCrr - whether the response was correct - or rspTme - reaction time), the experimental condition / congruency",
                  "(second part; either cong[ruent], incong[ruent] or neutral), the colour the word was written with (third part; BLUE, GREEN, RED or",
                  "YELLOW) and which repetition of a particular combination of experimental conditions the variable represents (fourth part, 1 or 2).",
                  "These variables have to be assigned to the following fields: ID to \"Variables That Identify the Same Unit\" (it is an unique identifier",
                  "of each participant); sex to \"Variables NOT To Be Transformed\" (sex is a between-subjects variable that doesn't change between",
                  "experimental conditions; however, it is not unique and thus not suited as ID variable); and the remaining variables (i.e., all",
                  "variables starting with rspCrr_... or rspTme... to \"Variables To Be Transformed\". When assigning them, you first need to \"Create a new",
                  "long variable\" and to name the first one (default \"long_y\") \"rspCrr\", and the second one \"rspTme\". Afterwards, you assign all variables",
                  "starting with \"rspCrr_\" to the variable list of the first variable, and all variables starting with \"rspTme_\" to the variable list of the",
                  "second variable. Afterwards, you need to define the index variables. Check in which order your variables are arranged: The index variable",
                  "that changes from one variable name to the next comes first, and for each of the higher index variables all steps of lower index variables",
                  "have to have been through a complete round, before going up a step on this variable. In the example data set, rspCrr_cong_GREEN_1 is",
                  "followed by rspCrr_incong_GREEN_1 and rspCrr_neutral_GREEN_1 (don't focus on the rspTme_... variables in between). Therefore, cond is the",
                  "first index variable with three steps (cong, incong, neutral), and you should change \"index1\" to \"cond\" and \"0\" to \"3\". The next level is",
                  "the colour (rspCrr_neutral_GREEN_1 is followed by rspCrr_cong_YELLOW_1), and you should set the name of the index variable to \"colour\" and",
                  "\"N levels\" to \"4\" (as there are four colours: GREEN, YELLOW, RED, and BLUE). The highest level is repetition (rspCrr_neutral_BLUE_1 is",
                  "followed by rspCrr_cong_GREEN_2), and you should thus set the name of the index variable to \"rep\" and the \"N levels\" to two (1 and 2).",
                  "Once you did all this, and the number of variables in the variable lists for the long variables under \"Variables To Be Transformed\" - 24 -",
                  "matches up with the product of \"N levels\" - 3 (cond) * 4 (colour) * 2 = 24 - a \"Data Preview\" and an overview over the \"Repeated-Measures",
                  "Levels\" is shown, and you can open the transformed data set (after checking those tables) in a new jamovi window by pressing the",
                  "\"Create\"-button."))
