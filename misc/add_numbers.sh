#!/bin/bash

add_numbers() {
    read -p "Enter the first number: " num1
    read -p "Enter the second number: " num2
    read -p "Enter the third number: " num3
    
    sum=$(echo "$num1 + $num2 + $num3" | bc)
    
    echo "The sum of the numbers is: $sum"
}

add_numbers
