# What I am studying:

The South Asian American Digital Archive has a number of publications in its online collections. I decided to look at issues of Young India magazine, publshed by the Indian Home Rule League in the U.S. I looked at six issues of the magazine from 1918, at the end of WWI.

# Extracting the files

The SAADA has scans/images of the magazines by page online. I looked at the URLs of the files and made a list of URLs by using Excel formulas, that I saved in my directory as youngindiaurls.txt

This is a sample URL: http://s3.amazonaws.com/saada-online/objects/2012-00/item-yi-1918-03-001.jpg

The numbers at the end is year-month-page number. So I just had to change that to get an accurate list of URLs

WGET command: `wget -i youngindiaurls.txt -r --no-parent -nd -w 2 --limit-rate=100k`

# I then used the R script from Week 2 to run an OCR on all the images. Here was the code:

```

install.packages('magick')
install.packages('tesseract')

library(magick)
library(magrittr)
library(tesseract)

imgsource <- "many-pics"
myfiles <- list.files(path = imgsource, pattern = "jpg", full.names = TRUE)

lapply(myfiles, function(i){
  text <- image_read(i) %>%
    image_resize("3000x") %>%
    image_convert(type = 'Grayscale') %>%
    image_trim(fuzz = 40) %>%
    image_write(format = 'png', density = '300x300') %>%
    tesseract::ocr()
  
  outfile <- paste(i,"-ocr.txt",sep="")
  cat(text, file=outfile, sep="\n")
})

```

# Analyzing with the Topic Model tool

* I used the Topic Modelling tool to analyze the text. I ran all the .txt OCR files through the tool, saving them in a separate folder.

* Tried different combinations of topics - 4,5,10,15. For these many pages, the lower number of topics worked better. I used 4 to isolate the main topics.

* Close reading of the text through opening the all_topics.html file.

# Poster design

* I used a simple poster template from Colin Purrington, available [here](https://colinpurrington.com/tips/poster-design/#templates)

* The poster was edited in Powerpoint. Can be exported as PDF - File > Export




