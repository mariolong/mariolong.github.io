.. title: setup CUPS for Fuji-Xerox-cp105b
.. slug: setup-cups-for-fuji-xerox-cp105b
.. date: 2016-11-02 01:29:47 UTC
.. tags:
.. category:
.. link:
.. description:
.. type: text



 9930  systecmctl start cups
 9931  systemctl start cups
 9932  make install
 9933  sudo make install
 9934  sudo updatedb
 9935  locate cups
 9936  locate cups|grep service
 9937  systemctl start org.cups.upsd.service
 9938  systemctl start org.cups.cupsd.service
 9939  tail -n 100 -f /var/log/cups/error_log\n
 9940  make cups
 9941  lsblk
 9942  lsusb
 9943  ls usb
 9944  ls usb://
 9945  lpinfo
 9946  lpinfo #
 9947  lpinfo -v
 9948  lpinfo -v #
 9949  sudo lpinfo -v #
 9950  sudo lpinfo -m|grep cp105
 9951  lpstate
 9952  lpstates
 9953  lpstat
 9954  lpstat -h
 9955  lpoptions -h
 9957  lpinfo -v #
 9958  sudo lpinfo -v #
 9959  lpoptions
 9960  lpoptions -l
 9961  lpoptions -a
 9962  lpoptions -d "FUJI XEROX/DocuPrint CP105 b"
 9963  sudo lpinfo -m
 9964  sudo lpinfo -m|grep -i cp105
  967  sudo lpadmin -p FX_CP105b -E -v "usb://FUJI%20XEROX/DocuPrint%20CP105%20b?serial=000793" -m lsb/usr/foo2zjs/Fuji
_Xerox-DocuPrint_CP105.ppd.gz
 9968  lpoptions -d FX_CP105b\n
 9969  sudo lpoptions -d FX_CP105b\n
 9971  lpoptions -p FX_CP105b -o PageSize=A4
 9972  lpoptions -p FX_CP105b -l
 9973  echo "Hello, world | lpr -p #
 9974  sudo systemctl enable org.cups.cupsd.service
 9976  systemctl status org.cups.cupsd.service
