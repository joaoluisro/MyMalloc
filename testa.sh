cd src

echo $1

for i in 5.1 5.2a 5.2e 5.4
	do
	cd $i
	echo $i
	if [ $1 == clean ]
	then
		echo $1
		make clean
	else
	then
		make
	fi
	cd ..
done

