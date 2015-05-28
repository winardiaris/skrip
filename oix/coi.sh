export archi="$1"
export opsi="$2"

function salin {
  if [ ! -d "backup" ]; then
    mkdir "backup"
  fi
 
  a="`date '+%F-%H-%M-%S'`"
  b="backup/$archi-$a"
  mkdir "$b"
 
  echo "membackup berkas lama .........."
  cp -rf *$archi*.iso "$b/"
}

case $opsi in
   -b)
       salin;;
esac


echo "memulai zsync .............. "
rm -rf *$archi*sum*
zsync "http://cdimage.blankonlinux.or.id/blankon/livedvd-harian/current/tambora-desktop-$archi.iso.zsync"
wget "http://cdimage.blankonlinux.or.id/blankon/livedvd-harian/current/tambora-desktop-$archi.iso.md5sum"
wget "http://cdimage.blankonlinux.or.id/blankon/livedvd-harian/current/tambora-desktop-$archi.iso.sha1sum"
wget "http://cdimage.blankonlinux.or.id/blankon/livedvd-harian/current/tambora-desktop-$archi.iso.sha256sum"


echo "pengecekan md5sum ............ "
md5sum -c "tambora-desktop-$archi.iso.md5sum"
echo ""
echo ""
echo "pengecekan sha1sum ............ "
sha1sum -c "tambora-desktop-$archi.iso.sha1sum"
echo ""
echo ""
echo "pengecekan sha256sum ............ "
sha256sum -c "tambora-desktop-$archi.iso.sha256sum"



