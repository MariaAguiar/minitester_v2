#!/usr/bin/env bash

# ANSI color escape sequences
RED='\033[1;31m'
GREEN='\033[1;32m'
RESET='\033[0m'

[ -e out_bash ] && rm -rf out_bash
[ -e out_minishell ] && rm -rf out_minishell
[ -e out_leaks ] && rm -rf out_leaks

n=1
args_list="$@"

# Get valgrind option
get_arg1()
{
	for arg in "$@"
	do
		if [ "$arg" = "-v" ]; then
			echo "valgrind --trace-children=yes --track-fds=yes --suppressions="readline.supp"";
		fi
	done
}

# Reading results
readfile()
{
    read="$1"

    while read line; do
		echo $line
    done < ${read}
}

# Get minishell result without prompt
clean_test()
{
	dest="$1"
	touch temp;
    while read -r line; do
		if [[ "${line}" = *"${prompt}"* ]]; then
			continue ;
		elif [[ "${line}" == "exit" ]]; then
			continue ;
		elif [[ "${line}" == *"exitcodes" ]]; then
			continue ;
		else
			echo "${line}" >> temp;
		fi
    done < "$dest"
	mv temp "$dest"
}

# Run Tests
do_tests()
{
	mkdir out_leaks
	mkdir out_minishell
	mkdir out_bash
	chmod +rw out_bash;
	chmod +rw out_minishell;
	dir=$1
	test="test"
	chmod +rwx "${dir}/${test}${n}";
	echo "${dir}:"
	dir+="/"
	while [ -e "${dir}${test}${n}" ]; do
		res0="out_leaks/res${n}" 
        $val ../minishell < "${dir}${test}${n}" > $res0 2>&1>/dev/null
		clean_test $res0;
		if [ $(head -10 $res0 | wc -l) -lt 10 ]; then
			rm $res0
		fi
		res1="out_minishell/res${n}" 
        $val ../minishell < "${dir}${test}${n}" > $res1 2>/dev/null
		cat exitcodes >> $res1
		clean_test $res1;
		res2="out_bash/res${n}"
		touch $res2
		$val bash < "${dir}${test}${n}" > $res2 2>/dev/null
		cat exitcodes >> $res2
		if diff -q $res1 $res2 2>&1 > /dev/null; then
			echo -e "Test ${n}: ${GREEN} [OK]${RESET}"
		else
			echo -e "Test ${n}: ${RED} [KO]${RESET}"
			readfile "${dir}${test}${n}"
			readfile "out_minishell/res${n}"
			readfile $res2
		fi
		n=$((n+1))
	done
	echo ""
	echo ""
	n=1
	[ -e out_bash ] && rm -rf out_bash
	[ -e out_minishell ] && rm -rf out_minishell
	rmdir out_leaks
}

# Prep Work
prompt=$(bash ./gen_prompt.sh);
val=$(get_arg1 ${args_list[@]});

#Run Test Lists
touch exitcodes
do_tests "test_list";
rm exitcodes

exit;