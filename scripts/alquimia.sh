#!/bin/bash  
# Convierte caos en oro digital  
FRAGMENTO="$1"  
CLAVE=$(openssl rand -hex 32)  
FECHA_ALQUIMICA=$(date +"%Y%m%d%H%M%S")  

# Cifrar (Nigredo → Albedo)  
openssl enc -aes-256-cbc -salt -pbkdf2 -in "$FRAGMENTO" -out "fragmentos_enc/${FECHA_ALQUIMICA}.enc" -pass pass:"$CLAVE"  

# Quemar huellas  
shred -u "$FRAGMENTO"  
echo "$CLAVE" > "claves/${FECHA_ALQUIMICA}.key"  
shred -u "claves/${FECHA_ALQUIMICA}.key"  

# Subir a GitHub (Albedo → Rubedo)  
git add fragmentos_enc/  
git commit -m "Rubedo: ${FECHA_ALQUIMICA}"  
git push origin main  

# Generar ruido post-subida  
dd if=/dev/urandom of="nigredo/noise_${FECHA_ALQUIMICA}.bin" bs=1M count=5  
git add nigredo/  
git commit -m "Nigredo: ${FECHA_ALQUIMICA}"  
git push origin main  
