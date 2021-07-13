echo "Beginning Build:"
player_path=$(cd $(dirname ${0}) && pwd)
ffmpeg_path=${your ffmpeg path}

rm -r ${player_path}/dist
mkdir -p ${player_path}/dist
cd ${ffmpeg_path}
echo "emconfigure"
emconfigure ./configure --cc="emcc" --cxx="em++" --ar="emar" --ranlib="emranlib" --prefix=${player_path}/dist --enable-cross-compile --target-os=none \
        --arch=x86_32 --cpu=generic --enable-gpl --enable-version3 --disable-avdevice --disable-swresample --disable-postproc --disable-avfilter \
        --disable-programs --disable-logging --disable-everything --enable-avformat --enable-decoder=hevc --enable-decoder=h264 --enable-decoder=aac \
        --disable-ffplay --disable-ffprobe --disable-asm --disable-doc --disable-devices --disable-network --disable-hwaccels \
        --disable-parsers --disable-bsfs --disable-debug --enable-protocol=file --enable-demuxer=mov --enable-demuxer=flv --disable-indevs --disable-outdevs
if [ -f "Makefile" ]; then
  echo "make clean"
  make clean
fi
echo "make"
make
echo "make install"
make install
cd ${player_path}
./build_decoder_wasm.sh
