node gengraph.js $1 $2 > tmp.dot
tred tmp.dot > tred.dot
dot -T svg -O tred.dot
