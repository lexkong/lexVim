#!/bin/bash      
#########################################################################
# File Name: config.sh
# Author: wangbin
# mail: 772384788@qq.com
# Created Time: Thu 06 Nov 2014 06:31:50 PM CST
#########################################################################
#Define Path    
VIMRC=~/.vimrc 
VIM_FILE=./packages/vim*

function prompt() 
{
    tar -zxf ${VIM_FILE} -C ~/
    read -p "Please input your name:" AUTHOR      
    sed -i "s/Bill/$AUTHOR/g" $VIMRC     
    read -p "Please input your E-mail:" MAIL_AUTHOR     
    sed -i "s/XXXXXXX@qq.com/$MAIL_AUTHOR/g" $VIMRC     
    cd ./packages/

}

# install_ctags $install_dir
function install_ctags() 
{
    tar -zxf ctags.tar.gz -C "$1"
    chmod 755 "$1/ctags"
}

function addBash()
{
    CK_VIM=`grep "vi='vim'" ~/.bashrc | wc -l`
    if [ "w${CK_VIM}" = "w0" ]
    then
        echo " " >> ~/.bashrc
        echo "alias vi='vim'" >> ~/.bashrc
    fi 
}

# install_bin $install_dir
function install_bin()
{
    # install go bin
    if [ ! -d "$1" ];then
        mkdir -p "$1"
    fi       

    for f in $(ls ../vim-go-ide-bin/)
    do       
        cp -f ../vim-go-ide-bin/$f "$1/"
    done  
}

#deine Vim_config     
function Vim_config ()      
{   
    clear
    if [ `id -u` -eq 0 ];then
        ctagBin="/usr/bin"
        installBin="$HOME/bin"
    else
        ctagBin="$HOME/bin"
        installBin="$HOME/bin"
    fi

    prompt
    install_ctags $ctagBin
    addBash
    install_bin $installBin

    . ~/.bashrc
    echo "this vim config is success !" 
    exit 0
}      

clear 
echo " " 
echo -e "    \033[44;37m========================================================================\033[0m" 
echo -e "    \033[44;33m|------------------------------Description------------------------------\033[0m" 
echo -e "    \033[44;37m========================================================================\033[0m" 
echo -e "    \033[33m     \033[0m" 
echo -e "    \033[33m     the confing of vim is for admin\033[0m" 
echo -e "    \033[33m     \033[0m" 
echo -e "    \033[44;37m=========================================================================\033[0m" 
echo " "
echo " "

VIM_PATH=$(cd `dirname $0`; pwd)
cd ${VIM_PATH}

PS3="Please input a number":              
select i in  "Vim_config" "quit"
do 
    case $i in       
        Vim_config )      
        Vim_config      
        ;;
        quit)
        exit $?
        ;;
        *)      
        echo      
        echo -e "\033[44;37mPlease Insert :Vim_config(1)|Exit(2)\033[0m" 
        echo      
        ;;      
    esac      
done 
