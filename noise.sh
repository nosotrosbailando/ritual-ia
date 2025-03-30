#!/data/data/com.termux/files/usr/bin/bash  
# Genera 1MB de ruido y lo mezcla en el repo  
dd if=/dev/urandom of=noise_$(date +"%s").bin bs=1M count=1  
git add *.bin  
git commit -m "NOISE_$(date +"%s")"  
git push  

