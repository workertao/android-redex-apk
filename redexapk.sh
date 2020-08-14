#签名地址（你的签名地址）
keyPath=/Users/a/Desktop/code/bjxRecruit/app/bjx_talents.jks
#要签名的apk（可不动）
signApk=redex-unsign-output.apk
#签名密码（你的签名密码）
keyPwd=********
#版本号（可不动）
version=222
#文件名（可不动）
dirName=redexsign
#redex and sign file
redexAndSignFile=/Users/a/Desktop/$dirName$version
#设置本地数组 用来校验渠道（你的渠道数据）
channleArray=("baidu" "oppo" "tencent" "qh360" "mi" "meizu" "vivo" "huawei" "samsung" "others" "sougou" "ali" "dev")
#项目路径（你的项目地址）
apkpath=/Users/a/Desktop/code/bjxRecruit/app
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
        jarsigner -verbose -keystore $keyPath -storepass $keyPwd -keypass $keyPwd -signedjar $outputApkName $signApk $keyPwd
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
    #遍历本地数组
    for channle in ${channleArray[@]}
    do
    #遍历app目录
        for fileName in $(ls /$apkpath)
        do
        if test $fileName = $channle
        then
            log "当前渠道相同："$fileName
            #找到相同的目录后，cd到文件的release目录下
            #{}||{}左边执行失败，执行右边
            {
                # try
                cd $fileName/release
            } || {
                # catch
                cd ../..
                cd $fileName/release
            }
            findAndRedexApk $pwd
        fi
        done
    done
}
#模拟创建一个main方法
function main(){
    #创建文件夹 用来存储redex后的文件
    createFile
    checkChannleAndApk
}
main





