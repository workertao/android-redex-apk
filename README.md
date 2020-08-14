# redex-apk
## redex安装使用

1，xcode-select --install

2，brew install autoconf automake libtool python3

3，brew install boost jsoncpp

4，git clone https://github.com/facebook/redex.git

5，cd redex

6，git submodule update --init

7，autoreconf -ivf && ./configure && make -j4

8，sudo make install

9，正常执行：redex dev-v2.2.0-07-28.apk -o output.apk 

10，报错：找不到zipline执行：ANDROID_SDK=/Users/a/Library/Android/sdk redex input.apk -o output.apk

redex完的apk是没有签名的，手动签名

11，添加签名：jarsigner -verbose -keystore keystore文件路径 -signedjar 签名后生成的apk路径 待签名的apk路径 别名

## shell批量redex和签名

``bash redexapk.sh
``
