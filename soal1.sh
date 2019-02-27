#!/bin/bash
a=0
cd ~/Downloads
unzip nature.zip
cd nature
for i in *.jpg
do
	base64 -d $i | xxd -r > gambar"$a".jpg
	let a++
	rm $i
done
