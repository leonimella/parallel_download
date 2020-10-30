#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

printf "${bold}Project setup${normal}\n"
mix do deps.get, compile

printf "\n${bold}Showing help message${normal} \"mix download\"\n"
mix download

printf "\n${bold}Running with arguments${normal} \"mix download https://www.google.com https://telnyx.com\"\n"
mix download https://www.google.com https://telnyx.com

printf "\n${bold}Running with file${normal} \"mix download urls.txt\"\n"
mix download urls.txt

printf "\n${bold}Running tests${normal} \"mix test\"\n"
mix test
