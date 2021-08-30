#!/bin/bash


echo "bonjour" > infile
touch error

printf "./pipex infile \"pwd\" \"sed -e s/[aeio]/u/g\" out\n" | tee error
if [ ""$1"" = "leak" ]
then
valgrind --show-leak-kinds=all --leak-check=full  ./pipex infile "pwd" "sed -e s/[aeio]/u/g" out 2>> error
else
./pipex infile "pwd" "sed -e s/[aeio]/u/g" out 2>> error
fi
stat=$?
{ < infile pwd | sed -e s/[aeio]/u/g > out2; } 2>> error
stat2=$?
diff out out2 
if	[ $stat -eq $stat2 ] && [ $? = 0 ]
then
	printf "OK\n"
else
	printf "BAD\n"
fi
printf "your exit code: %d bash exit code: %d\n\n" $stat $stat2
printf "\n" >>error


printf "./pipex infile \"cat\" \"sed -e s/[aeio]/u/g\" out\n" | tee -a error
if [ "$1" = "leak" ]
then
valgrind --show-leak-kinds=all --leak-check=full  ./pipex infile "cat" "sed -e s/[aeio]/u/g" out 2>> error
else
./pipex infile "cat" "sed -e s/[aeio]/u/g" out 2>> error
fi
stat=$?
{ < infile cat | sed -e s/[aeio]/u/g > out2; } 2>> error
stat2=$?
diff out out2 
if	[ $stat -eq $stat2 ] && [ $? = 0 ]
then
	printf "OK\n"
else
	printf "BAD\n"
fi
printf "your exit code: %d bash exit code: %d\n\n" $stat $stat2
printf "\n" >>error

printf "./pipex infile \"ls -a\" \"gre mlml\" out\n" | tee -a error
touch out2
if [ "$1" = "leak" ]
then
valgrind --show-leak-kinds=all --leak-check=full  ./pipex infile "ls -a" "gre mlml"  out 2>> error
else
./pipex infile "ls -a" "gre mlml" out 2>> error
fi
stat=$?
{ < infile ls -a | gre mlml > out2; } 2>> error
stat2=$?
diff out out2 
if	[ $stat -eq $stat2 ] && [ $? = 0 ]
then
	printf "OK\n"
else
	printf "BAD\n"
fi
printf "your exit code: %d bash exit code: %d\n\n" $stat $stat2
printf "\n" >>error

printf "./pipex notexist \"ls -a\" cat out\n"  | tee -a error
touch out2
if [ "$1" = "leak" ]
then
valgrind --show-leak-kinds=all --leak-check=full  ./pipex notexist "ls -a" cat out 2>> error
else
./pipex notexist "ls -a" cat out 2>> error
fi
stat=$?
{ < notexist ls -a | cat > out2; } 2>> error
stat2=$?
diff out out2 
if	[ $stat -eq $stat2 ] && [ $? = 0 ]
then
	printf "OK\n"
else
	printf "BAD\n"
fi
printf "your exit code: %d bash exit code: %d\n\n" $stat $stat2
printf "\n" >>error


printf "./pipex notexist \"ls -a\" \"pwd\" out\n" | tee -a error
touch out2
if [ "$1" = "leak" ]
then
valgrind --show-leak-kinds=all --leak-check=full  ./pipex notexist "ls -a" pwd out 2>> error
else
./pipex notexist "ls -a" pwd out 2>> error
fi
stat=$?
{ < notexist ls -a | pwd > out2; } 2>> error
stat2=$?
diff out out2 
if	[ $stat -eq $stat2 ] && [ $? = 0 ]
then
	printf "OK\n"
else
	printf "BAD\n"
fi
printf "your exit code: %d bash exit code: %d\n\n" $stat $stat2
printf "\n" >>error


printf "ln -s test2 && ./pipex infile cat \"grep o\" test2\n" | tee -a error
ln -s out3
ln -s test2
if [ "$1" = "leak" ]
then
valgrind --show-leak-kinds=all --leak-check=full  ./pipex infile cat "grep o" test2 2>> error
else
./pipex infile cat "grep o" test2 2>> error
fi
stat=$?
{ < infile cat | grep o > out3; } 2>> error
stat2=$?
diff out out3
if	[ $stat -eq $stat2 ] && [ $? = 0 ]
then
	printf "OK\n"
else
	printf "BAD\n"
fi
printf "your exit code: %d bash exit code: %d\n\n" $stat $stat2
printf "\n" >>error
rm test2

printf "ln -s test2 && ./pipex test2 ls cat out\n" | tee -a error
touch out2
ln -s test2
if [ "$1" = "leak" ]
then
valgrind --show-leak-kinds=all --leak-check=full  ./pipex test2 ls cat out 2>> error
else
./pipex test2 ls cat out 2>> error
fi
stat=$?
{ < test2 ls | cat > out2; } 2>> error
stat2=$?
diff out out2
if	[ $stat -eq $stat2 ] && [ $? = 0 ]
then
	printf "OK\n"
else
	printf "BAD\n"
fi
printf "your exit code: %d bash exit code: %d\n\n" $stat $stat2
printf "\n" >>error
rm test2


printf "ln -s Makefile test2 && ./pipex test2 ls cat out\n" | tee -a error
touch out2
ln -s Makefile test2
if [ "$1" = "leak" ]
then
valgrind --show-leak-kinds=all --leak-check=full  ./pipex test2 ls cat out 2>> error
else
./pipex test2 ls cat out 2>> error
fi
stat=$?
{ < test2 ls | cat > out2; } 2>> error
stat2=$?
diff out out2
if	[ $stat -eq $stat2 ] && [ $? = 0 ]
then
	printf "OK\n"
else
	printf "BAD\n"
fi
printf "your exit code: %d bash exit code: %d\n\n" $stat $stat2
printf "\n" >>error
rm test2


printf "ln Makefile test2 && ./pipex test2 cat \"grep o\" out\n" | tee -a error
touch out2
ln Makefile test2
if [ "$1" = "leak" ]
then
valgrind --show-leak-kinds=all --leak-check=full  ./pipex test2 cat "grep o" out 2>> error
else
./pipex test2 cat "grep o" out 2>> error
fi
stat=$?
{ < test2 cat | grep o > out2; } 2>> error
stat2=$?
diff out out2
if	[ $stat -eq $stat2 ] && [ $? = 0 ]
then
	printf "OK\n"
else
	printf "BAD\n"
fi
printf "your exit code: %d bash exit code: %d\n\n" $stat $stat2
printf "\n" >>error
rm test2

printf "chmod 777 mo && ./pipex infile ls mo out\n" | tee -a error
touch mo
chmod 777 mo
if [ "$1" = "leak" ]
then
valgrind --show-leak-kinds=all --leak-check=full  ./pipex infile ls mo out 2>> error
else
./pipex infile ls mo out 2>> error
fi
stat=$?
{ < infile ls | mo > out2; } 2>> error
stat2=$?
diff out out2
if	[ $stat -eq $stat2 ] && [ $? = 0 ]
then
	printf "OK\n"
else
	printf "BAD\n"
fi
printf "your exit code: %d bash exit code: %d\n\n" $stat $stat2
printf "\n" >>error
rm mo


printf "chmod 777 mo && ./pipex infile ls ./mo out\n" | tee -a error
touch mo
chmod 777 mo
if [ "$1" = "leak" ]
then
valgrind --show-leak-kinds=all --leak-check=full  ./pipex infile ls ./mo out 2>> error
else
./pipex infile ls ./mo out 2>> error
fi
stat=$?
{ < infile ls | ./mo > out2; } 2>> error
stat2=$?
diff out out2
if	[ $stat -eq $stat2 ] && [ $? = 0 ]
then
	printf "OK\n"
else
	printf "BAD\n"
fi
printf "your exit code: %d bash exit code: %d\n\n" $stat $stat2
printf "\n" >>error
rm mo


printf "chmod 666 mo && ./pipex infile ls ./mo out\n" | tee -a error
touch mo
chmod 666 mo
if [ "$1" = "leak" ]
then
valgrind --show-leak-kinds=all --leak-check=full  ./pipex infile ls ./mo out 2>> error
else
./pipex infile ls ./mo out 2>> error
fi
stat=$?
{ < infile ls | ./mo > out2; } 2>> error
stat2=$?
diff out out2
if	[ $stat -eq $stat2 ] && [ $? = 0 ]
then
	printf "OK\n"
else
	printf "BAD\n"
fi
printf "your exit code: %d bash exit code: %d\n\n" $stat $stat2
printf "\n" >>error
rm mo


printf "chmod 666 mo && ./pipex infile ls mo out\n" | tee -a error
touch mo
chmod 666 mo
if [ "$1" = "leak" ]
then
valgrind --show-leak-kinds=all --leak-check=full  ./pipex infile ls mo out 2>> error
else
./pipex infile ls mo out 2>> error
fi
stat=$?
{ < infile ls | mo > out2; } 2>> error
stat2=$?
diff out out2
if	[ $stat -eq $stat2 ] && [ $? = 0 ]
then
	printf "OK\n"
else
	printf "BAD\n"
fi
printf "your exit code: %d bash exit code: %d\n\n" $stat $stat2
printf "\n" >>error
rm mo

printf "chmod 666 mo && ./pipex infile ls /mo out\n" | tee -a error
touch mo
chmod 666 mo
if [ "$1" = "leak" ]
then
valgrind --show-leak-kinds=all --leak-check=full  ./pipex infile ls /mo out 2>> error
else
./pipex infile ls /mo out 2>> error
fi
stat=$?
{ < infile ls | /mo > out2; } 2>> error
stat2=$?
diff out out2
if	[ $stat -eq $stat2 ] && [ $? = 0 ]
then
	printf "OK\n"
else
	printf "BAD\n"
fi
printf "your exit code: %d bash exit code: %d\n\n" $stat $stat2
printf "\n" >>error
rm mo

if [ "$1" = "leak" ]
then
cat error | grep "use"
cat error | grep "errors from"
fi
rm out out2 out3 infile


