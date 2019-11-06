#!/bin/bash

# ��װ������
# ipvs����ipset��ntp��֤������ϵͳʱ��ͬ��
sudo yum install -y epel-release
sudo yum install -y conntrack ntpdate ntp ipvsadm ipset jq iptables curl sysstat libseccomp wget

# �رշ���ǽ,�������ǽ��������Ĭ��ת������
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo iptables -F && iptables -X && iptables -F -t nat && iptables -X -t nat
sudo iptables -P FORWARD ACCEPT

# �ر�swap��������������� swap ������kubelet ������ʧ��
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab 

# �ر�SELinux
sudo setenforce 0
sed -i 's/SELINUX=permissive/SELINUX=disabled/' /etc/sysconfig/selinux
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

# �ر�dnsmasq
# sudo systemctl stop dnsmasq
# sudo systemctl disable dnsmasq

# �����ں�ģ��
modprobe ip_vs_rr
modprobe br_netfilter

# ����ϵͳʱ��
timedatectl set-timezone Asia/Shanghai

# ����ǰ�� UTC ʱ��д��Ӳ��ʱ��
timedatectl set-local-rtc 0

# ����������ϵͳʱ��ķ���
systemctl restart rsyslog 
systemctl restart crond




