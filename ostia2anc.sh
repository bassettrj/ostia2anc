# unpacks ostia SST files (scale and offset)
# runs xancil to create ostia SST .anc files for UM

d=2010-01-01
d2=$(echo $d | sed 's/\-//g')

while [ "$d" != 2010-03-01 ]; do 
    d3=$(echo $d | sed 's/\-//g')

    # unpack
    in="../ostia_sst/"$d3"_sst.nc"
    out="unpacked_"$d3"_sst.nc"
    #echo $in
    echo $out
    ncpdq --unpack $in $out

    # run xancil for sst
    cp xancil_sst.job temp_xancil.job
    sed -i "s/$d2/$d3/g" temp_xancil.job
    xancil -x -j temp_xancil.job

    # run xancil for seaice
    # to do

    # next day
    d=$(date -I -d "$d + 1 day")

    # remove unpacked file
    rm $out
    rm temp_xancil.job
done

echo "finished"
