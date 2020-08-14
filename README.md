# redex-apk

## 必看

本实例仅支持mac os，windows的同学请忽略！windows点这：https://fbredex.com/docs/installation

redex是Facebook开源的工具，通过对字节码进行优化，以减小Android Apk 大小，同时提高 App启动速度，activity的页面跳转速度。好是好，只是在多渠道打包的时候就费劲了，需要手动对每个渠道的apk进行redex命令，一切都是为了省事才有了这个脚本，下边是redex的安装和使用事例，

## mac redex安装使用

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

## shell脚本批量redex和签名

bash redexapk.sh

