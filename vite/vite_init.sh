#!/bin/bash


read -p "Enter Project name: " project_name
read -p "Enter Template (vanilla, vanilla-ts, vue, vue-ts, react, react-ts, react-swc, react-swc-ts, preact, preact-ts, lit, lit-ts, svelte, svelte-ts, solid, solid-ts, qwik, qwik-ts): " template

npm create vite@latest $project_name -- --template $template

cd $project_name
npm i

