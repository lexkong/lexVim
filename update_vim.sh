basepath=$(cd `dirname $0`; pwd)
dir="/tmp/lexVim"
vim_package="vim1.0.7.tar.gz"


# do some prepare job
[ -d $dir ] && rm -rf $dir
mkdir $dir

tar -xvzf packages/${vim_package} -C $dir/ &>/dev/null

if [ $? -ne 0 ];then
    echo unpack packages/${vim_package} failed
    exit 1
fi

flag=0

cd $basepath
[ -f latest/.vimrc ] && {
    echo update latest/.vimrc
    cp -f latest/.vimrc latest/vimrc.old
    mv latest/.vimrc $dir/ -f
    flag=1
}

[ ! -d $dir/.vim/bundle ] && mkdir $dir/.vim/bundle

cd $basepath
[ -f latest/vim-go-master.zip ] && {
   echo update latest/vim-go-master.zip
   mv latest/vim-go-master.zip $dir/.vim/bundle
   cd $dir/.vim/bundle
   unzip vim-go-master.zip &>/dev/null
   if [ $? -ne 0 ];then
       echo unzip vim-go-master.zip failed
       exit 1
   fi

   [ -d vim-go ] && rm -rf vim-go
   mv vim-go-master vim-go
   flag=1
}

cd $basepath
[ -f latest/Vundle.vim-master.zip ] && {
    echo update latest/Vundle.vim-master.zip
    mv latest/Vundle.vim-master.zip $dir/.vim/bundle
    cd $dir/.vim/bundle
    unzip Vundle.vim-master.zip &>/dev/null
    if [ $? -ne 0 ];then
        echo unzip Vundle.vim-master.zip failed
        exit 1
    fi

    [ -d Vundle.vim ] && rm -rf Vundle.vim
    mv Vundle.vim-master Vundle.vim
    flag=1
}

#if [ $flag -eq 1 ];then
#    echo update ${vim_package}
#else
#    echo no need to update ${vim_package}
#    exit 0
#fi

cd $dir/
tar -cvzf ../${vim_package} .[!.]* &>/dev/null
if [ $? -ne 0 ];then
    echo tar packages/${vim_package} failed
    exit 1
fi

cp $dir/../${vim_package}  $basepath/packages/

cd $basepath/../
tar -cvzf lexVim.tar.gz lexVim/*  &>/dev/null
cp lexVim.tar.gz $basepath/
