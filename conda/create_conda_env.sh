

read -p "Enter Conda env name: " env_name
read -p "Enter Python version: " python_version

conda create --name $env_name python=$python_version

