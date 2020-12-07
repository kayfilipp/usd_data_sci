BEGIN{
    FS = "," ; OFS = ","
}

{
    delta = $2-$3
    print $1,delta
}
