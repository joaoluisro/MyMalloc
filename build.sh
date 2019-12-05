cd src

for i in 5_1 5_2a 5_2e 5_4
	do
	cd $i
	echo $i
	if [ $1 == clean ]
	then
		make clean
	elif [ $1 == all ]
	then
		make
	elif [ $1 == run ]
	then
		./$i
	fi
	cd ..
done

