#Create a Bash script that allows users to extract and display metadata and analyzing various file types within a specified directory
#!/bin/bash

# Function to display script usage
function display_usage {
    echo "Usage: $0 DIRECTORY_PATH"
    echo "Enter the BATH behind the bash command "
    exit 1
}

# Check if the directory path is provided
if [ "$#" -ne 1 ]; then
    display_usage
fi

directory_path="$1"

# Check if the directory exists
if [ ! -d "$directory_path" ]; then
    echo "Error: Directory not found."
    display_usage
fi

# Function to display metadata for image files using exiftool
function display_image_metadata {
    echo "Image Metadata:"
    exiftool "$1"
    echo "------------------"
}

# Function to display metadata for media files using mediainfo
function display_media_metadata {
    echo "Media Metadata:"
    mediainfo "$1"
    echo "------------------"
}

# Function to display basic file information using file command
function display_file_info {
    echo "File Information:"
    file "$1"
    echo "------------------"
}

# Process each file in the specified directory
for file_path in "$directory_path"/*; do
    if [ -f "$file_path" ]; then
        echo "Analyzing file: $file_path"

        # Check the file type and display metadata accordingly
        case "$(file -b --mime-type "$file_path")" in
            image/*)
                display_image_metadata "$file_path"
                ;;
            video/* | audio/*)
                display_media_metadata "$file_path"
                ;;
            *)
                display_file_info "$file_path"
                ;;
        esac
    fi
done
