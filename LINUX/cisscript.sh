#!/bin/bash

FSTAB=/etc/fstab

msg1() {
    echo -n "==> $@ ..."
}

msg2() {
    if [ -z $1 ]; then
        echo "done"
        return
    fi
    echo $1
}

filesystemDisable() {
    modprobe -n -v $1
    lsmod | grep $1 > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        touch /etc/modprobe.d/$1.conf
        echo "install $1 /bin/true" > /etc/modprobe.d/$1.conf
        rmmod $1
    fi
}



tmphardlinkSecure(){
    msg1 "fixing fstab for noexec, nodev"
    cat $FSTAB | grep -v /tmp > /tmp/fstab.$$
    echo "tmpfs /tmp tmpfs defaults,rw,nosuid,nodev,noexec,relatime 0 0" >> /tmp/fstab.$$
    mv /tmp/fstab.$$ $FSTAB
    msg2
}



checkPartition(){
    echo "\s$1\s"
    mount | grep -E "\s$1\s" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        msg1 "$1 isnt a seperate partition"
        msg2 skiping
        return 1
    fi
    return 0
}



fixfstab() {
    dir=$1
    option=$2
    line=$(cat $FSTAB | grep "$dir")
    echo $line | grep "$option" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        cat $FSTAB | grep -v $dir > /tmp/fstab.$$
        line=$(echo $line | awk -v option=$option '{$4=$4","option; print}')
        echo $line >> /tmp/fstab.$$
        mv /tmp/fstab.$$ $FSTAB
        mount -o remount,$option $dir
    fi
    
}


checkfixFstab(){
    dir="$1"
    options="$2"
    checkPartition $dir
    if [ $? -eq 0 ]; then
        for option in $options; do
            fixfstab $dir $option
        done
    fi
}

# filesystemDisable cramfs
# filesystemDisable freevxfs
# filesystemDisable jffs2
# filesystemDisable hfs
# filesystemDisable hfsplus
# filesystemDisable squashfs
# filesystemDisable udf

# tmphardlinkSecure

checkPartition /var
checkPartition /var/log
checkPartition /var/log/audit

checkfixFstab /var/tmp "nosuid nodev noexec"
checkfixFstab /home "nodev"
