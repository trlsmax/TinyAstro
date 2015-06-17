xgettext -d OpenSkyImager -o OpenSkyImager.pot -kC_:1c,2 --add-comments=/ -F --from-code=utf-8 --package-name=OpenSkyImager --package-version=0.5.0 --copyright-holder=2013\ JP\ \&\ C\ Software --msgid-bugs-address=gspezzano@gmail.com -f srclist.txt

xgettext -d OpenSkyImager -o OpenSkyImager.pot -kC_:1c,2 --join-existing --add-comments=/ -F --from-code=utf-8 --package-name=OpenSkyImager --package-version=0.5.0 --copyright-holder=2013\ JP\ \&\ C\ Software --msgid-bugs-address=gspezzano@gmail.com -f srclist.txt

msgfmt OpenSkyImager.po -o OpenSkyImager.mo


strace -e trace=open ./gtk3Imager &> pippo.txt
