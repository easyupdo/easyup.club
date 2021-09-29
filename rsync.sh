#########################################################################
# File Name: rsync.sh
# Author: JayGuan
# mail:
# Created Time: 一  7/13 12:11:41 2020
#########################################################################
#!/bin/bash
which "rsync" > /dev/null
if [ $? -eq 0 ]
then
    #echo "rsync is exist"
    rsync -r public/* jay@8.131.241.70:/home/jay/Work/Easyup.club
else
    echo "rsync not exist"
fi

