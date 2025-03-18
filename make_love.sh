#! /bin/bash
# get project name
exec="${PWD##*/}"
function Love()
{
    gamename=$1
    if [ -f *.love ];then rm *.love ;fi
    cd src
    for v in * ; do
        if [ -f $v ] ; then 
            zip -o ../game.zip $v
        fi
        if [ -d $v ] ; then
            echo v dir: $v
            for n in $v/* ; do
                zip -o ../game.zip $n
                if [ -d $n ] ; then
                    for j in $n/* ; do
                        zip -o ../game.zip $j
                    done
                fi
            done
        fi
    done
    cd ..
    mv game.zip ${gamename}.love;  
}
function Win()
{
    loveexe_path="/home/oblerion/GD/love-11.3-win32/LOVE2D";
 
    love_name=$1
    cat ${loveexe_path}/love.exe $love_name.love > ${love_name}.exe
    echo ">> $love_name.love to ${love_name}.exe ok"
    if [ ! -d "${love_name}" ];then mkdir ${love_name} ;fi
    if [ ! -f "${love_name}/love.dll" ];then cp ${loveexe_path}/*.dll ${love_name}/. ;fi 
    if [ -f "${love_name}.exe" ];then mv ${love_name}.exe ${love_name}/. ;fi
}
function Linux()
{
	cat /usr/bin/love $1.love > $1_linux
	chmod a+x ./$1_linux
}
function Web()
{
	./web_kit/love-js.sh $1.love --release;
}

Love $exec;
Linux $exec;
Win $exec;
Web $exec;
