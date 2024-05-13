#!/bin/bash

thumbs_folder=./images/thumbnails
mkdir -p "$thumbs_folder"

for file in ./images/fulls/*; do
    # next line checks the mime-type of the file
    image_type=$(file --mime-type -b "$file")
    echo $file "image type" $image_type 
    if [[ $image_type = image/* ]]; then
        image_size=$(identify -format "%[fx:w]x%[fx:h]" "$file")
        echo $image_size
        IFS=x read -r width height <<< "$image_size"
        # If the image width is greater that 200 or the height is greater that 150 a thumb is created
        if (( width > 200 || height > 150 )); then
            #This line convert the image in a 200 x 150 thumb 
            filename=$(basename "$file")
            extension="${filename##*.}"
            filename="${filename%.*}"
            #convert -sample 200x150 "$file" "${thumbs_folder}/${filename}.${extension}"
            convert -resize 1024x "$file" "${thumbs_folder}/${filename}.${extension}"
        fi
    fi
done
