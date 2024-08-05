#!/bin/bash

read -p "Enter a model name (default: llama3.1): " model_input

if [ -z "$model_input" ]; then
  echo "Using default model: llama3.1"
  model_input="llama3.1"
fi

echo "Running ollama with model: $model_input"
ollama run $model_input
