#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

printf "${bold}Project setup${normal}\n"
mix do deps.get, compile

printf "\n${bold}Showing help message${normal} \"mix download help\"\n"
mix download help

printf "\n${bold}Running with arguments${normal} \"mix download https://www.google.com https://telnyx.com\"\n"
mix download https://www.google.com https://telnyx.com

printf "\n${bold}Running with file${normal} \"mix download urls.txt\"\n"
mix download urls.txt
