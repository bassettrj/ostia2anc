# unpacks ostia SST files (scale and offset)
# runs xancil to create ostia SST and seaice .anc files for UM

d=2010-01-01
d2=$(echo $d | sed 's/\-//g')

while [ "$d" != 2010-03-01 ]; do 
    d3=$(echo $d | sed 's/\-//g')

    # unpack sst
    in="../ostia_sst/"$d3"_sst.nc"
    out="unpacked_"$d3"_sst.nc"
    #echo $in
    echo $out
    ncpdq --unpack $in $out

    # run xancil for sst
    cp xancil_sst.job temp_xancil.job
    sed -i "s/$d2/$d3/g" temp_xancil.job
    xancil -x -j temp_xancil.job

    # remove unpacked sst file
    rm $out
    rm temp_xancil.job

    # unpack seaice
    in="../ostia_sst/"$d3"_seaice.nc"
    out="unpacked_"$d3"_seaice.nc"
    #echo $in
    echo $out
    ncpdq --unpack $in $out

    # run xancil for seaice
    cp xancil_seaice.job temp_xancil.job
    sed -i "s/$d2/$d3/g" temp_xancil.job
    xancil -x -j temp_xancil.job

    # remove unpacked seaice file
    rm $out
    rm temp_xancil.job

    # next day
    d=$(date -I -d "$d + 1 day")
done

echo "finished"
