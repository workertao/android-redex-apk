
#签名地址
keyPath=/Users/a/Desktop/code/yumili/app/yml.jks
#要签名的apk
signApk=redex-unsign-output.apk
#签名密码
keyPwd=xxx
keyAlias=xxx
#版本号
version=227
#文件名
dirName=redexsign
#redex and sign file
redexAndSignFile=/Users/a/Desktop/$dirName$version
#项目路径
apkpath=/Users/a/Desktop/code/yumili/app/release
#cd
cd $apkpath

#创建输出目录
function createFile(){
    parentDir=$redexAndSignFile
    log $parentDir
    if [ ! -d "$parentDir" ];then
    mkdir $parentDir
        echo "创建文件夹成功"
    else
        echo "文件夹已经存在"
    fi
}
#打印log
function log(){
    echo "打印--"$1 $2
}
#打印当前文件下的所有子文件名  放在最上边要不然下边调用不到
function printList(){
    for child in $(ls $1)
    do
    log "子目录："$child
    done
}
#检测那个是apk文件,并且redex
function findAndRedexApk(){
    for child in $(ls $1)
    do
    apk=".apk"
    if [[ $child == *$apk* ]]
    then
        log "当前目录下的apk："$child
        log "redex 开始"
        redex $child -o $signApk
        log "redex 结束"
        log "sign 开始"
        outputApkName=redex-sign-$child
        jarsigner -verbose -keystore $keyPath -storepass $keyPwd -keypass $keyPwd -signedjar $outputApkName $signApk $keyAlias
        log "sign 结束"
        log "将redex签完名的文件移动到指定目录 开始"
        mv $outputApkName $redexAndSignFile
        log "success"
        return
    fi
    done
}
#双重for循环检测本地的渠道和apk
function checkChannleAndApk(){
   findAndRedexApk $pwd
}
#模拟创建一个main方法
function main(){
    #创建文件夹 用来存储redex后的文件
    createFile
    checkChannleAndApk
}
main





