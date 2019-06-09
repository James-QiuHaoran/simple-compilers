printf "Test Cases for Compiler c6c\n\n"

counter=0
pass=0
fail=0

for i in `ls test/*.sc`
do
	echo "+++++++++++++++++++++++++++++++++++"
	echo "|          $i           |"
	echo "+++++++++++++++++++++++++++++++++++"
	./c6c $i > test/${i:5:4}.nas
	printf "\n>>>> Source code:\n\n"
	cat $i
	echo ""
	printf "\n>>>> Result:\n\n"

	if [ "$counter" -eq "3" ]
	then
		echo "3" | ./nas test/${i:5:4}.nas > output
	elif [ "$counter" -eq "4" ]
	then
		echo "c" | ./nas test/${i:5:4}.nas > output
	elif [ "$counter" -eq "5" ]
	then
		echo "test" | ./nas test/${i:5:4}.nas > output
	else
		./nas test/${i:5:4}.nas > output
	fi

	cat output
	printf "\n>>>> Sample answer:\n\n"
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

for i in `ls test-c6/*.sc`
do
	echo "+++++++++++++++++++++++++++++++++++"
	echo "|          $i           |"
	echo "+++++++++++++++++++++++++++++++++++"
	./c6c < $i > test-c6/${i:8:4}.nas
	printf "\n>>>> Source code:\n\n"
	cat $i
	echo ""
	printf "\n>>>> Result:\n\n"
	if [ "$counter" -eq "17" ]
        then
		echo "this is a char array" | ./nas test-c6/${i:8:4}.nas > output
        elif [ "$counter" -eq "18" ]
        then
                echo "4\t\james" | ./nas test-c6/${i:8:4}.nas > output
	elif [ "$counter" -eq "23" ]
	then
		echo "3.45" | ./nas test-c6/${i:8:4}.nas > output
	else
        	./nas test-c6/${i:8:4}.nas > output
	fi

	cat output
	printf "\n>>>> Sample answer:\n\n"
	cat test-c6/${i:8:4}.ans
	
	if diff output test-c6/${i:8:4}.ans >/dev/null
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
