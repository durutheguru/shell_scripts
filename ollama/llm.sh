#!/bin/bash

# Use environment variable DEFAULT_MODEL if set, otherwise use llama3.2
DEFAULT_MODEL=${DEFAULT_MODEL:-"llama3.2"}

read -p "Enter a model name (default: $DEFAULT_MODEL): " model_input

if [ -z "$model_input" ]; then
    echo "Using default model: $DEFAULT_MODEL"
    model_input="$DEFAULT_MODEL"
fi

echo "Running ollama with model: $model_input"
ollama run $model_input
