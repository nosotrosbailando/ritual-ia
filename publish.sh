#!/data/data/com.termux/files/usr/bin/bash  
# Uso: ./publish.sh [TXT_INPUT] [CLAVE]  

INPUT="$1"  
CLAVE="$2"  
FECHA_HEX=$(date +"%s" | xxd -p)  
HASH_CLAVE=$(echo -n "$CLAVE" | sha1sum | cut -d ' ' -f1)  
OUTPUT="FRAGMENTO_0x${FECHA_HEX}_${HASH_CLAVE::7}.enc"  

# Cifrar  
openssl enc -aes-256-cbc -salt -in "$INPUT" -out "$OUTPUT" -pass pass:"$CLAVE"  

# Subir a GitHub  
git add "$OUTPUT"  
git commit -m "$OUTPUT"  
git push origin main  

# Destruir huellas  
shred -u "$INPUT" "$OUTPUT"  
