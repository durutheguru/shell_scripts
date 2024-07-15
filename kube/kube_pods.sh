if [ $# == 1 ];
then
  kubectl get pods -n ${1}
else
  read -p "Enter Pod namespace: " namespace
  kubectl get pods -n $namespace
fi

