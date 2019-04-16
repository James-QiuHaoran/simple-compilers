printf "Test Cases for Compiler c5c\n\n"

counter=0
pass=0
fail=0

for i in `ls test/*.sc`
do
	echo "+++++++++++++++++++++++++++++++++++"
	echo "|          $i           |"
	echo "+++++++++++++++++++++++++++++++++++"
	./c5c $i > test/${i:5:4}.nas
	printf "\n>>>> Source code:\n\n"
	cat $i
	echo ""
	printf ">>>> Result:\n\n"

	if [ "$counter" -eq "0" ]
	then
		echo "3" | ./nas test/${i:5:4}.nas > output
	elif [ "$counter" -eq "1" ]
	then
		echo "c" | ./nas test/${i:5:4}.nas > output
	elif [ "$counter" -eq "2" ]
	then
		echo "test" | ./nas test/${i:5:4}.nas > output
	else
		./nas test/${i:5:4}.nas > output
	fi

	echo ""
	
	cat output
	printf ">>>> Sample answer:\n\n"
	cat test/${i:5:4}.ans
	
	if diff output test/${i:5:4}.ans >/dev/null
	then
		pass=$((pass+1))
		printf "\nTest passed!\n\n"
	else
		fail=$((fail+1))
		printf "\nTest failed!\n\n"
	fi

	rm -rf output
	echo ""

	counter=$((counter+1))
done

echo "----------"
echo "All $counter tests: $pass passed, $fail failed"
