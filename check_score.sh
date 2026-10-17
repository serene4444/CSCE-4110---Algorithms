#!/usr/bin/env bash

read -r -p "Enter your score: " score

if (( score >= 90 )); then
    echo "excellent"
elif (( score >= 70 )); then
    echo "good"
else
    echo "needs improvement"
fi