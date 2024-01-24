# script capable of generating random password
#!/bin/bash

# Default values
LENGTH=12
USE_UPPER=false
USE_DIGITS=false
USE_SPECIAL=false

# Process command-line arguments
while getopts ":l:udsh" opt; do
  case $opt in
    l) LENGTH="$OPTARG" ;;
    u) USE_UPPER=true ;;
    d) USE_DIGITS=true ;;
    s) USE_SPECIAL=true ;;
    h) echo "Usage: $0 [-l LENGTH] [-u] [-d] [-s]"; exit 1 ;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
  esac
done

# Characters based on complexity options
chars="abcdefghijklmnopqrstuvwxyz"
[ "$USE_UPPER" = true ] && chars+="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
[ "$USE_DIGITS" = true ] && chars+="0123456789"
[ "$USE_SPECIAL" = true ] && chars+="!@#$%^&*()-=_+[]{}|;:'\",.<>/?"

# Generate and display the password
generated_password=$(tr -dc "$chars" < /dev/urandom | head -c "$LENGTH")
echo "Generated Password: $generated_password"
