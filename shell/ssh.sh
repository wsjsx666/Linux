read -p 'IP:' a
read -p 'PORT:' b
ssh -p ${b:-22} -X 176.121.204.$a
