#!/bin/bash
#
# Virtual Function
# Detect if a server is virtual or not, without root access
#
# 1. check for "virtual" in /var/log/dmesg
# 2. check for "virtual" in /proc/scsi/scsi
# 3. check for "dmi" in dmesg
#
# Work in progress - not working yet.
virt () {
        if [ -e /var/log/dmesg ]; then
                echo "/var/log/dmesg exists"
                DMESG1=`grep -i virtual /var/log/dmesg`
                if [ -n "$DMESG1" ]; then
                echo "First test passed"
                        if [ -e /proc/scsi/scsi ]; then
                        SCSI=`grep -i virtual /proc/scsi/scsi`
                                if [ -n "$SCSI" ]; then
                                echo "Second test passed"
                                        DMESG2=`dmesg | grep -i dmi |grep -i virtual`
                                                if [ -n "$DMESG2" ]; then
                                                        echo "Most likely virtual"
                                                elif [ -z "$DMESG2" ]; then
                                                        echo "Not Virtual"
                                                fi
                                else
                                        echo "Not Virtual"
                                fi
                else
                        echo "Not Virtual"
                fi
        fi
      fi
}

virt

virtx () {
  if [ -e /var/log/dmesg ]; then
    echo "Checking dmesg..."
    DMESG1=`grep -i virtual /var/log/dmesg`
    if [ -n "$DMESG1" ]; then
      echo "Passed first dmesg test"
      if [ -e /proc/scsi/scsi ]; then
        echo "Checking scsi devices..."
        SCSI=`grep -i virtual /proc/scsi/scsi`
        if [ -n "$SCSI" ]; then
          echo "Passed scsi device check"
            if hash dmesg 2>/dev/null; then
              echo "Checking dmi..."
              DMESG2='dmesg | grep -i dmi |grep -i virtual'
                if [ -n "$DMESG2" ]; then
                  echo "Virtual"
                elif [ -z "$DMESG2" ]; then
                  echo "Not Virtual"
                fi
            fi
        fi
      fi
    fi
  fi
}
