BEGIN{
    FS = ","
}

NR==1 {min=$4 ;country=$1}
NR> 1 && $4 < min {min = $4; country=$1}

END{
    print country,min;
}
