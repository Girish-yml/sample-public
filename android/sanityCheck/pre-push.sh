#!/bin/bash

#Find the files which are not staged
FILES=$(git diff --cached --name-only --diff-filter=ACMR | grep '\.kt$')

if [[ "$FILES" != "" ]]; then
  echo "Running ktlint on the following files:"
  echo "$FILES"
  ./gradlew ktlintFormat --daemon --continue -Pfiles="$FILES"
  ./gradlew ktlintCheck --daemon --continue -Pfiles="$FILES"
  if [ $? -ne 0 ]; then
    echo "Ktlint check failed. Please fix the errors and try again."
    exit 1
  fi
fi

#echo "Running unit tests..."
#./gradlew test
#if [ $? -ne 0 ]; then
#  echo "Unit tests failed. Please fix the errors and try again."
#  exit 1
#fi
#
#echo "Compiling the Android build..."
#./gradlew assembleDebug
#if [ $? -ne 0 ]; then
#  echo "Build failed. Please fix the errors and try again."
#  exit 1
#fi

exit 0
