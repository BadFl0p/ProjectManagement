#!/bin/bash

function createProject()
{
	FOLDER=$1
	NAME=$2

	cd $FOLDER
	mkdir $NAME
	cd $NAME

	EXT=$3

	if [ ${EXT} == "C" ] || [ ${EXT} == "c" ]; then
		touch main.c
		echo "#include<stdio.h>" > main.c
		echo "#include<stdlib.h>" >> main.c
		echo >> main.c
		echo "int main()" >> main.c
		echo "{" >> main.c
		echo "	return 0;" >> main.c
		echo "}" >> main.c
		code ./main.c
	fi
	
	if [ ${EXT} == "C++" ] || [ ${EXT} == "c++" ]; then
		touch main.cpp
		echo "#include<iostream>" > main.cpp
		echo >> main.cpp
		echo "int main()" >> main.cpp
		echo "{" >> main.cpp
		echo "	return 0;" >> main.cpp
		echo "}" >> main.cpp
		code ./main.cpp
	fi

	if [ ${EXT} == "Py" ] || [ ${EXT} == "py" ] || [ ${EXT} == "PY" ]; then
		touch main.py
		echo "#insert shebang if wanted" > main.py
		echo >> main.py
		echo "def main():" >> main.py
		echo "	print(\"hello world\")" >> main.py
		echo >> main.py
		echo "if __name__ ==\"__main__\":" >> main.py
		echo "	main()" >> main.py
		code ./main.py
	fi
}

function addFiles()
{
	NAME=$1
	EXT=$2

	if [ $EXT == "py" ]; then
		touch ${NAME}.py
		code ${NAME}.py
	elif [ $EXT == "C" ]; then
		mkdir $NAME
		touch ${NAME}/${NAME}.c
		touch ${NAME}/${NAME}.h
		code ${NAME}/${NAME}.c
		code ${NAME}/${NAME}.h
	elif [ $EXT == "C++" ]; then
		mkdir $NAME
		touch ${NAME}/${NAME}.cpp
		touch ${NAME}/${NAME}.h
		code ${NAME}/${NAME}.cpp
		code ${NAME}/${NAME}.h
	else
		echo "Error"
	fi
}

NAME_FOUND=0

for ARG in $*; do
	if [ ${ARG:0:3} == "-cr" ]; then
		for NAME in $*; do
			if [ ${NAME:0:2} == "-n" ]; then
				for EXT in $*; do
					if [ ${EXT:0:5} == "-lang" ]; then
						createProject ${ARG:4} ${NAME:3} ${EXT:6}
					fi
				done
				createProject ${ARG:4} ${NAME:3} "C"
				NAME_FOUND=1
			fi
		done
		
		if [ $NAME_FOUND -eq 0 ]; then
			createProject ${ARG:4} "New" "C"
		fi
	fi

	if [ ${ARG:0:6} == "-addPy" ]; then
		addFiles ${ARG:7} "py"
	elif [ ${ARG:0:6} == "-addC=" ]; then
		addFiles ${ARG:6} "C"
	elif [ ${ARG:0:7} == "-addCpp" ]; then
		addFiles ${ARG:8} "C++"
	else
		echo "Error"
	fi
done	
