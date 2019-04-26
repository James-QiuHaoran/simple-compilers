printf "Sample Programs for the Compiler c6c\n\n"

for i in `ls sample_progs/*.sc`
do
	echo "========== $i =========="
	./c6c $i > $i.nas
	printf "\n>>>> Source code:\n\n"
	cat $i
	echo ""
	printf ">>>> Result:\n\n"
	./nas $i.nas
	echo ""
done
