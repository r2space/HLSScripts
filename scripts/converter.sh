# get shell path
shellpath=$(pwd)/${0}
path=`dirname $shellpath`
name=`echo $1 | sed 's/\..*//g'`

# move to the directory where the shell
pushd ${path}

# if the file already exists, delete
ts="$name.ts"
rm -f ${ts}

# convert to ts
ffmpeg -i $1 -re -f mpegts -acodec libmp3lame -ar 44100 -ab 128k -ac 2 -s 300X200 -vcodec libx264 -b 512k -flags +loop -cmp +chroma -subq 5 -trellis 1 -refs 1 -coder 0 -me_range 16 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -bt 512k -maxrate 768k -bufsize 5000k -rc_eq 'blurCplx^(1-qComp)' -qcomp 0.6 -qmin 10 -qmax 51 -qdiff 4 -level 30 -g 30 -async 2 $ts

# split file
m3u8="$name.m3u8"
./segmenter $ts 10 $name $m3u8 http://54.250.123.231/movies/

# delete temporary file
rm -f ${ts}
popd


