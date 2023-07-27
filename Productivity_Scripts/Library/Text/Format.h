#!/bin/zsh

RED='\033[0;31m'
ORANGE='\033[0;33m'
GREEN='\033[0;32m'
YELLOW='\e[1;33m'
NC='\033[0m' # No Color

function fatal() {
  printf "${RED}%s\n${NC}" $* >&2
}

function warn() {
  printf "${ORANGE}%s\n${NC}" $*
}

function info() {
  printf "${GREEN}%s\n${NC}" $1
}

function getUnFormattedText()
{
	echo `echo ${1} | sed  's/\x1b\[[0-9;]*m//g'| col -b`
}

function Debug()
{
	 printf "${YELLOW}%s\n${NC}" $* >&2
}
