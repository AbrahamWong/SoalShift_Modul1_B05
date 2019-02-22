# SoalShift_Modul1_B05
## Jawaban Soal Shift Modul 1

1. Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.

> ### Jawaban
> Ekstrak file nature.zip yang berada di direktori Downloads/ dengan perintah 
> ```bash
> $ cd Downloads/
> $ unzip nature.zip
> ```
> Setelah file selesai diekstrak, dapat dilihat bahwa file - file yang berada dalam folder **nature** tidak dapat dibuka karena dienkripsi.\
> <img src="https://github.com/AbrahamWong/SoalShift_Modul1_B05/blob/master/images/1_3.JPG">
> 
> Untuk itu, buat satu script untuk mendekripsi / decrypt file tersebut dan mengembalikan isinya seperti semula.<br>
> Misalkan nama file adalah soal1.sh, dan dibuat di direktori ~/.
> ```bash
> #!/bin/bash
> a=0
> cd Downloads
> unzip nature.zip
> cd nature
> for i in *.jpg
> do
>   base64 -d $i | xxd -r > gambar"$a".jpg
>   let a++
>   rm $i
> done
> ```
> Penjelasan dari kode ini adalah sebagai berikut :<br>
> * ```for i in *.jpg``` melakukan iterasi untuk setiap file dalam folder **nature**.
> * ```base64 -d $i ``` mendekripsi setiap file berdasarkan enkripsi base64. Karena hasil dari dekripsi ini berbentuk <a href="https://en.wikipedia.org/wiki/Hex_dump" target="_blank">hexdump</a>, perlu diubah lagi.
> * ```xxd -r > gambar"$a".jpg``` melakukan reverse hexdump dari hasil dekripsi sebelumnya, dan menyimpan hasil proses tersebut ke dalam file bernama gambar0.jpg sampai gambar96.jpg.<br>
>
> Agar script ini dapat dibuka secara terjadwal seperti permintaan soal, kita perlu menambahkan cron job pada cron table. Jalankan ```crontab -e```, dan tulis dalam cron table seperti berikut : <br>
> * ```14 14 14 2 * /bin/bash /home/(user)/soal1.sh``` untuk menjalankan soal1.sh setiap tanggal 14 Februari jam 14:14.<br>
> * ```* * * 2 5 /bin/bash /home/(user)/soal1.sh``` untuk menjalankan soal1.sh setiap menit setiap hari Jumat pada bulan Februari.

2. Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv. Laporan yang diminta berupa:\
a. Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.<br>
b. Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin a.<br>
c. Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin b.<br>

3. Buatlah sebuah script bash yang dapat menghasilkan password secara acak sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama sebagai berikut:\
a. Jika tidak ditemukan file password1.txt maka password acak tersebut disimpan pada file bernama password1.txt.<br>
b. Jika file password1.txt sudah ada maka password acak baru akan disimpan pada file bernama password2.txt dan begitu seterusnya.<br>
c. Urutan nama file tidak boleh ada yang terlewatkan meski filenya dihapus.<br>
d. Password yang dihasilkan tidak boleh sama.<br>

> ### Jawaban
> Untuk membuat sebuah string dengan 12 karakter acak yang terdiri dari huruf besar, huruf kecil, dan angka, gunakan perintah
> ```bash
> $ head /dev/urandom | tr -dc a-zA-Z0-9 | head -c 12
> ```
> - ```head /dev/random``` mengambil 10 baris pertama dari file /dev/urandom, sebuah file khusus yang bertujuan untuk membuat karakter random.<br>
> - ```tr -dc a-zA-Z0-9``` kemudian menghapus karakter selain huruf besar, huruf kecil, dan angka dari perintah sebelumnya.<br>
> - ```head -c 12``` lalu mengambil 12 bit pertama dari perintah sebelumnya.<br>
> 
> Kemudian, untuk membuat file password tepat sesuai urutan, dan tidak menghasilkan password yang sama, buat sebuah script dengan perintah
> ```bash
> #!/bin/bash
> 
> # Deklarasi variabel count dan membuat password a
> count=1
>
> # Membuat file
> for i in *.txt
> do
>  a=`head /dev/urandom | tr -dc a-zA-Z0-9 | head -c 12`
>
>   # Membuat sebuah file baru jika tidak ada file
>   if [ $i == "*.txt" ]
>   then
>     echo $a" > password"$count".txt"
>     echo $a > password$count.txt
>     break
>
>   # Mengecek jika file setelahnya tidak ada. Untuk menjaga urutan nama dan membuat file baru
>   elif [ ! -e password$((count+1)).txt  ]
>   then
>     echo $a" > password"$((count+1))".txt"
>     echo $a > password$((count+1)).txt
>     count=$(($count+1))
>
>   # Jika berjalan dengan normal, tambahkan variabel count dengan 1
>   else
>     count=$(($count+1))
>   fi
> done
> 
> count=0
> for i in password*.txt
> do
>   let count++
> done
>
> # Mengecek jika ada password yang sama di antara dua file
> for i in password*.txt
> do
>   if [ $count != 0  ]
>   then
> 
>     # Buat variabel c untuk menyimpan isi file password yang paling baru / terakhir
>     c=$( cat password$count.txt )
>
>     # Cek untuk setiap file
>     for((i=$(($count-1)); i>0; i--))
>       do
> 	      # Buat variabel d untuk menyimpan isi file password yang sebelumnya
>         d=$( cat password$i.txt  )
>
> 	      # Bandingkan antara c dan d. Jika sama, generate password baru, dan beritahu user
> 	      # Jika tidak, lewati.
>         if [ $c == $d ]
>         then
> 	        b=$( head /dev/urandom | tr -dc a-zA-Z0-9 | head -c 12 )
> 	        echo "Password dalam password"$i".txt diubah menjadi "$b
> 	        echo $b > password$i.txt
>         else
> 	        continue
>         fi
>       done
>     count=$(($count-1))
>   else
>     break
>   fi
> done
> ```
> #### Penjelasan
> Untuk mengisi file password dengan password yang telah dibuat, perintahnya adalah : 
> - ```count=1``` untuk mengeset variabel count menjadi 1. Variabel count nantinya akan dipakai untuk pengecekan nama dan isi file.
> - ```for i in *.txt``` untuk mengecek setiap file dalam direktori tersebut. Jika ada file, file akan diiterasi dengan perintah dalam **for**. Jika tidak ada file, kembalikan **\*.txt**.
> - ```a=`head /dev/urandom | tr -dc a-zA-Z0-9 | head -c 12` ``` menyimpan 12 bit string random yang berisi huruf besar, kecil, dan angka ke dalam variabel a.
> - ```if [ $i == "*.txt" ]``` mengecek jika tidak ada file sama sekali.
> - ```echo $a > password$count.txt``` untuk memasukan isi dari variabel a ke dalam file password pertama, sesuai instruksi soal bagian a. 
> - ```elif [ ! -e password$((count+1)).txt  ]``` mengecek jika nama file setelah file tersebut (dalam iterasi) ada. Ini bertujuan untuk menjaga urutnya nama file, sesuai instruksi soal bagian b dan c.
> - ```echo $a > password$((count+1)).txt``` untuk memasukkan isi dari variabel a ke dalam file password setelah file yang dicek.
> - ```count=$(($count+1))``` menambah count dengan 1.
>
> **count** kemudian di-reset untuk kemudian dimasukan dalam fungsi ```for i in password*.txt``` pertama, untuk mengetahui seberapa banyak file password yang ada sekarang.
> 
> Untuk menjaga agar password tidak sama seperti instruksi soal bagian d, setiap isi file perlu dicek dan dibandingkan dengan file lain.
> - ```for i in password*.txt``` mengecek setiap file bernama password dengan angka berapapun, dan memiliki format .txt.
> - ```if [ $count != 0  ]``` mengecek jika count tidak sama dengan 0. Saat ini nilai **count** adalah banyaknya file.
> - Buat variabel c yang memuat isi dari file password ke - count, dan lakukan iterasi untuk setiap file dari file ke - (count - 1) sampai file terakhir.
> - Untuk setiap file, jika ada file yang memiliki isi yang sama, buat password baru, dan masukkan ke dalam file password dalam iterasi (bukan file ke - count).
> - Jika tidak ada, kurangi count dengan 1, ulangi step di atas. 

4. Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal-bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (string manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai
berikut:\
a. Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan pukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki urutan ke 12+2 = 14.\
b. Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke empat belas, dan seterusnya.\
c. setelah huruf z akan kembali ke huruf a.\
d. Backup file syslog setiap jam.\
e. dan buatkan juga bash script untuk dekripsinya.

> ### Jawaban
> - Untuk mengenkripsi isi file dengan konversi huruf, dapat menggunakan perintah `tr`
> - Karena diminta formatfile sesuai waktu dan tanggal saat ini, maka kita gunakan perintah `date`
> - Berikut program bashnya atau bisa diunduh [disini](/soal4_enkripsi.sh) 
```shell
#!/bin/bash

# Buat nyimpan jamnya
jam=$(date "+%H")
# Buat nyimpan namafilenya
filename=$(date "+%H:%M %d-%B-%Y")

# Case buat uppercase atau lowercase
lower=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
upper=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ

cat /var/log/syslog | tr "${lower:0:26}" "${lower:jam:26}" | tr "${upper:0:26}" "${upper:jam:26}"  > "$filename"
```
> - Untuk memback-up file syslog setiap jam, dengan >mengetikkan:
> ```shell
> $crontab -e
> 0 * * * * /bin/bash /path/to/directory/soal4_deskripsi.sh
> ```
> - Untuk membuat deskripsinya, hampir sama dari program enkripsi, pada perintah `tr`nya kita ubah rangenya untuk mengembalikannya
```shell
#!/bin/bash

# Mengambil argumen pertama dari file
file="$1"
filename="$1-dec"
jam="${file:0:2}"

# Case buat uppercase atau lowercase
lower=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
upper=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ

cat "$1" | tr "${lower:0:26}" "${lower:26-jam:26}" | tr "${upper:0:26}" "${upper:26-jam:26}"  > "$filename"
```


5. Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi kriteria berikut:
a. Tidak mengandung string “sudo”, tetapi mengandung string “cron”, serta buatlah pencarian stringnya tidak bersifat case sensitive, sehingga huruf kapital atau tidak, tidak menjadi masalah.\
b. Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13.\
c. Masukkan record tadi ke dalam file logs yang berada pada direktori /home/[user]/modul1.\
d. Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst.

> ### Jawaban
> Untuk menyimpan record dalam syslog yang memenuhi kriteria poin a, b, c silahkan unduh [disini](/soal5.sh) atau bisa dengan menggetikkan :

```shell
#!/bin/bash
awk '{if ($0 ~/cron/ && $0 !~ /sudo/ && NF < 13) print $0}' /var/log/syslog > /home/$USER/modul1/record.log
```

> #### Penjelasan:
> - Tidak mengandung string sudo, tetapi mengandung string cron dengan menambahkan ```$0 ~/cron/ && $0 !~ /sudo/```
> - Jumlah field < 13 yaitu dengan menambahkan `NF < 13` 
> - Masukkan record kedalam direktori /home/user/modul1, dengan menambahkan `>` dioutputkan ke direktori yang dimaksud.
> - Jalankan script setiap 6 menit dari menit ke 2 hingga 30
```shell
$ crontab -e
$ 2-30/6 * * * * /bin/bash /path/to/directory/soal5.sh
```
