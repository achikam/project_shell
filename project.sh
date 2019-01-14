#!/bin/bash
####################################################################
#			PEMBUKAAN
####################################################################
declare -A field
tanggal=`date +%d/%m/20%y`
waktu=`date +%H:%M:%S`
clear

pembukaan() {
zenity  --info --width="525" --height="14" \
--title "Puzzle Number For You (3x3)" \
--ok-label="Lanjut =>" \
--text \
"<span size=\"xx-large\">Informasi Permainan :</span>
<span size=\"large\">	1. Terdapat 9 buah angka yang acak
	2. Urutkan 9 angka tersebut dengan secepat-cepatnya
	3. Jika angka sudah urut, anda menang
	4. Dapatkan waktu tercepat anda</span>"
if [ $? == 1 ]; then
	clear
	exit;
else
	intro
fi
}


intro() {
while [[ (-z $name1) ]]; do
	pemain=$(zenity --entry --title="Kenalan Dong!!" \
		--text="Nama Kamu: " );
	maju=$?
case $maju in
1)
exit 0;;
0)
pilih_level;;
esac
done
}

####################################################################
#		PROSES UTAMA
####################################################################

total_skor(){
fmt -1 dataScore.txt | awk -F '\\s{3,} | , ' 'NR {for(i=1;i<=1;i++) {print $i}}' | zenity --list --width="560" --height="351" --column="Nama" --column="Perolehan waktu(detik)" --column="level" --column="Tanggal" --column="Jam"
}


main_lagi(){ 
jwb=`zenity --entry --title "Puzzle Number For You (3x3)"  --width="300" --height="10"  --text  "Anda mau main lagi?? (y/t)"`
case $jwb in
y|Y)
pilih_level
;;
t|T)
reset
echo -e "	\033[33;45m--> Terimakasih telah mencoba permainan ini <--\033[0m"
echo -e "		    \033[43;31m--> #s0mprett0_tenan <--\033[0m"
echo ""
exit 0
;;
0)
reset
esac
}


cekUrut(){
if [[ ${field[1,1]} == 1 && ${field[1,2]} == 2 && ${field[1,3]} == 3 && ${field[2,1]} == 4 && ${field[2,2]} == 5 && ${field[2,3]} == 6 && ${field[3,1]} == 7 && ${field[3,2]} == 8 && ${field[3,3]} == 9 ]];then
end_time=$(date +%s) 
let total_time=end_time-start_time
echo
echo -e " \033[33;1;46mLooh kok sudah urut\033[0m (^_^)"
echo -e " \033[36;1;44mSelamat Gan!!!!!!\033[0m"
echo -e -n " \033[31;1;47m$pemain Menyelesaikan Permainan dalam waktu\033[0m "
  if [[ "$?" -eq 0 ]]; then
      date -u -d @${total_time} +%T
  else
      date -u -r ${total_time} +%T
  fi

echo "$pemain	$total_time	$lvl	$tanggal	$waktu" >> dataScore.txt
echo -e " \033[36;1;44mLihat keseluruhan score?? (y/t)\033[0m"
read skor
case $skor in 
   y|Y)   
	total_skor
	main_lagi;;

   t|T) main_lagi;;
esac
fi
}


move(){
while true
do
read -d'' -s -n1 input  # read input

case $input in 
   e) let var=field[1,3]
	let field[1,3]=field[2,3]
	let field[2,3]=var;;

   w) let var=field[1,2]
	let field[1,2]=field[1,3]
	let field[1,3]=var;;

   q) let var=field[1,1]
	let field[1,1]=field[1,2]
	let field[1,2]=var;;

  a) let var=field[2,1]
	let field[2,1]=field[1,1]
	let field[1,1]=var;;

  z) let var=field[3,1]
	let field[3,1]=field[2,1]
	let field[2,1]=var;;

  x) let var=field[3,2]
	let field[3,2]=field[3,1]
	let field[3,1]=var;;

  c) let var=field[3,3]
	let field[3,3]=field[3,2]
	let field[3,2]=var;;

  d) let var=field[2,3]
	let field[2,3]=field[3,3]
	let field[3,3]=var;;

  s) let var=field[2,2]
	let field[2,2]=field[2,3]
	let field[2,3]=var;;
esac

clear
echo -e "\033[33;1;46m			Informasi !!			\033[0m"
echo -e "\033[31;1;47mPerintah untuk memindahkan angka(sesuai posisi indeks) :\033[0m"
echo -e "\n\033[33;41m Q W E \033[0m  \e[1mQ->\033[33;1;46m(tukar Q dan W)\033[0m  \e[1;31m|\033[0m  \e[1mW->\033[33;1;46m(tukar W dan E)\033[0m  \e[1;31m|\033[0m  \e[1mE->\033[33;1;46m(tukar E dan D)\033[0m\n\033[33;41m A S D \033[0m  \e[1mA->\033[33;1;46m(tukar A dan Q)\033[0m  \e[1;31m|\033[0m  \e[1mS->\033[33;1;46m(tukar S dan D)\033[0m  \e[1;31m|\033[0m  \e[1mD->\033[33;1;46m(tukar D dan C)\033[0m\n\033[33;41m Z X C \033[0m  \e[1mZ->\033[33;1;46m(tukar Z dan A)\033[0m  \e[1;31m|\033[0m  \e[1mX->\033[33;1;46m(tukar X dan Z)\033[0m  \e[1;31m|\033[0m  \e[1mC->\033[33;1;46m(tukar C dan X)\033[0m\n\n\n"
printf '\n'
for l in $(seq 3); do
printf '\e[1;31m+------'
done
printf '\e[1;31m+\n'
for b_new in $(seq 3); do
    	printf '\e[1;31m|'
    		for k_new in $(seq 3); do
		printf '\e[1;34m %4d \e[0m' ${field[$b_new,$k_new]}
		printf '\e[1;31m|'
           	done 
    	let b_new==4 || {
      	printf '\n'
      	for l in $(seq 3); do
        printf '\e[1;31m+------'
      	done
      	printf '\e[1;31m+\n'
    	}
done
cekUrut
done
}

####################################################################
#		CETAK AREA
####################################################################
print_field(){
clear
declare -i start_time=$(date +%s)
echo -e "\033[33;1;46m			Informasi !!			\033[0m"; sleep 0.5
echo -e "\033[31;1;47mPerintah untuk memindahkan angka(sesuai posisi indeks) :\033[0m"; sleep 0.5
echo -e "\n\033[33;41m Q W E \033[0m  \e[1mQ->\033[33;1;46m(tukar Q dan W)\033[0m  \e[1;31m|\033[0m  \e[1mW->\033[33;1;46m(tukar W dan E)\033[0m  \e[1;31m|\033[0m  \e[1mE->\033[33;1;46m(tukar E dan D)\033[0m\n\033[33;41m A S D \033[0m  \e[1mA->\033[33;1;46m(tukar A dan Q)\033[0m  \e[1;31m|\033[0m  \e[1mS->\033[33;1;46m(tukar S dan D)\033[0m  \e[1;31m|\033[0m  \e[1mD->\033[33;1;46m(tukar D dan C)\033[0m\n\033[33;41m Z X C \033[0m  \e[1mZ->\033[33;1;46m(tukar Z dan A)\033[0m  \e[1;31m|\033[0m  \e[1mX->\033[33;1;46m(tukar X dan Z)\033[0m  \e[1;31m|\033[0m  \e[1mC->\033[33;1;46m(tukar C dan X)\033[0m\n\n\n"; sleep 0.5
printf '\n'
for l in $(seq 3); do
printf '\e[1;31m+------'
done
printf '\e[1;31m+\n'
for b in $(seq 3); do
    	printf '\e[1;31m|'
    		for k in $(seq 3); do
		printf '\e[1;34m %4d \e[0m' ${field[$b,$k]}
		printf '\e[1;31m|'
           	done 
    	let b==4 || {
      	printf '\n'
      	for l in $(seq 3); do
        printf '\e[1;31m+------'
      	done
      	printf '\e[1;31m+\n'
    	}
done
move
}

####################################################################
#		LEVEL PERMAINAN
####################################################################
easy(){
field[1,1]=2
field[1,2]=3
field[1,3]=6
field[2,1]=1
field[2,2]=5
field[2,3]=9
field[3,1]=4
field[3,2]=7
field[3,3]=8
lvl="Easy"
print_field
}

medium(){
field[1,1]=2
field[1,2]=3
field[1,3]=6
field[2,1]=9
field[2,2]=4
field[2,3]=1
field[3,1]=7
field[3,2]=5
field[3,3]=8
lvl="Meduim"
print_field
}

hard(){
field[1,1]=5
field[1,2]=3
field[1,3]=8
field[2,1]=1
field[2,2]=6
field[2,3]=9
field[3,1]=4
field[3,2]=7
field[3,3]=2
lvl="Hard"
print_field
}

pilih_level() {
level=$(zenity  --title "Sliding Number For You" --list  --list --text "Pilih Level Permainan Gan" --radiolist  --column "Pick" --column "Level Anda" TRUE Easy FALSE Medium FALSE Hard); echo $level
case $maju in
	0)				
	(echo "50" ; echo "# Mulai Main!!!") |
	zenity --progress --no-cancel --pulsate --title "Puzzle Number For You" \ --text "Loading...!!" --percentage=0 
	;;
	1)		
	echo "Terjadi Error!" ;;
	esac
case $level in
Easy)
easy;;
Medium)
medium;;
Hard)
hard;;
esac
}
####################################################################
####################################################################
pembukaan
