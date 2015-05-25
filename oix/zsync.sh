export jahitan="$1"
export archi="$2"

echo "menghapus berkas lama .............. "
rm -rf *sum*
zsync "http://cdimage.blankonlinux.or.id/blankon/livedvd-harian/$jahitan/tambora-desktop-$archi.iso.zsync"
wget "http://cdimage.blankonlinux.or.id/blankon/livedvd-harian/$jahitan/tambora-desktop-$archi.iso.md5sum"
wget "http://cdimage.blankonlinux.or.id/blankon/livedvd-harian/$jahitan/tambora-desktop-$archi.iso.sha1sum"
wget "http://cdimage.blankonlinux.or.id/blankon/livedvd-harian/$jahitan/tambora-desktop-$archi.iso.sha256sum"


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



