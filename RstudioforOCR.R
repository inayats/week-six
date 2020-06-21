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
