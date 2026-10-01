for file in ../restapi/*.json; do

echo $file

python script_FormatOverwrites.py $file

done