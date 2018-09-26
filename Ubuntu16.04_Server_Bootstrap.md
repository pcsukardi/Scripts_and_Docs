## Ubuntu Server Standard Configuration

### Security

**Follow** [these](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-16-04) directions to bootstrap the server. (The step for setting up UFW _may_ need to be omitted for certain projects.)  Reference [this](https://www.digitalocean.com/community/tutorials/7-security-measures-to-protect-your-servers) page for some security hardening tips.  

**First run**, this command to get the server up to date, `sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install -f $$ sudo apt autoremove -y`  

**Download, install and run** an audit using [this](https://github.com/CISOfy/lynis) utility. This is Lynis an auditing tool and is a great way to lock down any holes in server security before any extra programs are installed.  

**Install** apt-show-versions, `sudo apt-get install apt-show-versions` and the debsums utility, `sudo apt-get install debsums`. These are tools to track versions of packages installed on the system.    

**Secure shared memory**, Shared memory can be used in an attack against a running service, so it is always best to secure that portion of memory. You can do this by modifying the /etc/fstab file.  


First, you must open the file for editing by issuing the command:  

`sudo vim /etc/fstab`  

Next, add the following line to the bottom of that file:  

`tmpfs /run/shm tmpfs defaults,noexec,nosuid 0 0`  

**Enable ssh login for specific users**,You'll probably spend a good amount of time secure shelling into the Ubuntu Server. Because you'll need to enter that server via ssh, you do not want to leave it wide open.  

One thing you should do is enable ssh login for specific users. Let's say you want to only allow secure shell entry for the users kaden, peter, and ari.  

1. Open a terminal window.
2. Open the ssh config file for editing with the command `sudo vim /etc/ssh/sshd_config`  
3. At the bottom of the file, add the line `AllowUsers kaden peter ari`  
4. Save and close the file.  
5. Restart sshd with the command `sudo service ssh restart`  

**Add a security login banner**, Adding a security login banner might seem like it would have zero effect on the server, but if an unwanted user gains access to your server, and if they see you've taken the time to set up a login banner warning them of consequences, they might think twice about continuing. Yes, it's purely psychological, but it's such an easy step, it shouldn't be overlooked. Here's how to manage this.  

Create your new banner by following these steps.  

1. Open a terminal window.  
2. Issue the command `sudo vim /etc/issue.net`  
3. Edit the file to add a suitable warning.  
4. Save and close the file.  

Next, we need to disable the banner message from motd. To do this you must open a terminal and issue the command sudo nano /etc/pam.d/sshd. With this file open for editing, comment out the following two lines (adding a # to the beginning of each line):  

`session optional pam_motd.so motd=/run/motd.dynamic`  
`session optional pam_motd.so noupdate`  

Now open the /etc/ssh/sshd_config in your favorite text editor and comment out the line:  

`Banner /etc/issue.net`  


Save and close that file.  

Finally, restart the ssh server with the command:  


`sudo service ssh restart`  

At this point, anytime someone logs into your server, via ssh, they will see your newly added banner displayed to warn them you are watching.  

**Harden the networking layer**, There is a very simple way to prevent source routing of incoming packets (and log all malformed IPs) on the Ubuntu Server. Open a terminal window, issue the command `sudo vim /etc/sysctl.conf`, and uncomment or add the following lines:  

`# IP Spoofing protection`  
​`net.ipv4.conf.all.rp_filter = 1`  
​`net.ipv4.conf.default.rp_filter = 1`  
​

​`# Ignore ICMP broadcast requests`  
​`net.ipv4.icmp_echo_ignore_broadcasts = 1`  
​

​`# Disable source packet routing`  
​`net.ipv4.conf.all.accept_source_route = 0`  
​`net.ipv6.conf.all.accept_source_route = 0`  
​`net.ipv4.conf.default.accept_source_route = 0`  
​`net.ipv6.conf.default.accept_source_route = 0`  

​
`​# Ignore send redirects`  
​`net.ipv4.conf.all.send_redirects = 0`  
​`net.ipv4.conf.default.send_redirects = 0`  

​
​`# Block SYN attacks`  
​`net.ipv4.tcp_syncookies = 1`  
`​net.ipv4.tcp_max_syn_backlog = 2048`  
​`net.ipv4.tcp_synack_retries = 2`  
​`net.ipv4.tcp_syn_retries = 5`  

​
​`# Log Martians`  
​`net.ipv4.conf.all.log_martians = 1`  
​`net.ipv4.icmp_ignore_bogus_error_responses = 1`  

​
​`# Ignore ICMP redirects`  
​`net.ipv4.conf.all.accept_redirects = 0`  
​`net.ipv6.conf.all.accept_redirects = 0`  
​`net.ipv4.conf.default.accept_redirects = 0`  
`​net.ipv6.conf.default.accept_redirects = 0`  
​

​`# Ignore Directed pings`  
​`net.ipv4.icmp_echo_ignore_all = 1`  


Save and close the file, and then restart the service with the command `sudo sysctl -p`  

**Prevent IP spoofing**, This one is quite simple and will go a long way to prevent the server's IP from being spoofed. Open a terminal window and issue the command `sudo vim /etc/host.conf`, With this file open for editing, it will look like:  

`# The "order" line is only used by old versions of the C library.`  
​`order hosts,bind`  
​`multi on`  

Change the content of this file to:  

`# The "order" line is only used by old versions of the C library.`  
​`order bind,hosts`  
​`nospoof on`  


###Monitoring  

**Install Fail2Ban**, This is a utility that monitors logs and gives a layer of protection against brute force attacks on the server.  


Open a Terminal and enter the following :  

`sudo apt-get install fail2ban`  

After installation refer to [this](https://chasmathis.com/2017/10/28/fail2ban-ubuntu-16-04/) guide or [this](https://www.booleanworld.com/protecting-ssh-fail2ban/) guide to get it up and running with basic rules.  


**Install OSSEC**, This is a Host Intrusion Detection System that is easy to install and configure and is also light on server resources. Use [this](https://2code-monte.co.uk/2017/11/05/install-ossec-on-ubuntu-16-04-to-monitor-multiple-servers/) guide or the documentation [here](https://www.ossec.net/docs/manual/installation/index.html) to get OSSEC installed and configured.  

**Check for rootkits - RKHunter and CHKRootKit.**, Both RKHunter and CHKRootkit basically do the same thing - check your system for rootkits. No harm in using both. Open a Terminal and enter the following :  

`sudo apt-get install rkhunter chkrootkit`  


To run chkrootkit open a terminal window and enter :  

`sudo chkrootkit`  

To update and run RKHunter. Open a Terminal and enter the following :  

`sudo rkhunter --update`  
`sudo rkhunter --propupd`  
`sudo rkhunter --check`  

**Scan open ports - Nmap.**, Nmap ("Network Mapper") is a free and open source utility for network discovery and security auditing. Open a Terminal and enter the following :  

`sudo apt-get install nmap`  

Scan your system for open ports with :  

`nmap -v -sT localhost`  

SYN scanning with the following :  

`sudo nmap -v -sS localhost`  

**Analyse system LOG files - LogWatch.** Logwatch is a customizable log analysis system. Logwatch parses through your system's logs and creates a report analyzing areas that you specify. Logwatch is easy to use and will work right out of the package on most systems. Open a Terminal and enter the following :  

`sudo apt-get install logwatch libdate-manip-perl`  

To view **logwatch output** use less :  

`sudo logwatch | less`  


To **email a logwatch report for the past 7 days** to an email address, enter the following and replace mail@domain.com with the required email. :  

`sudo logwatch --mailto mail@domain.com --output mail --format html --range 'between -7 days and today'`  

**Uninstall Apparmor**, AppArmor is a Linux Security Module implementation of name-based mandatory access controls. AppArmor confines individual programs to a set of listed files and posix 1003.1e draft capabilities.  

This may be a good thing with a build that has many users logging in that use different pieces of software. In the case of a dedicated web server it is not really needed, it can cause alot of guff when trying to troubleshoot other issues when things go wrong.

This concludes the document, if their is anything anybody wants to add feel free :) <3












































