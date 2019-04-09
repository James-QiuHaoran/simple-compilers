printf "Test Cases for Compiler c5c\n\n"

for i in `ls test/*.sc`
do
	echo "+++++++++++++++++++++++++++++++++++"
	echo "|          $i           |"
	echo "+++++++++++++++++++++++++++++++++++"
	./c5c $i > $i.nas
	printf "\n>>>> Source code:\n\n"
	cat $i
	echo ""
	printf ">>>> Result:\n\n"
	./nas $i.nas
	echo ""
done
