---
title: shell
date: 2020-07-22 15:36:31
tags: shell
published: false
---

### shell
```c
#!/bin/bash
#!/bin/bash
file1name=
file2name=

usage(){
  echo "usage:根据key映射两个文件"
  echo "xx.exe file1 file2"
  exit
}
```
<!--more-->
```c


function map(){
  FILES1=()
  while read line
  do
    let num1+=1;
    #echo LINE:$line
    FILES1[$num1]=$line;
    #echo FILES1[$num1]:${FILES1[$num1]}
    #done < result_partc_retell_2.4.0_linux.txt
  done < ${file1name}

  echo "file1 size:"${#FILES1[@]}
  echo F:${FILES1[1]}
  #获取第二个文件>array 提高io效率
  FILES2=()
  while read line
  do
    let num2+=1;
    #echo LINE:$line
    FILES2[$num2]=$line;
    #echo FILES2[$num2]:${FILES2[$num2]}
    #done < result_partc_retell_android.txt
  done < ${file2name}

  echo "file2 size:"${#FILES2[@]}

  #cat result_partc_retell_android.txt | while read line1
  for ((i=1;i<=${#FILES1[@]};i++))
  do
    let num+=1;
    #echo "!!!!!!!!!!!!!!!!!!!!"${FILES1[$i]}
    wav=`echo ${FILES1[$i]}|awk -F ' ' '{print $1}'`
    #echo "####wav1111111111111111111111:"$wav
    OLD_IFS="$IFS"
    IFS="/"
    array=($wav)
    IFS="$OLD_IFS"
    #echo "length:"${#array[@]}
    id1=${array[${#array[@]} - 2]}"/"${array[${#array[@]} - 1]}
    #echo "ID1:"$id1

    for ((j=1;j<=${#FILES2[@]};j++))
    do
      wav2=`echo ${FILES2[$j]}|awk -F ' ' '{print $1}'`
      #echo "####wav2:"$wav2
      OLD_IFS="$IFS"
      IFS="/"
      array2=($wav2)
      IFS="$OLD_IFS"
      #echo "length:"${#array2[@]}
      id2=${array2[${#array2[@]} - 2]}"/"${array2[${#array2[@]} - 1]}
      #echo "ID2:"$id2
      if [ ${id1} == ${id2} ];then
        echo "ID1:"$id1
        echo "ID2:"$id2
        echo "#################id1 = id2  num="$num;
        echo -e  ${FILES1[$i]} " " ${FILES2[$j]}  >> MAP_OUT.txt
        break;
      fi
    done


  done
}


if [ $# -eq 2 ];then
  #echo "File1:"$1;
  #echo "File2:"$2;
  file1name=$1;
  file2name=$2;
  echo "Map file is MAP_OUT.txt"
  map
else
  usage
fi
```

### 根据条件筛选进程并杀死
```c
ps -ef | grep '/home/liping/work' | while read line
do
  name=`echo $line | awk '{print $1}'`;
  id=`echo $line | awk '{print $2}'`;
  #echo "####"$name"  ""ID"$id
  if [ $name == 'guanxia+' ];then
    echo "AAAA"$line
#kill -9 $id
  fi
done
```

### shell 命令行工具框架

```c
function usages() {
  echo "Help:"
  echo "./x.sh [build_type]"
  echo "--name=          #Docker image name"
  echo "--tag=           #Docker image tag"
  echo "--file=          #Files used to generate docker images"
  echo "--version        #Get version"
  echo "--help           #This help"

}
function rel2abs {
  if [ ! -z "$arg" ]; then
    local retval=`cd $arg 2>/dev/null && pwd || exit 1`
    echo $retval
  fi
}
function read_dirname {
  local dir_name=`expr "X$arg" : '[^=]*=\(.*\)'`;
  local retval=`rel2abs $dir_name`
  [ -z $retval ] && echo "Bad option '$arg': no such directory" && exit 1;
  echo $retval

}
function mkimage(){
  echo "Building with:" >> $build_logfile
  echo "images name:$docker_image_name" >> $build_logfile
  echo "images tag:$docker_image_tag" >> $build_logfile
  echo "images used dockerfile:$docker_dockerfile" >> $build_logfile
  echo "docker build -t ${docker_image_name_kaldi}:${docker_image_tag_kaldi} -f ${docker_dockerfile_kaldi} . "
  docker build -t ${docker_image_name_kaldi}:${docker_image_tag_kaldi} -f ${docker_dockerfile_kaldi} .
}

docker_image_name_kaldi=lsx/poes
docker_image_tag_kaldi=1.1-add
docker_dockerfile_kaldi=./Dockerfile

if [ $# == 0 ]
then
  echo "--help get help"
  echo "Build whit default [Y/N]"
  read what
  if [ $what == "Y" ]
  then
    echo "Building with:"
    echo "images name:$docker_image_name"
    echo "images tag:$docker_image_tag"
    echo "images used dockerfile:$docker_dockerfile"
    mkimage
  else
    echo "Exit!"
  fi
else

  for arg in $@
  do
    echo $arg
    case "$arg" in
      --help)
        echo "usage"
        usages
        exit 0
        ;;
      --name=*)
        docker_image_name_kaldi=$(expr "X$arg" : '[^=]*=\(.*\)')
        echo $docker_image_name_kaldi
        ;;
      --tag=*)
        echo "tag"
        docker_image_tag_kaldi=$arg
        ;;
      --file=*)
        echo "file"
        docker_dockerfile_kaldi=$arg
        ;;
      --version)
        echo "version:v0.1"
        ;;
      *) echo "no $arg"
    esac

  done


  #git clone --depth 1 -b 5.4 https://github.com/kaldi-asr/kaldi.git kaldi-5.4

  gitlab_username=
  gitlab_password=
  gitlab_path=
  gitlab_protocol=

  :<<!
  if [ $gitlab_protocol = 'ssh' ]
  then
    git clone --depth=1 -b lsx-ases-2.1 http://${gitlab_username}:${gitlab_password}@${gitlab_path} polly
  else
    echo "HTTP protocol does not support automatic cloing!!! Please git clone it by youself."
  fi
!

# make lsx/kaldi-5.4 image
echo $docker_dockerfile_kaldi
mkimage

fi

```
