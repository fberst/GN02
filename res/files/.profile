if /home/rbe/xcsoar_gn01 -800x480 -fly -datapath=/home/rbe/XCSoarData; then
  printf'Startup of XCSoar successful\n'
elif /home/rbe/xcsoar_backup -800x480 -fly -datapath=/home/rbe/XCSoarData; then
  printf'Startup of XCSoar-Backup-File successful\n'
else
  /home/rbe/.xcsoar_backup -800x480 -fly -datapath=/home/rbe/XCSoarData
fi
sudo poweroff
