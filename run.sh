#num=(1 2 3 4 5)
#total=0
#for i in ${num[@]}
#do
#  total=$((total+i))
#done
#
#echo $total


name="one two three four"

function one() {
  IFS="-"
    echo "-----------"
    echo "$*"
    echo "-----------"
    echo "$@"
}

one $name

##


$ aws-auth upsert --maproles --rolearn  --username eks-user --groups system:masters