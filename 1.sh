#backup repo
cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo-bk
# mirrors.ustc.edu.cn  
sudo sed \
-e 's|^mirrorlist=|#mirrorlist=|g' \
-e 's|^#baseurl=http://mirror.centos.org/centos|baseurl=https://mirrors.ustc.edu.cn/centos|g' \
-i.bak \
/etc/yum.repos.d/CentOS-Base.repo
yum clean all
yum makecache
#install softwall
yum update -y
yum install epel* -y
yum install unzip wget vim -y
yum install net-tools -y
yum install java-1.8.0-openjdk-devel.x86_64 -y
yum install numactl -y 
yum install libaio -y
yum install git -y    
#stop seliux
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
#download confluence bin
mkdir -p /root/software && cd "$_"
wget https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-7.4.8-x64.bin
#remove maria*
rpm -qa | grep mariadb* | awk '{cmd="yum -y remove "$1;system(cmd)}'
#mysql install 5.7
git clone https://github.com/tamageci86/mysql57.list && cd mysql57.list
wget -i mysql57.list && rpm -ivh mysql-community-client* mysql-community-libs* mysql-community-common* mysql-community-server-*
#start mysql
systemctl start mysqld
systemctl enable mysqld
#reboot sys
reboot
