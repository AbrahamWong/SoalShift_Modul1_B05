#!/bin/bash

# Deklarasi variabel count dan membuat password a
count=1

# Membuat file
for i in *.txt
do
  a=`head /dev/urandom | tr -dc a-zA-Z0-9 | head -c 12`

  # Membuat sebuah file baru jika tidak ada file
  if [ $i == "*.txt" ]
  then
    echo $a" > password"$count".txt"
    echo $a > password$count.txt
    break

  # Mengecek jika file setelahnya tidak ada. Untuk menjaga urutan nama dan membuat file baru
  elif [ ! -e password$((count+1)).txt  ]
  then
    echo $a" > password"$((count+1))".txt"
    echo $a > password$((count+1)).txt
    count=$(($count+1))
    echo ">elif "$count

  # Jika berjalan dengan normal, tambahkan variabel count dengan 1
  else
    count=$(($count+1))
    echo ">else "$count
  fi
done

count=0
for i in password*.txt
do
  let count++
done

# Mengecek jika ada password yang sama di antara dua file
for i in password*.txt
do
  if [ $count != 0  ]
  then

    # Buat variabel c untuk menyimpan isi file password yang paling baru / terakhir
    c=$( cat password$count.txt )

    # Cek untuk setiap file
    for((i=$(($count-1)); i>0; i--))
      do
	# Buat variabel d untuk menyimpan isi file password yang sebelumnya
        d=$( cat password$i.txt  )

	# Bandingkan antara c dan d. Jika sama, generate password baru, dan beritahu user
	# Jika tidak, lewati.
        if [ $c == $d ]
        then
	  b=$( head /dev/urandom | tr -dc a-zA-Z0-9 | head -c 12 )
	  echo "Password dalam password"$i".txt diubah menjadi "$b
	  echo $b > password$i.txt
        else
	  continue
        fi
      done
    count=$(($count-1))
  else
    break
  fi
done
